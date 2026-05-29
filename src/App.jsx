import { useState, useEffect } from 'react'
import TitlePage from './components/TitlePage'
import ChapterSelect from './components/ChapterSelect'
import StoryPage from './components/StoryPage'
import ChapterComplete from './components/ChapterComplete'
import AdminPanel from './components/AdminPanel'
import { initializeGame, saveProgress } from './lib/gameState'

export default function App() {
  const [page, setPage] = useState('title') // title, select, story, complete, admin
  const [gameState, setGameState] = useState(null)
  const [currentChapter, setCurrentChapter] = useState(null)
  const [currentScene, setCurrentScene] = useState(0)

  useEffect(() => {
    const state = initializeGame()
    setGameState(state)

    // URL 경로 확인 - /admin으로 직접 접근 가능
    if (window.location.pathname === '/admin') {
      setPage('admin')
    }

    // 개발 모드: Ctrl+Shift+A로 어드민 패널 열기
    const handleKeyPress = (e) => {
      if (e.ctrlKey && e.shiftKey && e.code === 'KeyA') {
        setPage('admin')
      }
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
    if (gameState?.lastChapter) {
      setCurrentChapter(gameState.lastChapter)
      setPage('story')
    }
  }

  const handleSelectChapter = (chapterNum) => {
    setCurrentChapter(chapterNum)
    setCurrentScene(0)
    setPage('story')
  }

  const handleChapterComplete = () => {
    saveProgress(gameState.nickname, currentChapter)
    setPage('complete')
  }

  const handleContinueToNext = () => {
    const nextChapter = currentChapter + 1
    if (nextChapter <= 12) {
      setCurrentChapter(nextChapter)
      setCurrentScene(0)
      setPage('story')
    } else {
      setPage('select')
    }
  }

  const handleBackToSelect = () => {
    setPage('select')
  }

  if (!gameState) return <div>Loading...</div>

  return (
    <>
      {page === 'title' && (
        <TitlePage
          onStart={handleStartGame}
          onContinue={handleContinue}
          canContinue={!!gameState.lastChapter}
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
