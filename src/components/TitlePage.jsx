import { useState, useEffect, useRef } from 'react'
import { motion } from 'framer-motion'
import { Book, Sparkles } from 'lucide-react'

const MAIN_BGM_URL = 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/main-theme-marimba-meadow.mp3'
const FADE_DURATION = 1500

export default function TitlePage({ onStart, onContinue, canContinue }) {
  const [nickname, setNickname] = useState('')
  const [hasNickname, setHasNickname] = useState(false)
  const [hasSavedGame, setHasSavedGame] = useState(canContinue)
  const audioRef = useRef(null)
  const fadeRef = useRef(null)

  const clearFade = () => {
    if (fadeRef.current) { clearInterval(fadeRef.current); fadeRef.current = null }
  }

  const fadeIn = (audio) => {
    clearFade()
    audio.volume = 0
    audio.play().catch(() => {})
    fadeRef.current = setInterval(() => {
      if (audio.volume < 0.95) audio.volume = Math.min(1, audio.volume + 0.05)
      else { audio.volume = 1; clearFade() }
    }, 50)
  }

  const fadeOut = (audio, onDone) => {
    clearFade()
    const step = Math.max(0.02, audio.volume / (FADE_DURATION / 50))
    fadeRef.current = setInterval(() => {
      if (audio.volume > step) audio.volume = Math.max(0, audio.volume - step)
      else { audio.volume = 0; audio.pause(); clearFade(); onDone?.() }
    }, 50)
  }

  // muted 자동재생 → 즉시 unmute + 페이드인 (브라우저 자동재생 정책 우회)
  useEffect(() => {
    const audio = new Audio(MAIN_BGM_URL)
    audio.muted = true
    audio.volume = 0
    audioRef.current = audio
    audio.addEventListener('ended', () => { audio.currentTime = 0; fadeIn(audio) })

    audio.play().then(() => {
      audio.muted = false
      fadeIn(audio)
    }).catch(() => {})

    return () => { clearFade(); audio.pause(); audioRef.current = null }
  }, [])

  // 게임 시작 시 BGM 페이드아웃
  const stopBgmAndRun = (fn) => {
    const audio = audioRef.current
    if (audio && !audio.paused) fadeOut(audio, fn)
    else fn()
  }

  useEffect(() => {
    const savedNickname = localStorage.getItem('biblequest_nickname')
    if (savedNickname) {
      setNickname(savedNickname)
      setHasNickname(true)
    }
  }, [])

  const handleStartGame = () => {
    if (!hasNickname && nickname.trim()) {
      localStorage.setItem('biblequest_nickname', nickname.trim())
      setHasNickname(true)
    }
    stopBgmAndRun(() => onStart(nickname.trim() || '익명'))
  }

  const handleContinue = () => {
    stopBgmAndRun(() => onContinue())
  }

  return (
    <div className="size-full relative overflow-hidden">
      {/* 배경 그라데이션 */}
      <div className="absolute inset-0 bg-gradient-to-br from-[#1a365d] via-[#2d3f6f] to-[#5a2d7c]">
        {/* 빛 효과 */}
        <div className="absolute inset-0 overflow-hidden">
          <motion.div
            className="absolute top-[-50%] left-1/2 w-[500px] h-[500px] bg-white/10 rounded-full blur-3xl"
            animate={{
              y: [0, 30, 0],
              opacity: [0.3, 0.5, 0.3],
            }}
            transition={{
              duration: 4,
              repeat: Infinity,
              ease: 'easeInOut',
            }}
            style={{ transform: 'translateX(-50%)' }}
          />
        </div>
      </div>

      {/* 메인 콘텐츠 */}
      <div className="relative z-10 size-full flex flex-col items-center justify-between p-10 md:p-16">
        {/* 상단 영역 - 타이틀 */}
        <motion.div
          className="flex-none text-center pt-8 md:pt-12"
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8 }}
        >
          <h1 className="text-5xl md:text-6xl lg:text-7xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-amber-300 via-yellow-200 to-amber-400 mb-3">
            Bible Quest
          </h1>
          <p className="text-xl md:text-2xl text-blue-100/90">신앙 성장 RPG</p>
        </motion.div>

        {/* 중앙 영역 - 아이콘 */}
        <motion.div
          className="flex-1 flex items-center justify-center"
          initial={{ opacity: 0, scale: 0.8 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.8, delay: 0.2 }}
        >
          <div className="relative">
            {/* 배경 원형 효과 */}
            <motion.div
              className="absolute inset-0 rounded-full bg-yellow-400/20 blur-2xl"
              animate={{
                scale: [1, 1.2, 1],
                opacity: [0.3, 0.5, 0.3],
              }}
              transition={{
                duration: 3,
                repeat: Infinity,
                ease: 'easeInOut',
              }}
              style={{ width: '250px', height: '250px', margin: '-25px' }}
            />

            {/* 아이콘 조합 */}
            <div className="relative w-[200px] h-[200px] flex items-center justify-center">
              <Book className="w-32 h-32 text-amber-300" strokeWidth={1.5} />
              <Sparkles className="absolute top-4 right-4 w-12 h-12 text-yellow-200" />
              <Sparkles className="absolute bottom-4 left-4 w-8 h-8 text-yellow-300" />
            </div>
          </div>
        </motion.div>

        {/* 하단 영역 - 입력 및 버튼 */}
        <motion.div
          className="flex-none w-full max-w-md space-y-5"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, delay: 0.4 }}
        >
          {/* 닉네임 입력 (초기 1회만) */}
          {!hasNickname && (
            <motion.div
              initial={{ opacity: 0, height: 0 }}
              animate={{ opacity: 1, height: 'auto' }}
              transition={{ duration: 0.5 }}
            >
              <input
                type="text"
                placeholder="닉네임을 입력하세요"
                value={nickname}
                onChange={(e) => setNickname(e.target.value)}
                onKeyPress={(e) => e.key === 'Enter' && handleStartGame()}
                className="w-full px-6 py-3 bg-white/10 backdrop-blur-sm border-2 border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:border-amber-300/50 transition-all"
                maxLength={20}
                autoFocus
              />
            </motion.div>
          )}

          {/* 버튼 그룹 */}
          <div className="space-y-4">
            {/* 게임 시작 버튼 */}
            <motion.button
              onClick={handleStartGame}
              disabled={!hasNickname && !nickname.trim()}
              className="w-full py-4 px-6 bg-gradient-to-r from-amber-400 to-yellow-400 hover:from-amber-300 hover:to-yellow-300 text-gray-900 font-semibold rounded-xl shadow-lg hover:shadow-xl transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed"
              whileHover={{ scale: 1.02 }}
              whileTap={{ scale: 0.98 }}
            >
              {hasNickname ? '새로 시작하기' : '게임 시작'}
            </motion.button>

            {/* 이어하기 버튼 (진행 중일 때만) */}
            {hasSavedGame && hasNickname && (
              <motion.button
                onClick={handleContinue}
                className="w-full py-4 px-6 bg-gradient-to-r from-green-500 to-emerald-500 hover:from-green-400 hover:to-emerald-400 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl transition-all duration-300"
                initial={{ opacity: 0, y: 10 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.2 }}
                whileHover={{ scale: 1.02 }}
                whileTap={{ scale: 0.98 }}
              >
                이어하기
              </motion.button>
            )}
          </div>

          {/* 닉네임 표시 (설정된 경우) */}
          {hasNickname && (
            <p className="text-center text-blue-100/70 text-sm">
              환영합니다, <span className="text-amber-300 font-semibold">{nickname}</span>님
            </p>
          )}
        </motion.div>
      </div>

      {/* 입자 효과 */}
      <div className="absolute inset-0 pointer-events-none">
        {[...Array(20)].map((_, i) => (
          <motion.div
            key={i}
            className="absolute w-1 h-1 bg-white/30 rounded-full"
            style={{
              left: `${Math.random() * 100}%`,
              top: `${Math.random() * 100}%`,
            }}
            animate={{
              y: [0, -30, 0],
              opacity: [0, 1, 0],
            }}
            transition={{
              duration: 3 + Math.random() * 2,
              repeat: Infinity,
              delay: Math.random() * 2,
            }}
          />
        ))}
      </div>
    </div>
  )
}
