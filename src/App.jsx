/**
 * App.jsx — 최상위 컴포넌트
 *
 * 역할:
 *  - 화면(page) 라우팅: title → select → story → complete (어드민: /admin)
 *  - 전역 볼륨 관리 및 메인 BGM(타이틀·챕터선택·완료 화면) 재생
 *  - 게임 진행 상태(gameState) 관리 및 각 화면 컴포넌트에 props 전달
 *
 * 화면 흐름:
 *  TitlePage(로그인) → ChapterSelect(챕터 선택) → StoryPage(스토리) → ChapterComplete(완료)
 *  URL이 /admin이거나 Ctrl+Shift+A 단축키 → AdminPanel
 */
import { useState, useEffect, useRef, useCallback } from 'react'
import TitlePage from './components/TitlePage'
import ChapterSelect from './components/ChapterSelect'
import StoryPage from './components/StoryPage'
import ChapterComplete from './components/ChapterComplete'
import AdminPanel from './components/AdminPanel'
import GlobalMenu from './components/GlobalMenu'
import { initializeGame, saveProgress } from './lib/gameState'
import { recordChapterComplete } from './lib/api'

// ── 메인 BGM URL (타이틀·챕터선택·챕터완료 화면에서 재생)
const MAIN_BGM_URL = 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/main-theme-marimba-meadow.mp3'

// 챕터 스토리 BGM은 scenes 테이블의 bgm_url 컬럼으로 관리됨 (참고용)
// - 잔잔한 아침 테마: bgm/1780101158917-3.mp3
// - 부름·긴장 테마:   bgm/1780101284801-4.mp3
// - 여운·감정 테마:   bgm/1780071045784-Falling_Snowfield.mp3

const FADE_DURATION = 1500 // BGM 페이드인/아웃 소요 시간 (ms)

