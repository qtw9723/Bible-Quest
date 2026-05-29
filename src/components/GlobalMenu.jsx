import { useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { Menu, X, Home, BookOpen, Volume2, VolumeX, SkipForward } from 'lucide-react'

export default function GlobalMenu({ page, volume, onVolumeChange, onGoTitle, onGoSelect, onSkipComplete }) {
  const [open, setOpen] = useState(false)

  const isStory = page === 'story'
  const isTitle = page === 'title'
  const isAdmin = page === 'admin'

  if (isAdmin) return null

  const menuButtons = []

  if (!isTitle) {
    menuButtons.push(
      <button
        key="home"
        onClick={() => { setOpen(false); onGoTitle?.() }}
        className="w-full flex items-center gap-3 px-4 py-3 bg-white/5 hover:bg-white/10 border border-white/10 rounded-xl text-white transition"
      >
        <Home size={18} className="text-amber-300 shrink-0" />
        <span className="text-sm font-medium">처음으로</span>
      </button>
    )
  }

  if (!isTitle && page !== 'select') {
    menuButtons.push(
      <button
        key="select"
        onClick={() => { setOpen(false); onGoSelect?.() }}
        className="w-full flex items-center gap-3 px-4 py-3 bg-white/5 hover:bg-white/10 border border-white/10 rounded-xl text-white transition"
      >
        <BookOpen size={18} className="text-blue-300 shrink-0" />
        <span className="text-sm font-medium">챕터 선택</span>
      </button>
    )
  }

  return (
    <>
      {/* 메뉴 버튼 */}
      <div className="fixed top-4 right-4 z-[100]">
        <button
          onClick={() => setOpen(true)}
          className="w-10 h-10 flex items-center justify-center bg-black/50 backdrop-blur-sm border border-white/20 rounded-xl hover:bg-black/70 transition"
        >
          <Menu size={20} className="text-white" />
        </button>
      </div>

      {/* 사이드바 */}
      <AnimatePresence>
        {open && (
          <>
            <motion.div
              key="dim"
              initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }}
              transition={{ duration: 0.2 }}
              className="fixed inset-0 z-[110] bg-black/50"
              onClick={() => setOpen(false)}
            />
            <motion.div
              key="sidebar"
              initial={{ x: '100%' }} animate={{ x: 0 }} exit={{ x: '100%' }}
              transition={{ type: 'spring', stiffness: 300, damping: 30 }}
              className="fixed top-0 right-0 h-full w-64 z-[120] bg-gray-900/95 backdrop-blur-md border-l border-white/10 flex flex-col"
            >
              {/* 헤더 */}
              <div className="flex items-center justify-between px-5 py-4 border-b border-white/10">
                <span className="text-white font-semibold">메뉴</span>
                <button onClick={() => setOpen(false)} className="p-1 hover:bg-white/10 rounded-lg transition">
                  <X size={20} className="text-gray-400" />
                </button>
              </div>

              {/* 버튼 */}
              <div className="flex-1 px-4 py-5 space-y-3 overflow-y-auto">
                {menuButtons}

                {/* 테스트: 챕터 완료 스킵 */}
                {onSkipComplete && (
                  <button
                    onClick={() => { setOpen(false); onSkipComplete() }}
                    className="w-full flex items-center gap-3 px-4 py-3 bg-white/5 hover:bg-amber-400/10 border border-amber-400/20 rounded-xl text-amber-300 transition"
                  >
                    <SkipForward size={18} className="shrink-0" />
                    <span className="text-sm font-medium">챕터 완료 (테스트)</span>
                  </button>
                )}

                {/* 볼륨 */}
                <div className="pt-2 border-t border-white/10">
                  <div className="flex items-center gap-2 mb-3">
                    {volume === 0
                      ? <VolumeX size={16} className="text-gray-400 shrink-0" />
                      : <Volume2 size={16} className="text-amber-300 shrink-0" />}
                    <span className="text-sm text-gray-300">볼륨</span>
                    <span className="text-xs text-gray-500 ml-auto">{Math.round(volume * 100)}%</span>
                  </div>
                  <input
                    type="range" min="0" max="1" step="0.05"
                    value={volume}
                    onChange={(e) => onVolumeChange(parseFloat(e.target.value))}
                    className="w-full accent-amber-400 cursor-pointer"
                  />
                  {/* 뮤트 토글 */}
                  <button
                    onClick={() => onVolumeChange(volume > 0 ? 0 : 0.7)}
                    className="mt-3 w-full py-2 text-xs text-gray-400 hover:text-white border border-white/10 rounded-lg transition"
                  >
                    {volume === 0 ? '🔊 소리 켜기' : '🔇 음소거'}
                  </button>
                </div>
              </div>

              <div className="px-5 py-4 border-t border-white/10">
                <p className="text-xs text-gray-600 text-center">Bible Quest</p>
              </div>
            </motion.div>
          </>
        )}
      </AnimatePresence>
    </>
  )
}
