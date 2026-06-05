/**
 * ChapterComplete.jsx — 챕터 완료 화면
 *
 * 역할:
 *  - 챕터를 완료했을 때 표시되는 축하 화면
 *  - "다음 챕터" 또는 "챕터 목록으로" 선택 제공
 *
 * Props:
 *  chapter: number        — 방금 완료한 챕터 번호
 *  onContinueNext()       — 다음 챕터로 이동 콜백 (App.jsx의 handleContinueToNext)
 *  onBackToSelect()       — 챕터 선택 화면으로 돌아가기 콜백
 */
import { motion } from 'framer-motion'
import { Trophy, Sparkles } from 'lucide-react'

export default function ChapterComplete({ chapter, onContinueNext, onBackToSelect }) {
  return (
    <div className="size-full relative overflow-hidden bg-gradient-to-br from-[#1a365d] via-[#2d3f6f] to-[#5a2d7c]">

      {/* ── 배경 글로우 이펙트 ── */}
      <div className="absolute inset-0 overflow-hidden">
        <motion.div
          className="absolute top-1/2 left-1/2 w-[600px] h-[600px] bg-yellow-400/10 rounded-full blur-3xl"
          animate={{ scale: [1, 1.2, 1], opacity: [0.3, 0.5, 0.3] }}
          transition={{ duration: 4, repeat: Infinity, ease: 'easeInOut' }}
          style={{ transform: 'translate(-50%, -50%)' }}
        />
      </div>

      {/* ── 메인 콘텐츠 ── */}
      <div className="relative z-10 size-full flex flex-col items-center justify-center p-10">

        {/* 트로피 아이콘 */}
        <motion.div
          initial={{ opacity: 0, scale: 0 }}
          animate={{ opacity: 1, scale: 1 }}
          transition={{ duration: 0.8, delay: 0.2 }}
          className="mb-8"
        >
          <Trophy className="w-24 h-24 text-yellow-300" />
        </motion.div>

        {/* 축하 텍스트 */}
        <motion.h1
          initial={{ opacity: 0, y: -30 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8 }}
          className="text-5xl md:text-6xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-amber-300 via-yellow-200 to-amber-400 mb-4 text-center"
        >
          축하합니다!
        </motion.h1>

        {/* 완료한 챕터 정보 */}
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, delay: 0.2 }}
          className="text-center mb-12"
        >
          <p className="text-2xl text-white mb-2">
            챕터 {chapter}를 완료했습니다!
          </p>
          <p className="text-lg text-blue-100/70">
            신앙 여정을 계속해보세요
          </p>
        </motion.div>

        {/* 경험치 표시 (현재는 고정값, 추후 실제 보상 시스템 연동 예정) */}
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.8, delay: 0.4 }}
          className="mb-12 flex items-center gap-4"
        >
          <Sparkles className="w-8 h-8 text-yellow-300" />
          <p className="text-xl text-yellow-200">경험치 +100</p>
          <Sparkles className="w-8 h-8 text-yellow-300" />
        </motion.div>

        {/* ── 파티클 이펙트 (장식용) ── */}
        <div className="absolute inset-0 pointer-events-none overflow-hidden">
          {[...Array(15)].map((_, i) => (
            <motion.div
              key={i}
              className="absolute w-2 h-2 bg-yellow-300 rounded-full"
              style={{
                left: `${Math.random() * 100}%`,
                top: `${Math.random() * 100}%`,
              }}
              animate={{ y: [0, -100, -200], opacity: [1, 0.5, 0] }}
              transition={{
                duration: 3 + Math.random() * 2,
                repeat: Infinity,
                delay: Math.random() * 2,
              }}
            />
          ))}
        </div>

        {/* ── 버튼 그룹 ── */}
        <motion.div
          initial={{ opacity: 0, y: 30 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8, delay: 0.6 }}
          className="flex flex-col gap-4 w-full max-w-sm"
        >
          {/* 다음 챕터 — App.jsx에서 11챕터 이후면 챕터 선택으로 이동 처리 */}
          <button
            onClick={onContinueNext}
            className="w-full py-4 px-6 bg-gradient-to-r from-green-500 to-emerald-500 hover:from-green-400 hover:to-emerald-400 text-white font-semibold rounded-xl shadow-lg hover:shadow-xl transition-all duration-300"
          >
            다음 챕터 →
          </button>
          <button
            onClick={onBackToSelect}
            className="w-full py-4 px-6 bg-white/10 backdrop-blur-sm border-2 border-white/20 hover:border-white/40 text-white font-semibold rounded-xl transition-all duration-300"
          >
            챕터 목록으로
          </button>
        </motion.div>
      </div>
    </div>
  )
}
