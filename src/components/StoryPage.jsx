/**
 * StoryPage.jsx — 스토리 메인 화면
 *
 * 역할:
 *  - Supabase에서 현재 챕터의 씬(scenes) + 선택지(choices) 데이터 로드
 *  - 씬 텍스트를 한 글자씩 타이핑 애니메이션으로 표시
 *  - 선택지 클릭 시 choices.next_scene_id 로 해당 씬으로 이동 (분기 처리)
 *    → next_scene_id === null 이면 챕터 완료
 *  - 씬 전환 시 배경 이미지·캐릭터 교체, BGM 전환(동일 URL이면 유지)
 *  - 경로 기준 진행도: 방문한 씬 수 / (방문 씬 + 남은 최장 경로)
 *
 * 효과음 (Web Audio API, 외부 파일 없이 합성):
 *  - 타이핑: 화이트노이즈 + 밴드패스 (양피지 긁는 소리)
 *  - 호버:   520Hz 사인파 ("틱")
 *  - 선택:   660Hz + 880Hz ("딩동")
 *  - 스킵:   400→320Hz 다운슬라이드 ("슥")
 *
 * BGM 핵심 패턴:
 *  - bgmUrlRef: 씬 전환 시 이전 URL과 비교해 동일하면 재시작하지 않음
 *    (브라우저가 audio.src를 절대경로로 변환하므로 ref로 원본 URL 보관 필요)
 *  - volumeRef: setInterval 내부에서 stale closure 없이 최신 볼륨 읽기
 *  - externalAudioRef: App.jsx에서 스토리 BGM 볼륨을 동기화하기 위한 공유 ref
 *
 * Props:
 *  chapter: number                — 현재 챕터 번호
 *  onComplete()                   — 챕터 완료 콜백
 *  onBack()                       — 뒤로 가기 콜백
 *  onScene(index)                 — 씬 인덱스 변경 시 부모에 알리는 콜백
 *  volume: number                 — 전역 볼륨 (0.0~1.0)
 *  audioRef: React.MutableRefObject — externalAudioRef (App.jsx와 볼륨 동기화용)
 */
import { useState, useEffect, useRef, useCallback, useMemo } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { getStoryData } from '../lib/api'

const FADE_DURATION = 1500 // BGM 페이드인/아웃 소요 시간 (ms)
const TYPING_SPEED  = 40   // 타이핑 속도: 글자 하나당 딜레이 (ms)