export default function App() {
  // ── 현재 화면 ('title' | 'select' | 'story' | 'complete' | 'admin')
  const [page, setPage] = useState('title')

  // ── localStorage에서 불러온 게임 상태 (nickname, teamId, completedChapters 등)
  const [gameState, setGameState] = useState(null)

  // ── 현재 플레이 중인 챕터 번호 (1~11)
  const [currentChapter, setCurrentChapter] = useState(null)

  // ── 현재 씬 인덱스 (GlobalMenu 등 외부 표시용, 현재 직접 사용 안 함)
  const [currentScene, setCurrentScene] = useState(0)

  // ── BGM 재생 여부 (모바일에서 사용자 인터랙션 후 자동 재생 정책 대응)
  const [bgmStarted, setBgmStarted] = useState(false)

  // ── 전역 볼륨 (0.0 ~ 1.0)
  const [volume, setVolume] = useState(0.7)

  /**
   * volumeRef: setInterval/오디오 ended 이벤트 내부에서 항상 최신 볼륨을 읽기 위한 ref.
   * 이벤트 클로저는 state를 캡처하므로 stale(구버전) 값을 읽는 문제가 생김.
   * → volume state가 바뀔 때마다 volumeRef.current도 함께 동기화해야 한다.
   */
  const volumeRef = useRef(0.7)

  // StoryPage의 오디오 엘리먼트를 App에서도 볼륨 제어하기 위한 ref (externalAudioRef 패턴)
  const storyAudioRef = useRef(null)

  // ── 메인 BGM 오디오 엘리먼트 및 페이드 인터벌 관리
  const mainAudioRef = useRef(null)
  const mainFadeRef  = useRef(null)

  /** 진행 중인 메인 BGM 페이드 인터벌을 취소 */
  const clearMainFade = () => {
    if (mainFadeRef.current) { clearInterval(mainFadeRef.current); mainFadeRef.current = null }
  }

  /**
   * 메인 BGM 페이드인: 볼륨을 0에서 volumeRef.current까지 서서히 올림.
   * volumeRef를 사용하므로 페이드 도중 볼륨 슬라이더를 조작해도 올바르게 반영된다.
   */
  const mainFadeIn = useCallback((audio) => {
    clearMainFade()
    audio.volume = 0
    audio.play().catch(() => {}) // 브라우저 자동재생 차단 시 무시
    mainFadeRef.current = setInterval(() => {
      const target = volumeRef.current // ★ stale closure 방지: ref로 최신값 참조
      if (audio.volume < target - 0.04) audio.volume = Math.min(target, audio.volume + 0.05)
      else { audio.volume = target; clearMainFade() }
    }, 50)
  }, [])

  /**
   * 메인 BGM 페이드아웃: 현재 볼륨에서 0까지 서서히 내리고 pause.
   * onDone 콜백은 페이드 완료 후 실행 (선택적).
   */
  const mainFadeOut = useCallback((audio, onDone) => {
    clearMainFade()
    const step = Math.max(0.02, audio.volume / (FADE_DURATION / 50))
    mainFadeRef.current = setInterval(() => {
      if (audio.volume > step) audio.volume = Math.max(0, audio.volume - step)
      else { audio.volume = 0; audio.pause(); clearMainFade(); onDone?.() }
    }, 50)
  }, [])

  // ── 앱 마운트 시 메인 BGM 오디오 객체 준비 (아직 재생하지 않음)
  useEffect(() => {
    const audio = new Audio(MAIN_BGM_URL)
    audio.volume = 0
    // 곡이 끝나면 처음으로 돌아가 다시 페이드인 (루프 효과)
    audio.addEventListener('ended', () => { audio.currentTime = 0; mainFadeIn(audio) })
    mainAudioRef.current = audio
    return () => { clearMainFade(); audio.pause() }
  }, [])

  /**
   * 볼륨 변경 핸들러
   * - volume state 업데이트
   * - volumeRef 동기화 (페이드 인터벌이 최신값을 읽을 수 있게)
   * - 현재 재생 중인 오디오(메인/스토리)에 즉시 반영
   */
  const handleVolumeChange = useCallback((v) => {
    setVolume(v)
    volumeRef.current = v // ★ stale closure 방지: ref 동기화 필수
    if (mainAudioRef.current) mainAudioRef.current.volume = v
    if (storyAudioRef.current) storyAudioRef.current.volume = v
  }, [])

  /**
   * TAP TO START 후 최초 1회 메인 BGM 시작.
   * 모바일 브라우저는 사용자 인터랙션 없이 자동재생이 차단되므로
   * 화면 첫 탭/클릭 시 이 함수를 호출해 BGM을 시작한다.
   */
  const startMainBgm = useCallback(() => {
    if (bgmStarted) return
    setBgmStarted(true)
    if (mainAudioRef.current) mainFadeIn(mainAudioRef.current)
  }, [bgmStarted, mainFadeIn])

  /**
   * 화면(page)이 바뀔 때 메인 BGM을 켜거나 끈다.
   * - 타이틀·챕터선택·완료 화면: 메인 BGM 페이드인
   * - 스토리 화면: 메인 BGM 페이드아웃 (스토리 BGM이 대신 재생됨)
   */
  useEffect(() => {
    const audio = mainAudioRef.current
    if (!audio || !bgmStarted) return
    if (page === 'title' || page === 'select' || page === 'complete') {
      if (audio.paused) mainFadeIn(audio)
    } else {
      if (!audio.paused) mainFadeOut(audio)
    }
  }, [page, bgmStarted])

  // ── 앱 초기화: localStorage에서 게임 상태 복원 + 어드민 접근 처리
  useEffect(() => {
    const state = initializeGame()
    setGameState(state)

    // URL이 /admin이면 어드민 패널로 바로 이동
    if (window.location.pathname === '/admin') setPage('admin')

    // Ctrl+Shift+A 단축키로 어드민 패널 진입 (개발·관리용)
    const handleKeyPress = (e) => {
      if (e.ctrlKey && e.shiftKey && e.code === 'KeyA') setPage('admin')
    }
    window.addEventListener('keydown', handleKeyPress)
    return () => window.removeEventListener('keydown', handleKeyPress)
  }, [])

  // ── 화면 전환 핸들러 ──

  /** 타이틀에서 로그인 완료 → 챕터 선택 화면으로 */
  const handleStartGame = (nickname, teamId, teamName) => {
    const newState = { ...gameState, nickname, teamId: teamId || null, teamName: teamName || null }
    setGameState(newState)
    setPage('select')
  }

  /** 이어하기 버튼 → 마지막으로 플레이한 챕터 스토리 화면으로 */
  const handleContinue = () => {
    if (gameState?.lastChapter) { setCurrentChapter(gameState.lastChapter); setPage('story') }
  }

  /** 챕터 선택 → 해당 챕터 스토리 화면으로 */
  const handleSelectChapter = (chapterNum) => {
    setCurrentChapter(chapterNum); setCurrentScene(0); setPage('story')
  }

  /**
   * 챕터 완료 처리:
   * 1. localStorage에 진행도 저장
   * 2. Supabase player_sessions에 완료 기록 (어드민 대시보드용)
   * 3. React state 즉시 업데이트 (새로고침 없이 챕터 목록에 완료 표시)
   * 4. 완료 화면으로 전환
   */
  const handleChapterComplete = () => {
    saveProgress(gameState.nickname, currentChapter, gameState.teamId, gameState.teamName)
    recordChapterComplete(gameState.nickname, currentChapter, gameState.teamId)
    setGameState(prev => ({
      ...prev,
      lastChapter: currentChapter,
      completedChapters: prev.completedChapters.includes(currentChapter)
        ? prev.completedChapters
        : [...prev.completedChapters, currentChapter],
    }))
    setPage('complete')
  }

  /**
   * 완료 화면에서 '다음 챕터' 버튼 처리.
   * 마지막 챕터(11)를 완료했으면 챕터 선택 화면으로 돌아간다.
   */
  const handleContinueToNext = () => {
    const next = currentChapter + 1
    if (next <= 11) { setCurrentChapter(next); setCurrentScene(0); setPage('story') }
    else setPage('select') // 11챕터 이후에는 챕터 목록으로
  }

  /** 챕터 선택 화면으로 돌아가기 */
  const handleBackToSelect = () => setPage('select')

  // gameState 초기화 전 로딩 표시
  if (!gameState) return <div>Loading...</div>

  return (
    <>
      {/* 전 화면 우상단 고정 메뉴 (볼륨·네비게이션·어드민 스킵) */}
      <GlobalMenu
        page={page}
        volume={volume}
        onVolumeChange={handleVolumeChange}
        onGoTitle={() => { setPage('title') }}
        onGoSelect={handleBackToSelect}
        onSkipComplete={page === 'story' ? handleChapterComplete : undefined}
      />

      {/* 타이틀 화면: 로그인(이름+팀 선택) */}
      {page === 'title' && (
        <TitlePage
          onStart={handleStartGame}
          onContinue={handleContinue}
          canContinue={!!gameState.lastChapter}
          onTap={startMainBgm}
          bgmStarted={bgmStarted}
        />
      )}

      {/* 챕터 선택 화면: 전체 챕터 목록 + 완료 여부 + 순차 잠금 */}
      {page === 'select' && (
        <ChapterSelect
          nickname={gameState.nickname}
          completedChapters={gameState.completedChapters}
          onSelectChapter={handleSelectChapter}
        />
      )}

      {/* 스토리 화면: 씬 렌더링 + BGM + 선택지 분기 */}
      {page === 'story' && currentChapter !== null && (
        <StoryPage
          chapter={currentChapter}
          onComplete={handleChapterComplete}
          onBack={handleBackToSelect}
          onScene={setCurrentScene}
          volume={volume}
          audioRef={storyAudioRef} // externalAudioRef 패턴: App에서 스토리 BGM 볼륨 동기화
        />
      )}

      {/* 챕터 완료 화면 */}
      {page === 'complete' && currentChapter !== null && (
        <ChapterComplete
          chapter={currentChapter}
          onContinueNext={handleContinueToNext}
          onBackToSelect={handleBackToSelect}
        />
      )}

      {/* 어드민 패널 (/admin URL 또는 Ctrl+Shift+A) */}
      {page === 'admin' && (
        <AdminPanel onBack={() => setPage('title')} />
      )}
    </>
  )
}
