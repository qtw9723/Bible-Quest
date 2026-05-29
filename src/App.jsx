import { useState, useEffect, useRef, useCallback } from 'react'
import TitlePage from './components/TitlePage'
import ChapterSelect from './components/ChapterSelect'
import StoryPage from './components/StoryPage'
import ChapterComplete from './components/ChapterComplete'
import AdminPanel from './components/AdminPanel'
import { initializeGame, saveProgress } from './lib/gameState'

const MAIN_BGM_URL = 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/main-theme-marimba-meadow.mp3'
const FADE_DURATION = 1500

export default function App() {
  const [page, setPage] = useState('title')
  const [gameState, setGameState] = useState(null)
  const [currentChapter, setCurrentChapter] = useState(null)
  const [currentScene, setCurrentScene] = useState(0)
  const [bgmStarted, setBgmStarted] = useState(false)

  // ── 메인 BGM (title + select 구간 유지) ──
  const mainAudioRef = useRef(null)
  const mainFadeRef  = useRef(null)

  const clearMainFade = () => {
    if (mainFadeRef.current) { clearInterval(mainFadeRef.current); mainFadeRef.current = null }
  }
  const mainFadeIn = useCallback((audio) => {
    clearMainFade()
    audio.volume = 0
    audio.play().catch(() => {})
    mainFadeRef.current = setInterval(() => {
      if (audio.volume < 0.95) audio.volume = Math.min(1, audio.volume + 0.05)
      else { audio.volume = 1; clearMainFade() }
    }, 50)
  }, [])
  const mainFadeOut = useCallback((audio, onDone) => {
    clearMainFade()
    const step = Math.max(0.02, audio.volume / (FADE_DURATION / 50))
    mainFadeRef.current = setInterval(() => {
      if (audio.volume > step) audio.volume = Math.max(0, audio.volume - step)
      else { audio.volume = 0; audio.pause(); clearMainFade(); onDone?.() }
    }, 50)
  }, [])

  // 앱 마운트 시 오디오 객체 준비
  useEffect(() => {
    const audio = new Audio(MAIN_BGM_URL)
    audio.volume = 0
    audio.addEventListener('ended', () => { audio.currentTime = 0; mainFadeIn(audio) })
    mainAudioRef.current = audio
    return () => { clearMainFade(); audio.pause() }
  }, [])

  // TAP TO START 후 BGM 시작
  const startMainBgm = useCallback(() => {
    if (bgmStarted) return
    setBgmStarted(true)
    if (mainAudioRef.current) mainFadeIn(mainAudioRef.current)
  }, [bgmStarted, mainFadeIn])

  // page가 story/complete로 가면 메인 BGM 페이드아웃
  // title/select로 돌아오면 페이드인
  useEffect(() => {
    const audio = mainAudioRef.current
    if (!audio || !bgmStarted) return
    if (page === 'title' || page === 'select' || page === 'complete') {
      if (audio.paused) mainFadeIn(audio)
    } else {
      if (!audio.paused) mainFadeOut(audio)
    }
  }, [page, bgmStarted])

  useEffect(() => {
    const state = initializeGame()
    setGameState(state)
    if (window.location.pathname === '/admin') setPage('admin')
    const handleKeyPress = (e) => {
      if (e.ctrlKey && e.shiftKey && e.code === 'KeyA') setPage('admin')
    }
    window.addEventListener('keydown', handleKeyPress)
    return () => window.removeEventListener('keydown', handleKeyPress)
  }, [])

  const handleStartGame = (nickname) => {
    const newState = { ...gameState, nickname }
    setGameState(newState)
    setPage('select')
  }
  const handleContinue = () => {
    if (gameState?.lastChapter) { setCurrentChapter(gameState.lastChapter); setPage('story') }
  }
  const handleSelectChapter = (chapterNum) => {
    setCurrentChapter(chapterNum); setCurrentScene(0); setPage('story')
  }
  const handleChapterComplete = () => {
    saveProgress(gameState.nickname, currentChapter); setPage('complete')
  }
  const handleContinueToNext = () => {
    const next = currentChapter + 1
    if (next <= 12) { setCurrentChapter(next); setCurrentScene(0); setPage('story') }
    else setPage('select')
  }
  const handleBackToSelect = () => setPage('select')

  if (!gameState) return <div>Loading...</div>

  return (
    <>
      {page === 'title' && (
        <TitlePage
          onStart={handleStartGame}
          onContinue={handleContinue}
          canContinue={!!gameState.lastChapter}
          onTap={startMainBgm}
          bgmStarted={bgmStarted}
        />
      )}
      {page === 'select' && (
        <ChapterSelect
          nickname={gameState.nickname}
          completedChapters={gameState.completedChapters}
          onSelectChapter={handleSelectChapter}
        />
      )}
      {page === 'story' && currentChapter !== null && (
        <StoryPage
          chapter={currentChapter}
          onComplete={handleChapterComplete}
          onBack={handleBackToSelect}
          onScene={setCurrentScene}
          onGoTitle={() => setPage('title')}
          onGoSelect={handleBackToSelect}
        />
      )}
      {page === 'complete' && currentChapter !== null && (
        <ChapterComplete
          chapter={currentChapter}
          onContinueNext={handleContinueToNext}
          onBackToSelect={handleBackToSelect}
        />
      )}
      {page === 'admin' && (
        <AdminPanel onBack={() => setPage('title')} />
      )}
    </>
  )
}
