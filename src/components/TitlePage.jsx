import { useState, useEffect } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { Book, Sparkles, Users } from 'lucide-react'
import { getTeams } from '../lib/api'

export default function TitlePage({ onStart, onContinue, canContinue, onTap, bgmStarted }) {
  const [nickname, setNickname] = useState('')
  const [teamId, setTeamId] = useState('')
  const [teams, setTeams] = useState([])
  const [hasNickname, setHasNickname] = useState(false)
  const [savedNickname, setSavedNickname] = useState('')
  const [savedTeamName, setSavedTeamName] = useState('')
  const [hasSavedGame] = useState(canContinue)

  useEffect(() => {
    // 저장된 게임 정보 불러오기
    try {
      const saved = JSON.parse(localStorage.getItem('biblequest_gamestate') || '{}')
      if (saved.nickname) {
        setSavedNickname(saved.nickname)
        setSavedTeamName(saved.teamName || '')
        setHasNickname(true)
      }
    } catch (_) {}

    // 팀 목록 불러오기
    getTeams().then(setTeams).catch(() => {})
  }, [])

  const selectedTeam = teams.find(t => t.id === teamId)

  const handleStartGame = () => {
    const name = nickname.trim() || savedNickname
    if (!name) return
    if (!hasNickname) {
      const state = { nickname: name, teamId: teamId || null, teamName: selectedTeam?.name || null, completedChapters: [], lastChapter: null, createdAt: new Date().toISOString() }
      localStorage.setItem('biblequest_gamestate', JSON.stringify(state))
      setHasNickname(true)
    }
    onStart(name, teamId || null, selectedTeam?.name || null)
  }

  const handleNewGame = () => {
    // 기존 저장 데이터 초기화
    localStorage.removeItem('biblequest_gamestate')
    setHasNickname(false)
    setNickname('')
    setTeamId('')
    setSavedNickname('')
    setSavedTeamName('')
  }

  return (
    <div className="size-full relative overflow-hidden" onClick={!bgmStarted ? onTap : undefined}>
      {/* 배경 */}
      <div className="absolute inset-0 bg-gradient-to-br from-[#1a365d] via-[#2d3f6f] to-[#5a2d7c]">
        <div className="absolute inset-0 overflow-hidden">
          <motion.div
            className="absolute top-[-50%] left-1/2 w-[500px] h-[500px] bg-white/10 rounded-full blur-3xl"
            animate={{ y: [0, 30, 0], opacity: [0.3, 0.5, 0.3] }}
            transition={{ duration: 4, repeat: Infinity, ease: 'easeInOut' }}
            style={{ transform: 'translateX(-50%)' }}
          />
        </div>
      </div>

      {/* 콘텐츠 */}
      <div className="relative z-10 size-full flex flex-col items-center justify-between p-10 md:p-16">
        {/* 타이틀 */}
        <motion.div className="flex-none text-center pt-8 md:pt-12"
          initial={{ opacity: 0, y: -20 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.8 }}>
          <h1 className="text-5xl md:text-6xl lg:text-7xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-amber-300 via-yellow-200 to-amber-400 mb-3">
            Bible Quest
          </h1>
          <p className="text-xl md:text-2xl text-blue-100/90">신앙 성장 RPG</p>
        </motion.div>

        {/* 아이콘 */}
        <motion.div className="flex-1 flex items-center justify-center"
          initial={{ opacity: 0, scale: 0.8 }} animate={{ opacity: 1, scale: 1 }} transition={{ duration: 0.8, delay: 0.2 }}>
          <div className="relative">
            <motion.div className="absolute inset-0 rounded-full bg-yellow-400/20 blur-2xl"
              animate={{ scale: [1, 1.2, 1], opacity: [0.3, 0.5, 0.3] }}
              transition={{ duration: 3, repeat: Infinity, ease: 'easeInOut' }}
              style={{ width: '250px', height: '250px', margin: '-25px' }} />
            <div className="relative w-[200px] h-[200px] flex items-center justify-center">
              <Book className="w-32 h-32 text-amber-300" strokeWidth={1.5} />
              <Sparkles className="absolute top-4 right-4 w-12 h-12 text-yellow-200" />
              <Sparkles className="absolute bottom-4 left-4 w-8 h-8 text-yellow-300" />
            </div>
          </div>
        </motion.div>

        {/* 입력 영역 */}
        <motion.div className="flex-none w-full max-w-md space-y-4"
          initial={{ opacity: 0, y: 20 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 0.8, delay: 0.4 }}>

          {!hasNickname ? (
            /* ── 신규 로그인 ── */
            <>
              <div>
                <input
                  type="text" placeholder="이름을 입력하세요"
                  value={nickname} onChange={(e) => setNickname(e.target.value)}
                  onKeyPress={(e) => e.key === 'Enter' && handleStartGame()}
                  className="w-full px-6 py-3 bg-white/10 backdrop-blur-sm border-2 border-white/20 rounded-xl text-white placeholder-white/50 focus:outline-none focus:border-amber-300/50 transition-all"
                  maxLength={20} autoFocus
                />
              </div>

              {/* 팀 선택 */}
              {teams.length > 0 && (
                <div>
                  <select
                    value={teamId} onChange={(e) => setTeamId(e.target.value)}
                    className="w-full px-6 py-3 bg-white/10 backdrop-blur-sm border-2 border-white/20 rounded-xl text-white focus:outline-none focus:border-amber-300/50 transition-all appearance-none"
                    style={{ colorScheme: 'dark' }}
                  >
                    <option value="" className="bg-gray-800">팀을 선택하세요 (선택사항)</option>
                    {teams.map(t => (
                      <option key={t.id} value={t.id} className="bg-gray-800">{t.name}</option>
                    ))}
                  </select>
                </div>
              )}

              <motion.button onClick={handleStartGame}
                disabled={!nickname.trim()}
                className="w-full py-4 px-6 bg-gradient-to-r from-amber-400 to-yellow-400 hover:from-amber-300 hover:to-yellow-300 text-gray-900 font-semibold rounded-xl shadow-lg transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed"
                whileHover={{ scale: 1.02 }} whileTap={{ scale: 0.98 }}>
                게임 시작
              </motion.button>
            </>
          ) : (
            /* ── 기존 유저 ── */
            <>
              <div className="text-center py-2">
                <p className="text-blue-100/70 text-sm mb-1">
                  환영합니다, <span className="text-amber-300 font-semibold">{savedNickname}</span>님
                </p>
                {savedTeamName && (
                  <p className="text-blue-100/50 text-xs flex items-center justify-center gap-1">
                    <Users size={12} /> {savedTeamName}
                  </p>
                )}
              </div>

              <div className="space-y-3">
                {hasSavedGame && (
                  <motion.button onClick={() => onContinue()}
                    className="w-full py-4 px-6 bg-gradient-to-r from-green-500 to-emerald-500 hover:from-green-400 hover:to-emerald-400 text-white font-semibold rounded-xl shadow-lg transition-all duration-300"
                    initial={{ opacity: 0, y: 10 }} animate={{ opacity: 1, y: 0 }} transition={{ delay: 0.1 }}
                    whileHover={{ scale: 1.02 }} whileTap={{ scale: 0.98 }}>
                    이어하기
                  </motion.button>
                )}
                <motion.button onClick={() => onStart(savedNickname, null, savedTeamName || null)}
                  className="w-full py-4 px-6 bg-gradient-to-r from-amber-400 to-yellow-400 hover:from-amber-300 hover:to-yellow-300 text-gray-900 font-semibold rounded-xl shadow-lg transition-all duration-300"
                  whileHover={{ scale: 1.02 }} whileTap={{ scale: 0.98 }}>
                  새로 시작하기
                </motion.button>
                <button onClick={handleNewGame}
                  className="w-full py-2 text-sm text-white/30 hover:text-white/60 transition-colors">
                  다른 계정으로 시작
                </button>
              </div>
            </>
          )}
        </motion.div>
      </div>

      {/* TAP TO START 오버레이 */}
      <AnimatePresence>
        {!bgmStarted && (
          <motion.div key="tap-overlay"
            initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }}
            transition={{ duration: 0.4 }}
            className="absolute inset-0 z-50 flex flex-col items-center justify-center cursor-pointer select-none"
            style={{ background: 'radial-gradient(ellipse at center, rgba(0,0,0,0.3) 0%, rgba(0,0,0,0.7) 100%)' }}>
            <motion.div animate={{ opacity: [1, 0.4, 1] }} transition={{ duration: 1.8, repeat: Infinity, ease: 'easeInOut' }} className="text-center">
              <p className="text-white text-2xl sm:text-3xl font-light tracking-widest mb-2">TAP TO START</p>
              <p className="text-white/50 text-sm tracking-wider">화면을 탭하여 시작하세요</p>
            </motion.div>
          </motion.div>
        )}
      </AnimatePresence>

      {/* 입자 효과 */}
      <div className="absolute inset-0 pointer-events-none overflow-hidden">
        {[...Array(20)].map((_, i) => (
          <motion.div key={i} className="absolute w-1 h-1 bg-white/30 rounded-full"
            style={{ left: `${Math.random() * 100}%`, top: `${Math.random() * 100}%` }}
            animate={{ y: [0, -30, 0], opacity: [0, 1, 0] }}
            transition={{ duration: 3 + Math.random() * 2, repeat: Infinity, delay: Math.random() * 2 }} />
        ))}
      </div>
    </div>
  )
}