export default function StoryPage({ chapter, onComplete, onBack, onScene, volume = 0.7, audioRef: externalAudioRef }) {
  const [scenes, setScenes] = useState([])                   // 챕터 전체 씬 목록
  const [currentSceneIndex, setCurrentSceneIndex] = useState(0) // 현재 씬 배열 인덱스
  const [path, setPath] = useState([])                       // 플레이어가 방문한 씬 id 목록 (경로 기준 진행도용)
  const [isLoading, setIsLoading] = useState(true)
  const [imageLoaded, setImageLoaded] = useState(false)      // 배경 이미지 로드 완료 여부
  const [error, setError] = useState(null)

  // ── 타이핑 애니메이션 상태 ──
  const [displayedText, setDisplayedText] = useState('')     // 현재까지 출력된 텍스트
  const [isTypingDone, setIsTypingDone] = useState(false)    // 타이핑 완료 여부 (선택지 표시 조건)
  const typingTimerRef = useRef(null)                        // setTimeout ID (클린업용)

  // ── 오디오 refs ──
  const audioRef     = useRef(null)  // 현재 재생 중인 BGM Audio 객체
  const fadeTimerRef = useRef(null)  // BGM 페이드 setInterval ID (클린업용)

  // ── 챕터 데이터 로드 ──
  useEffect(() => {
    const loadScenes = async () => {
      setIsLoading(true)
      setError(null)
      try {
        // getStoryData: chapters → scenes → choices 순으로 조회해 씬에 선택지를 붙여 반환
        const data = await getStoryData(chapter)
        if (data && data.scenes && data.scenes.length > 0) {
          setScenes(data.scenes)
          setCurrentSceneIndex(0)
          setPath([data.scenes[0].id]) // 첫 씬을 경로의 시작으로 기록
        } else {
          setError('스토리 데이터를 찾을 수 없습니다.')
        }
      } catch (err) {
        console.error('Failed to load story data:', err)
        setError('스토리를 불러오는 중 오류가 발생했습니다.')
      } finally {
        setIsLoading(false)
      }
    }
    loadScenes()
  }, [chapter])

  const currentScene = scenes[currentSceneIndex]

  // ────────────────────────────────────────────────────────────────
  // 경로 기준 진행도
  // ────────────────────────────────────────────────────────────────

  /**
   * sceneById: id → scene 객체 매핑 (choices 그래프 탐색 시 O(1) 조회용)
   * scenes 배열이 바뀔 때만 재생성.
   */
  const sceneById = useMemo(() => Object.fromEntries(scenes.map(s => [s.id, s])), [scenes])

  /**
   * remainingFrom(startId): 현재 씬에서 엔딩(next_scene_id=null)까지 남은 최장 경로 길이.
   * DFS + 메모이제이션. 순환 방어(inStack)로 무한 루프 방지.
   *
   * 진행도 계산: done / (done + remaining)
   *  - done = path.length (지금까지 방문한 씬 수)
   *  - remaining = remainingFrom(currentScene.id)
   * → 분기를 타도 단조 증가, 엔딩에서 정확히 N/N이 됨.
   */
  const remainingFrom = useCallback((startId) => {
    const memo = {}
    const inStack = new Set()
    const dfs = (id) => {
      const scene = sceneById[id]
      if (!scene || !scene.choices || scene.choices.length === 0) return 0
      if (memo[id] != null) return memo[id]
      if (inStack.has(id)) return 0 // 순환 감지 시 0 반환
      inStack.add(id)
      let best = 0
      for (const c of scene.choices) {
        if (c.next_scene_id != null && sceneById[c.next_scene_id]) {
          best = Math.max(best, 1 + dfs(c.next_scene_id))
        }
      }
      inStack.delete(id)
      memo[id] = best
      return best
    }
    return dfs(startId)
  }, [sceneById])

  // ────────────────────────────────────────────────────────────────
  // 효과음 (Web Audio API)
  // ────────────────────────────────────────────────────────────────

  /**
   * 스킵 효과음: 400Hz → 320Hz 두 음이 빠르게 내려가는 "슥" 느낌.
   * 텍스트 타이핑 스킵 시 재생.
   */
  const playSkipSfx = () => {
    try {
      const ctx = new (window.AudioContext || window.webkitAudioContext)()
      ;[400, 320].forEach((freq, i) => {
        const osc = ctx.createOscillator()
        const gain = ctx.createGain()
        osc.connect(gain); gain.connect(ctx.destination)
        osc.type = 'sine'
        osc.frequency.value = freq
        const t = ctx.currentTime + i * 0.05
        gain.gain.setValueAtTime(0, t)
        gain.gain.linearRampToValueAtTime(0.1, t + 0.01)
        gain.gain.exponentialRampToValueAtTime(0.001, t + 0.1)
        osc.start(t); osc.stop(t + 0.1)
      })
    } catch (_) {}
  }

  /**
   * 타이핑 스킵: 진행 중인 타이핑 타이머를 취소하고 전체 텍스트를 즉시 출력.
   */
  const skipTyping = useCallback(() => {
    if (typingTimerRef.current) { clearTimeout(typingTimerRef.current); typingTimerRef.current = null }
    if (currentScene?.text) {
      setDisplayedText(currentScene.text)
      setIsTypingDone(true)
      playSkipSfx()
    }
  }, [currentScene?.text])

  /**
   * 타이핑 애니메이션: currentScene.id가 바뀔 때마다 텍스트를 처음부터 한 글자씩 출력.
   * 공백·줄바꿈에는 효과음을 내지 않는다.
   */
  useEffect(() => {
    if (!currentScene?.text) return
    setDisplayedText('')
    setIsTypingDone(false)

    let i = 0
    const tick = () => {
      i++
      setDisplayedText(currentScene.text.slice(0, i))
      const ch = currentScene.text[i - 1]
      // 공백·줄바꿈 제외 글자마다 타이핑 효과음 (2글자마다 1회, playTypingSfx 내부 처리)
      if (ch && ch !== ' ' && ch !== '\n') playTypingSfx(i)
      if (i < currentScene.text.length) {
        typingTimerRef.current = setTimeout(tick, TYPING_SPEED)
      } else {
        setIsTypingDone(true)
      }
    }
    typingTimerRef.current = setTimeout(tick, TYPING_SPEED)
    return () => { if (typingTimerRef.current) clearTimeout(typingTimerRef.current) }
  }, [currentScene?.id])

  // ────────────────────────────────────────────────────────────────
  // BGM 시스템
  // ────────────────────────────────────────────────────────────────

  /**
   * bgmUrlRef: 이전 씬의 BGM URL을 저장해 씬 전환 시 비교.
   * 브라우저는 audio.src를 절대경로로 변환하므로 직접 비교 불가 → ref로 원본 URL 보관.
   * 동일 URL이면 BGM을 끊지 않고 계속 재생.
   */
  const bgmUrlRef = useRef(null)

  /**
   * volumeRef: setInterval 내부에서 stale closure 없이 최신 볼륨을 읽기 위한 ref.
   * volume prop이 바뀔 때마다 동기화.
   */
  const volumeRef = useRef(volume)
  useEffect(() => { volumeRef.current = volume }, [volume])

  /** 진행 중인 BGM 페이드 인터벌 취소 */
  const clearFade = () => {
    if (fadeTimerRef.current) { clearInterval(fadeTimerRef.current); fadeTimerRef.current = null }
  }

  /** BGM 페이드아웃: 현재 볼륨 → 0, 완료 후 pause 및 onDone 콜백 실행 */
  const fadeOut = (audio, onDone) => {
    clearFade()
    const step = Math.max(0.02, audio.volume / (FADE_DURATION / 50))
    fadeTimerRef.current = setInterval(() => {
      if (audio.volume > step) {
        audio.volume = Math.max(0, audio.volume - step)
      } else {
        audio.volume = 0
        audio.pause()
        clearFade()
        onDone?.()
      }
    }, 50)
  }

  /** BGM 페이드인: 볼륨 0에서 volumeRef.current까지 서서히 올리며 재생 */
  const fadeIn = (audio) => {
    clearFade()
    audio.volume = 0
    audio.play().catch(() => {})
    fadeTimerRef.current = setInterval(() => {
      const target = volumeRef.current // ★ stale closure 방지: ref로 최신값 참조
      if (audio.volume < target - 0.04) audio.volume = Math.min(target, audio.volume + 0.05)
      else { audio.volume = target; clearFade() }
    }, 50)
  }

  // 전역 볼륨 변경 시 재생 중인 스토리 BGM에 즉시 반영
  useEffect(() => {
    volumeRef.current = volume
    if (audioRef.current && !audioRef.current.paused) {
      audioRef.current.volume = volume
    }
  }, [volume])

  /**
   * BGM 재생 또는 전환.
   * - 이미 같은 URL이 재생 중이면 아무것도 하지 않음 (동일 BGM 씬 전환 시 끊기지 않음)
   * - 다른 URL이면 현재 BGM을 페이드아웃 후 새 BGM 페이드인
   * - externalAudioRef: App.jsx가 새 오디오 객체를 참조하도록 공유
   */
  const playBgm = (url, transition) => {
    const prev = audioRef.current

    // ★ 동일 URL이면 재생 유지 (씬 전환해도 끊지 않음)
    if (bgmUrlRef.current === url && prev && !prev.paused) return

    const startNew = () => {
      const audio = new Audio(url)
      bgmUrlRef.current = url
      // 곡 끝나면 처음으로 돌아가 다시 페이드인 (루프 효과)
      audio.addEventListener('ended', () => { audio.currentTime = 0; fadeIn(audio) })
      audioRef.current = audio
      // externalAudioRef 갱신: App.jsx의 볼륨 동기화가 새 Audio 객체를 가리키게 함
      if (externalAudioRef) externalAudioRef.current = audio
      if (transition === 'fade') {
        fadeIn(audio)
      } else {
        audio.volume = volume
        audio.play().catch(() => {})
      }
    }

    if (prev && !prev.paused) {
      if (transition === 'fade') {
        fadeOut(prev, startNew) // 이전 BGM 페이드아웃 완료 후 새 BGM 시작
      } else {
        prev.pause()
        startNew()
      }
    } else {
      startNew()
    }
  }

  /** BGM 정지 (씬에 bgm_url이 없을 때) */
  const stopBgm = (transition) => {
    const prev = audioRef.current
    if (!prev || prev.paused) return
    if (transition === 'fade') {
      fadeOut(prev, () => { audioRef.current = null; bgmUrlRef.current = null })
    } else {
      prev.pause()
      audioRef.current = null
      bgmUrlRef.current = null
    }
  }

  // 씬 전환 시 BGM 처리 (bgm_url이 바뀔 때만 실행)
  useEffect(() => {
    if (!currentScene) return
    const { bgm_url, bgm_transition } = currentScene
    if (bgm_url) {
      playBgm(bgm_url, bgm_transition || 'fade')
    } else {
      stopBgm(bgm_transition || 'fade')
    }
  }, [currentScene?.bgm_url])

  // 컴포넌트 언마운트 시 BGM·타이머 정리
  // 단, 챕터 완료(completedRef=true)로 나간 경우에는 BGM을 끄지 않음
  // → EndingBridge가 오디오를 이어받아 계속 재생하기 때문
  useEffect(() => {
    return () => {
      clearFade()
      if (!completedRef.current && audioRef.current) {
        audioRef.current.pause()
        audioRef.current = null
      }
      bgmUrlRef.current = null
    }
  }, [])

  // ── 배경 이미지 프리로드: 씬 전환 시 이미지가 준비될 때까지 스피너 표시 ──
  useEffect(() => {
    if (!currentScene?.background) {
      setImageLoaded(true)
      return
    }
    setImageLoaded(false)
    const img = new Image()
    img.src = currentScene.background
    img.onload = () => setImageLoaded(true)
    img.onerror = () => {
      console.error('Failed to load background image:', currentScene.background)
      setImageLoaded(true) // 로드 실패해도 스토리는 계속 진행
    }
  }, [currentScene?.background])

  // ────────────────────────────────────────────────────────────────
  // 효과음 합성 (Web Audio API)
  // ────────────────────────────────────────────────────────────────

  /**
   * 타이핑 효과음: 깃털 펜이 양피지를 긁는 소리.
   * 화이트노이즈 + 밴드패스(2200~2600Hz) + 고역 강조로 합성.
   * 2글자마다 1회 재생(index % 2 === 0)해 CPU 부담을 줄임.
   *
   * AudioContext를 매번 생성하지 않고 ref로 재사용.
   */
  const audioCtxRef = useRef(null)
  const playTypingSfx = useCallback((index) => {
    if (index % 2 !== 0) return // 2글자마다 한 번만
    try {
      if (!audioCtxRef.current || audioCtxRef.current.state === 'closed') {
        audioCtxRef.current = new (window.AudioContext || window.webkitAudioContext)()
      }
      const ctx = audioCtxRef.current
      const t = ctx.currentTime

      // 55ms짜리 화이트 노이즈 버퍼 생성
      const bufLen = Math.floor(ctx.sampleRate * 0.055)
      const buffer = ctx.createBuffer(1, bufLen, ctx.sampleRate)
      const data = buffer.getChannelData(0)
      for (let j = 0; j < bufLen; j++) data[j] = (Math.random() * 2 - 1)

      const source = ctx.createBufferSource()
      source.buffer = buffer

      // 밴드패스 필터: 1800~3500Hz 대역만 통과 → 긁히는 질감
      const bp = ctx.createBiquadFilter()
      bp.type = 'bandpass'
      bp.frequency.value = 2200 + Math.random() * 400 // 랜덤성으로 자연스러움 추가
      bp.Q.value = 1.2

      // 고역 선반 필터: 4kHz 이상 강조 → 날카로운 필기 느낌
      const shelf = ctx.createBiquadFilter()
      shelf.type = 'highshelf'
      shelf.frequency.value = 4000
      shelf.gain.value = 4

      // 볼륨 엔벨로프: 빠른 어택(4ms) + 부드러운 릴리즈(55ms)
      const gain = ctx.createGain()
      gain.gain.setValueAtTime(0, t)
      gain.gain.linearRampToValueAtTime(0.18, t + 0.004)
      gain.gain.exponentialRampToValueAtTime(0.001, t + 0.055)

      source.connect(bp)
      bp.connect(shelf)
      shelf.connect(gain)
      gain.connect(ctx.destination)
      source.start(t)
    } catch (_) {}
  }, [])

  /**
   * 호버 효과음: 520Hz 사인파, 0.12초짜리 짧고 가벼운 "틱".
   * 선택지 버튼에 마우스를 올릴 때 재생.
   */
  const playHoverSfx = () => {
    try {
      const ctx = new (window.AudioContext || window.webkitAudioContext)()
      const osc = ctx.createOscillator()
      const gain = ctx.createGain()
      osc.connect(gain)
      gain.connect(ctx.destination)
      osc.type = 'sine'
      osc.frequency.value = 520
      const t = ctx.currentTime
      gain.gain.setValueAtTime(0, t)
      gain.gain.linearRampToValueAtTime(0.08, t + 0.01)
      gain.gain.exponentialRampToValueAtTime(0.001, t + 0.12)
      osc.start(t)
      osc.stop(t + 0.12)
    } catch (_) {}
  }

  /**
   * 선택지 클릭 효과음: 660Hz + 880Hz 두 음을 80ms 간격으로 "딩동" 느낌.
   * 선택지 버튼 클릭 시 재생.
   */
  const playChoiceSfx = () => {
    try {
      const ctx = new (window.AudioContext || window.webkitAudioContext)()
      const notes = [660, 880]
      notes.forEach((freq, i) => {
        const osc = ctx.createOscillator()
        const gain = ctx.createGain()
        osc.connect(gain)
        gain.connect(ctx.destination)
        osc.type = 'sine'
        osc.frequency.value = freq
        const t = ctx.currentTime + i * 0.08 // 두 음을 80ms 간격으로
        gain.gain.setValueAtTime(0, t)
        gain.gain.linearRampToValueAtTime(0.25, t + 0.02)
        gain.gain.exponentialRampToValueAtTime(0.001, t + 0.35)
        osc.start(t)
        osc.stop(t + 0.35)
      })
    } catch (_) {}
  }

  // ────────────────────────────────────────────────────────────────
  // 선택지 처리
  // ────────────────────────────────────────────────────────────────

  /**
   * completedRef: 챕터 완료로 나갔을 때 cleanup에서 BGM을 끄지 않기 위한 플래그.
   * EndingBridge가 오디오를 이어받아 계속 재생하므로, 여기서 멈추면 안 된다.
   */
  const completedRef = useRef(false)

  /**
   * 선택지 클릭 핸들러.
   * - nextSceneId === null: 챕터 완료
   *   → BGM을 끊지 않고 onComplete(scene, endingIdx)를 호출.
   *     EndingBridge가 오디오를 이어받아 자연스럽게 계속 재생.
   * - nextSceneId !== null: 해당 씬으로 이동, path에 추가
   */
  const handleChoice = (nextSceneId) => {
    playChoiceSfx()
    if (nextSceneId === null) {
      // 어떤 엔딩(0·1·2)을 선택했는지 계산
      // 엔딩 씬 = choices 중 next_scene_id=null이 있는 씬들
      const endingScenes = scenes.filter(s =>
        s.choices && s.choices.some(c => c.next_scene_id === null)
      ).sort((a, b) => a.scene_order - b.scene_order)
      const endingIdx = Math.max(0, endingScenes.findIndex(s => s.id === currentScene?.id))

      // BGM을 멈추지 않고 EndingBridge로 넘김 (completedRef로 cleanup 방지)
      completedRef.current = true
      onComplete(currentScene, endingIdx)
    } else {
      const nextIndex = scenes.findIndex(s => s.id === nextSceneId)
      if (nextIndex !== -1) {
        setCurrentSceneIndex(nextIndex)
        setPath(p => [...p, nextSceneId]) // 방문 경로 기록 (진행도 분자)
        if (onScene) onScene(nextIndex)
      }
    }
  }

  // ────────────────────────────────────────────────────────────────
  // 로딩 / 에러 화면
  // ────────────────────────────────────────────────────────────────

  if (isLoading) {
    return (
      <div className="size-full flex items-center justify-center bg-gradient-to-br from-[#1a365d] via-[#2d3f6f] to-[#5a2d7c]">
        <motion.div initial={{ opacity: 0 }} animate={{ opacity: 1 }} className="text-white text-xl">
          스토리를 불러오는 중...
        </motion.div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="size-full flex items-center justify-center bg-gradient-to-br from-[#1a365d] via-[#2d3f6f] to-[#5a2d7c]">
        <div className="text-center">
          <p className="text-white text-xl mb-4">{error}</p>
          <button
            onClick={onBack || onComplete}
            className="px-6 py-3 bg-amber-400 hover:bg-amber-300 text-gray-900 font-semibold rounded-xl transition-all"
          >
            챕터 목록으로
          </button>
        </div>
      </div>
    )
  }

  if (!currentScene) {
    return (
      <div className="size-full flex items-center justify-center bg-gradient-to-br from-[#1a365d] via-[#2d3f6f] to-[#5a2d7c]">
        <div className="text-white text-xl">장면을 찾을 수 없습니다.</div>
      </div>
    )
  }

  // ────────────────────────────────────────────────────────────────
  // 렌더링
  // ────────────────────────────────────────────────────────────────

  return (
    <div className="size-full relative overflow-hidden bg-gradient-to-br from-[#1a365d] via-[#2d3f6f] to-[#5a2d7c]">

      {/* ── 배경 이미지 (씬 전환 시 페이드 교체) ── */}
      <AnimatePresence mode="wait">
        {currentScene.background && (
          <motion.div
            key={`bg-${currentScene.id}`}
            initial={{ opacity: 0 }}
            animate={{ opacity: imageLoaded ? 1 : 0 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.5 }}
            className="absolute inset-0"
          >
            <div
              className="size-full bg-cover bg-center"
              style={{
                backgroundImage: `url(${currentScene.background})`,
                filter: 'brightness(0.5)', // 텍스트 가독성을 위해 어둡게 처리
              }}
            />
          </motion.div>
        )}
      </AnimatePresence>

      {/* 배경 위 검은 오버레이 (텍스트 가독성 추가 확보) */}
      <div className="absolute inset-0 bg-black/30" />

      {/* ── 캐릭터 영역 (최대 4명, 화면 중앙 ~ 텍스트 박스 위) ── */}
      {(() => {
        // character, character2, character3, character4 중 존재하는 것만 필터링
        const chars = [
          currentScene.character,
          currentScene.character2,
          currentScene.character3,
          currentScene.character4,
        ].filter(Boolean)
        if (chars.length === 0) return null

        // 캐릭터 수에 따라 각 이미지의 너비 조정 (1명일 때 가장 크게)
        const widthMap = { 1: 'w-64 sm:w-96', 2: 'w-36 sm:w-52', 3: 'w-28 sm:w-40', 4: 'w-24 sm:w-36' }
        const widthClass = widthMap[chars.length] || 'w-24 sm:w-36'

        return (
          <AnimatePresence mode="wait">
            <motion.div
              key={`chars-${currentScene.id}`}
              initial={{ opacity: 0, y: 20 }}
              animate={{ opacity: 1, y: 0 }}
              exit={{ opacity: 0, y: -10 }}
              transition={{ duration: 0.6 }}
              className="absolute inset-x-0 flex items-end justify-center gap-3 sm:gap-6"
              style={{ top: '8%', bottom: '36%' }} // 텍스트 박스(하단 36%)를 침범하지 않는 영역
            >
              {chars.map((src, i) => (
                <div
                  key={i}
                  className={`relative ${widthClass} h-full`}
                  style={{
                    borderRadius: '1.5rem',
                    overflow: 'hidden',
                    // CSS mask로 이미지 상하좌우 가장자리를 자연스럽게 페이드아웃
                    WebkitMaskImage:
                      'linear-gradient(to bottom, transparent 0%, black 12%, black 75%, transparent 100%),' +
                      'linear-gradient(to right,   transparent 0%, black  8%, black 92%, transparent 100%)',
                    WebkitMaskComposite: 'destination-in',
                    maskImage:
                      'linear-gradient(to bottom, transparent 0%, black 12%, black 75%, transparent 100%),' +
                      'linear-gradient(to right,   transparent 0%, black  8%, black 92%, transparent 100%)',
                    maskComposite: 'intersect',
                  }}
                >
                  <img
                    src={src}
                    alt={`Character ${i + 1}`}
                    className="w-full h-full object-cover object-top"
                    onError={(e) => { e.target.parentElement.style.display = 'none' }} // 이미지 로드 실패 시 영역 숨김
                  />
                </div>
              ))}
            </motion.div>
          </AnimatePresence>
        )
      })()}

      {/* ── 하단 텍스트 박스 + 선택지 영역 ── */}
      <div className="relative z-10 size-full flex flex-col justify-end p-4 sm:p-6 md:p-10">
        <AnimatePresence mode="wait">
          <motion.div
            key={`scene-${currentScene.id}`}
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -30 }}
            transition={{ duration: 0.5 }}
            className="w-full max-w-4xl mx-auto"
          >
            {/* 텍스트 카드: 타이핑 도중 클릭하면 즉시 전체 표시(스킵) */}
            <div
              onClick={!isTypingDone ? skipTyping : undefined}
              className={`bg-black/70 backdrop-blur-md rounded-xl sm:rounded-2xl p-4 sm:p-6 md:p-8 mb-4 sm:mb-6 border border-white/10 relative ${!isTypingDone ? 'cursor-pointer' : ''}`}
            >
              <p className="text-white text-base sm:text-lg md:text-xl leading-relaxed min-h-[2em]">
                {displayedText}
                {/* 타이핑 중 깜빡이는 커서 */}
                {!isTypingDone && (
                  <motion.span
                    animate={{ opacity: [1, 0] }}
                    transition={{ duration: 0.5, repeat: Infinity, repeatType: 'reverse' }}
                    className="inline-block w-0.5 h-5 bg-amber-300 ml-0.5 align-middle"
                  />
                )}
              </p>
              {/* 스킵 힌트 텍스트 (타이핑 완료 전에만 표시) */}
              {!isTypingDone && (
                <p className="absolute bottom-2 right-3 text-xs text-white/30 select-none">클릭하여 건너뛰기</p>
              )}
            </div>

            {/* 선택지 버튼들: 타이핑 완료 후 순차적으로 페이드인 */}
            <AnimatePresence>
              {isTypingDone && (
                <motion.div
                  className="space-y-2 sm:space-y-3"
                  initial={{ opacity: 0 }}
                  animate={{ opacity: 1 }}
                  transition={{ duration: 0.3 }}
                >
                  {currentScene.choices && currentScene.choices.map((choice, index) => (
                    <motion.button
                      key={index}
                      onClick={() => handleChoice(choice.next_scene_id)}
                      className="w-full px-4 sm:px-6 py-3 sm:py-4 bg-white/10 backdrop-blur-sm border-2 border-white/20 rounded-lg sm:rounded-xl text-white text-left hover:bg-amber-400/20 hover:border-amber-400/50 transition-all duration-300 group"
                      initial={{ opacity: 0, x: -20 }}
                      animate={{ opacity: 1, x: 0 }}
                      transition={{ delay: index * 0.1 }} // 선택지마다 100ms씩 순차 등장
                      onHoverStart={playHoverSfx}
                      whileHover={{ scale: 1.02 }}
                      whileTap={{ scale: 0.98 }}
                    >
                      <span className="text-sm sm:text-base md:text-lg group-hover:text-amber-300 transition-colors">
                        {choice.label}
                      </span>
                    </motion.button>
                  ))}
                </motion.div>
              )}
            </AnimatePresence>

            {/* ── 경로 기준 진행도 표시 ──
                분자: path.length (지금까지 방문한 씬 수)
                분모: path.length + remainingFrom(현재씬) (남은 최장 경로 포함)
                → 분기를 타도 단조 증가, 엔딩에서 N/N */}
            <div className="mt-4 sm:mt-6 text-center">
              <div className="inline-flex items-center gap-2 px-3 sm:px-4 py-2 bg-black/50 rounded-full text-xs sm:text-sm">
                <span className="text-amber-300">챕터 {chapter}</span>
                <span className="text-white/50">•</span>
                <span className="text-white/70">
                  {(() => {
                    const done  = path.length || (currentSceneIndex + 1)
                    const total = currentScene ? done + remainingFrom(currentScene.id) : done
                    return `${done} / ${total}`
                  })()}
                </span>
              </div>
            </div>
          </motion.div>
        </AnimatePresence>
      </div>

      {/* ── 배경 이미지 로딩 중 스피너 오버레이 ──
          이미지가 로드되기 전까지 화면을 덮어 깜빡임을 방지 */}
      {!imageLoaded && (
        <div className="absolute inset-0 bg-gradient-to-br from-[#1a365d] via-[#2d3f6f] to-[#5a2d7c] flex items-center justify-center z-50">
          <motion.div
            animate={{ rotate: 360 }}
            transition={{ duration: 1, repeat: Infinity, ease: 'linear' }}
            className="w-12 h-12 border-4 border-amber-400/30 border-t-amber-400 rounded-full"
          />
        </div>
      )}
    </div>
  )
}
