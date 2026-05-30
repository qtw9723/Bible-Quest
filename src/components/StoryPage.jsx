import { useState, useEffect, useRef, useCallback } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { getStoryData } from '../lib/api'

const FADE_DURATION = 1500  // BGM 페이드 ms
const TYPING_SPEED = 40     // 타이핑 속도 ms/글자

export default function StoryPage({ chapter, onComplete, onBack, onScene, volume = 0.7, audioRef: externalAudioRef }) {
  const [scenes, setScenes] = useState([])
  const [currentSceneIndex, setCurrentSceneIndex] = useState(0)
  const [isLoading, setIsLoading] = useState(true)
  const [imageLoaded, setImageLoaded] = useState(false)
  const [error, setError] = useState(null)

  // 타이핑 애니메이션
  const [displayedText, setDisplayedText] = useState('')
  const [isTypingDone, setIsTypingDone] = useState(false)
  const typingTimerRef = useRef(null)

  const audioRef = useRef(null)
  const fadeTimerRef = useRef(null)

  // 챕터 데이터 로드 (Supabase에서)
  useEffect(() => {
    const loadScenes = async () => {
      setIsLoading(true)
      setError(null)
      try {
        const data = await getStoryData(chapter)
        if (data && data.scenes && data.scenes.length > 0) {
          setScenes(data.scenes)
          setCurrentSceneIndex(0)
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

  // ── 타이핑 애니메이션 ──
  const playSkipSfx = () => {
    try {
      const ctx = new (window.AudioContext || window.webkitAudioContext)()
      // 살짝 내려가는 두 음 — "슥" 느낌
      [400, 320].forEach((freq, i) => {
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

  const skipTyping = useCallback(() => {
    if (typingTimerRef.current) { clearTimeout(typingTimerRef.current); typingTimerRef.current = null }
    if (currentScene?.text) {
      setDisplayedText(currentScene.text)
      setIsTypingDone(true)
      playSkipSfx()
    }
  }, [currentScene?.text])

  useEffect(() => {
    if (!currentScene?.text) return
    setDisplayedText('')
    setIsTypingDone(false)

    let i = 0
    const tick = () => {
      i++
      setDisplayedText(currentScene.text.slice(0, i))
      // 공백·줄바꿈 제외하고 효과음
      const ch = currentScene.text[i - 1]
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

  const bgmUrlRef = useRef(null)
  const volumeRef = useRef(volume)  // 항상 최신 볼륨 참조용

  // volume prop 변경 시 ref 동기화
  useEffect(() => { volumeRef.current = volume }, [volume])

  // BGM 페이드 유틸 — 여러 페이드가 겹치지 않도록 인터벌 ID별 관리
  const clearFade = () => {
    if (fadeTimerRef.current) { clearInterval(fadeTimerRef.current); fadeTimerRef.current = null }
  }

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

  const fadeIn = (audio) => {
    clearFade()
    audio.volume = 0
    audio.play().catch(() => {})
    fadeTimerRef.current = setInterval(() => {
      const target = volumeRef.current  // ★ ref로 항상 최신값 참조
      if (audio.volume < target - 0.04) audio.volume = Math.min(target, audio.volume + 0.05)
      else { audio.volume = target; clearFade() }
    }, 50)
  }

  // 외부 볼륨 변경 시 현재 재생 중인 오디오에 즉시 반영
  useEffect(() => {
    volumeRef.current = volume
    if (audioRef.current && !audioRef.current.paused) {
      audioRef.current.volume = volume
    }
  }, [volume])

  const playBgm = (url, transition) => {
    const prev = audioRef.current

    // ★ 같은 URL이면 재생 유지 (씬 전환해도 끊지 않음)
    if (bgmUrlRef.current === url && prev && !prev.paused) return

    const startNew = () => {
      const audio = new Audio(url)
      bgmUrlRef.current = url
      audio.addEventListener('ended', () => { audio.currentTime = 0; fadeIn(audio) })
      audioRef.current = audio
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
        fadeOut(prev, startNew)
      } else {
        prev.pause()
        startNew()
      }
    } else {
      startNew()
    }
  }

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

  // 장면 변경 시 BGM 처리
  useEffect(() => {
    if (!currentScene) return
    const { bgm_url, bgm_transition } = currentScene
    if (bgm_url) {
      playBgm(bgm_url, bgm_transition || 'fade')
    } else {
      stopBgm(bgm_transition || 'fade')
    }
  }, [currentScene?.bgm_url])

  // 컴포넌트 언마운트 시 BGM 정리
  useEffect(() => {
    return () => {
      clearFade()
      if (audioRef.current) { audioRef.current.pause(); audioRef.current = null }
      bgmUrlRef.current = null
    }
  }, [])

  // 배경 이미지 미리 로드
  useEffect(() => {
    if (!currentScene?.background) {
      // 배경 이미지가 없으면 바로 로드 완료 처리
      setImageLoaded(true)
      return
    }
    setImageLoaded(false)
    const img = new Image()
    img.src = currentScene.background
    img.onload = () => setImageLoaded(true)
    img.onerror = () => {
      console.error('Failed to load background image:', currentScene.background)
      setImageLoaded(true) // 이미지 로드 실패해도 계속 진행
    }
  }, [currentScene?.background])

  // 타이핑 효과음 — 깃털 펜이 양피지를 긁는 소리 (노이즈 + 밴드패스)
  const audioCtxRef = useRef(null)
  const playTypingSfx = useCallback((index) => {
    if (index % 2 !== 0) return // 2글자마다 한 번
    try {
      if (!audioCtxRef.current || audioCtxRef.current.state === 'closed') {
        audioCtxRef.current = new (window.AudioContext || window.webkitAudioContext)()
      }
      const ctx = audioCtxRef.current
      const t = ctx.currentTime

      // 짧은 화이트 노이즈 버퍼 생성
      const bufLen = Math.floor(ctx.sampleRate * 0.055)
      const buffer = ctx.createBuffer(1, bufLen, ctx.sampleRate)
      const data = buffer.getChannelData(0)
      for (let j = 0; j < bufLen; j++) data[j] = (Math.random() * 2 - 1)

      const source = ctx.createBufferSource()
      source.buffer = buffer

      // 밴드패스: 1800~3500Hz 대역만 통과 → 긁히는 질감
      const bp = ctx.createBiquadFilter()
      bp.type = 'bandpass'
      bp.frequency.value = 2200 + Math.random() * 400
      bp.Q.value = 1.2

      // 고역 살짝 강조 → 날카로운 필기 느낌
      const shelf = ctx.createBiquadFilter()
      shelf.type = 'highshelf'
      shelf.frequency.value = 4000
      shelf.gain.value = 4

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

  // 호버 효과음 — 클릭보다 작고 짧은 "틱" 소리
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

  // 선택 효과음 (Web Audio API — 외부 파일 불필요)
  const playChoiceSfx = () => {
    try {
      const ctx = new (window.AudioContext || window.webkitAudioContext)()
      // 두 개의 음을 짧게 겹쳐서 "딩동" 느낌
      const notes = [660, 880]
      notes.forEach((freq, i) => {
        const osc = ctx.createOscillator()
        const gain = ctx.createGain()
        osc.connect(gain)
        gain.connect(ctx.destination)
        osc.type = 'sine'
        osc.frequency.value = freq
        const t = ctx.currentTime + i * 0.08
        gain.gain.setValueAtTime(0, t)
        gain.gain.linearRampToValueAtTime(0.25, t + 0.02)
        gain.gain.exponentialRampToValueAtTime(0.001, t + 0.35)
        osc.start(t)
        osc.stop(t + 0.35)
      })
    } catch (_) {}
  }

  // 선택지 클릭 핸들러
  const handleChoice = (nextSceneId) => {
    playChoiceSfx()
    if (nextSceneId === null) {
      // 챕터 완료 - BGM 페이드 아웃
      stopBgm('fade')
      onComplete()
    } else {
      // 다음 장면으로 이동
      const nextIndex = scenes.findIndex(s => s.id === nextSceneId)
      if (nextIndex !== -1) {
        setCurrentSceneIndex(nextIndex)
        if (onScene) {
          onScene(nextIndex)
        }
      }
    }
  }

  if (isLoading) {
    return (
      <div className="size-full flex items-center justify-center bg-gradient-to-br from-[#1a365d] via-[#2d3f6f] to-[#5a2d7c]">
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          className="text-white text-xl"
        >
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

  return (
    <div className="size-full relative overflow-hidden bg-gradient-to-br from-[#1a365d] via-[#2d3f6f] to-[#5a2d7c]">
      {/* 배경 이미지 */}
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
                filter: 'brightness(0.5)',
              }}
            />
          </motion.div>
        )}
      </AnimatePresence>

      {/* 어두운 오버레이 */}
      <div className="absolute inset-0 bg-black/30" />

      {/* 캐릭터 영역 — 화면 중앙, 텍스트 위쪽 */}
      {(() => {
        const chars = [
          currentScene.character,
          currentScene.character2,
          currentScene.character3,
          currentScene.character4,
        ].filter(Boolean)
        if (chars.length === 0) return null

        // 캐릭터 수에 따라 각 이미지 너비 조정 (1명일 때 더 넓게)
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
              style={{ top: '8%', bottom: '36%' }}
            >
              {chars.map((src, i) => (
                <div
                  key={i}
                  className={`relative ${widthClass} h-full`}
                  style={{
                    borderRadius: '1.5rem',
                    overflow: 'hidden',
                    // 가장자리 페이드: 위·아래·좌우
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
                    onError={(e) => { e.target.parentElement.style.display = 'none' }}
                  />
                </div>
              ))}
            </motion.div>
          </AnimatePresence>
        )
      })()}

      {/* 텍스트 및 선택지 영역 */}
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
            {/* 텍스트 카드 — 클릭 시 타이핑 스킵 */}
            <div
              onClick={!isTypingDone ? skipTyping : undefined}
              className={`bg-black/70 backdrop-blur-md rounded-xl sm:rounded-2xl p-4 sm:p-6 md:p-8 mb-4 sm:mb-6 border border-white/10 relative ${!isTypingDone ? 'cursor-pointer' : ''}`}
            >
              <p className="text-white text-base sm:text-lg md:text-xl leading-relaxed min-h-[2em]">
                {displayedText}
                {/* 타이핑 커서 */}
                {!isTypingDone && (
                  <motion.span
                    animate={{ opacity: [1, 0] }}
                    transition={{ duration: 0.5, repeat: Infinity, repeatType: 'reverse' }}
                    className="inline-block w-0.5 h-5 bg-amber-300 ml-0.5 align-middle"
                  />
                )}
              </p>
              {/* 스킵 힌트 */}
              {!isTypingDone && (
                <p className="absolute bottom-2 right-3 text-xs text-white/30 select-none">클릭하여 건너뛰기</p>
              )}
            </div>

            {/* 선택지 버튼들 — 타이핑 완료 후 표시 */}
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
                      transition={{ delay: index * 0.1 }}
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

            {/* 진행 상황 표시 */}
            <div className="mt-4 sm:mt-6 text-center">
              <div className="inline-flex items-center gap-2 px-3 sm:px-4 py-2 bg-black/50 rounded-full text-xs sm:text-sm">
                <span className="text-amber-300">
                  챕터 {chapter}
                </span>
                <span className="text-white/50">•</span>
                <span className="text-white/70">
                  {currentSceneIndex + 1} / {scenes.length}
                </span>
              </div>
            </div>
          </motion.div>
        </AnimatePresence>
      </div>

      {/* 로딩 오버레이 (이미지 로딩 중) */}
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
