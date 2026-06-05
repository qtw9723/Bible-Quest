/**
 * GlobalMenu.jsx — 전역 우상단 고정 메뉴
 *
 * 역할:
 *  - 모든 화면(타이틀 제외 일부)에서 우상단에 고정으로 표시
 *  - 클릭하면 오른쪽에서 사이드바가 슬라이드인
 *  - 화면(page)에 따라 표시할 버튼이 달라짐:
 *      title  → 볼륨만
 *      select → 처음으로 + 볼륨
 *      story  → 처음으로 + 챕터 선택 + 챕터완료스킵(어드민) + 볼륨
 *      complete → 처음으로 + 챕터 선택 + 볼륨
 *  - admin 화면에서는 렌더링하지 않음
 *
 * Props:
 *  page: string              — 현재 화면 식별자
 *  volume: number            — 현재 볼륨 (0.0~1.0)
 *  onVolumeChange(v)         — 볼륨 변경 콜백
 *  onGoTitle()               — 타이틀로 이동 콜백
 *  onGoSelect()              — 챕터 선택으로 이동 콜백
 *  onSkipComplete()          — 챕터 완료 처리 콜백 (story 화면에서만 전달됨)
 */
import { useState } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { Menu, X, Home, BookOpen, Volume2, VolumeX, SkipForward } from 'lucide-react'
import { isAdminLoggedIn } from '../lib/adminAuth'

export default function GlobalMenu({ page, volume, onVolumeChange, onGoTitle, onGoSelect, onSkipComplete }) {
  const [open, setOpen] = useState(false) // 사이드바 열림 여부

  const isStory  = page === 'story'
  const isTitle  = page === 'title'
  const isAdmin  = page === 'admin'
  const isAdminUser = isAdminLoggedIn() // 어드민 쿠키 보유 여부

  // 어드민 화면에서는 메뉴 자체를 숨김
  if (isAdmin) return null

  // ── 화면별로 표시할 버튼 목록 구성 ──
  const menuButtons = []

  // '처음으로' 버튼: 타이틀 화면이 아닐 때만 표시
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

  // '챕터 선택' 버튼: 타이틀·챕터선택 화면이 아닐 때만 표시
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
      {/* ── 우상단 고정 메뉴 아이콘 버튼 (z-[100]로 항상 최상위) ── */}
      <div className="fixed top-4 right-4 z-[100]">
        <button
          onClick={() => setOpen(true)}
          className="w-10 h-10 flex items-center justify-center bg-black/50 backdrop-blur-sm border border-white/20 rounded-xl hover:bg-black/70 transition"
        >
          <Menu size={20} className="text-white" />
        </button>
      </div>

      {/* ── 사이드바 + 딤 배경 ── */}
      <AnimatePresence>
        {open && (
          <>
            {/* 반투명 딤 배경: 클릭하면 사이드바 닫힘 */}
            <motion.div
              key="dim"
              initial={{ opacity: 0 }} animate={{ opacity: 1 }} exit={{ opacity: 0 }}
              transition={{ duration: 0.2 }}
              className="fixed inset-0 z-[110] bg-black/50"
              onClick={() => setOpen(false)}
            />

            {/* 우측 슬라이드인 사이드바 */}
            <motion.div
              key="sidebar"
              initial={{ x: '100%' }} animate={{ x: 0 }} exit={{ x: '100%' }}
              transition={{ type: 'spring', stiffness: 300, damping: 30 }}
              className="fixed top-0 right-0 h-full w-64 z-[120] bg-gray-900/95 backdrop-blur-md border-l border-white/10 flex flex-col"
            >
              {/* 사이드바 헤더 */}
              <div className="flex items-center justify-between px-5 py-4 border-b border-white/10">
                <span className="text-white font-semibold">메뉴</span>
                <button onClick={() => setOpen(false)} className="p-1 hover:bg-white/10 rounded-lg transition">
                  <X size={20} className="text-gray-400" />
                </button>
              </div>

              {/* 버튼 영역 */}
              <div className="flex-1 px-4 py-5 space-y-3 overflow-y-auto">
                {/* 화면별 네비게이션 버튼 (처음으로 / 챕터 선택) */}
                {menuButtons}

                {/* 챕터 완료 스킵 버튼 — 어드민 쿠키가 있고 story 화면일 때만 표시 */}
                {onSkipComplete && isAdminUser && (
                  <button
                    onClick={() => { setOpen(false); onSkipComplete() }}
                    className="w-full flex items-center gap-3 px-4 py-3 bg-white/5 hover:bg-amber-400/10 border border-amber-400/20 rounded-xl text-amber-300 transition"
                  >
                    <SkipForward size={18} className="shrink-0" />
                    <span className="text-sm font-medium">챕터 완료 (테스트)</span>
                  </button>
                )}

                {/* ── 볼륨 조절 섹션 ── */}
                <div className="pt-2 border-t border-white/10">
                  <div className="flex items-center gap-2 mb-3">
                    {/* 음소거 여부에 따라 아이콘 변경 */}
                    {volume === 0
                      ? <VolumeX size={16} className="text-gray-400 shrink-0" />
                      : <Volume2 size={16} className="text-amber-300 shrink-0" />}
                    <span className="text-sm text-gray-300">볼륨</span>
                    <span className="text-xs text-gray-500 ml-auto">{Math.round(volume * 100)}%</span>
                  </div>
                  {/* 볼륨 슬라이더 — 0~1 범위, 0.05 스텝 */}
                  <input
                    type="range" min="0" max="1" step="0.05"
                    value={volume}
                    onChange={(e) => onVolumeChange(parseFloat(e.target.value))}
                    className="w-full accent-amber-400 cursor-pointer"
                  />
                  {/* 음소거 토글 — 현재 볼륨이 0이면 0.7로 복원, 아니면 0으로 설정 */}
                  <button
                    onClick={() => onVolumeChange(volume > 0 ? 0 : 0.7)}
                    className="mt-3 w-full py-2 text-xs text-gray-400 hover:text-white border border-white/10 rounded-lg transition"
                  >
                    {volume === 0 ? '🔊 소리 켜기' : '🔇 음소거'}
                  </button>
                </div>
              </div>

              {/* 사이드바 하단 */}
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
