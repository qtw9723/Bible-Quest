import { useState, useEffect } from 'react'
import TitlePage from './components/TitlePage'
import ChapterSelect from './components/ChapterSelect'
import StoryPage from './components/StoryPage'
import ChapterComplete from './components/ChapterComplete'
import { initializeGame, saveProgress } from './lib/gameState'
import './App.css'

export default function App() {
  const [page, setPage] = useState('title') // title, select, story, complete
  const [gameState, setGameState] = useState(null)
  const [currentChapter, setCurrentChapter] = useState(null)
  const [currentScene, setCurrentScene] = useState(0)

  useEffect(() => {
    const state = initializeGame()
    setGameState(state)
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
    </>
  )
}
