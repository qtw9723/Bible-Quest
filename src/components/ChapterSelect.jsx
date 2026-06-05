/**
 * ChapterSelect.jsx — 챕터 선택 화면
 *
 * 역할:
 *  - Supabase에서 챕터 목록을 조회해 그리드로 표시
 *  - 순차 잠금: 첫 챕터만 처음부터 열려 있고, 이전 챕터를 완료해야 다음 챕터가 해금됨
 *  - 어드민(쿠키 있음): 전체 챕터 잠금 해제 (테스트·검수용)
 *  - 카드 상태: 완료(✓ 초록), 해금(▶ 시작 가능), 잠김(🔒 흐림)
 *
 * Props:
 *  nickname: string             — 플레이어 이름 (상단 인사말용)
 *  completedChapters: number[]  — 완료한 챕터 번호 목록
 *  onSelectChapter(chapterNum)  — 챕터 선택 콜백
 */
import { useState, useEffect } from 'react'
import { motion } from 'framer-motion'
import { getChapters } from '../lib/api'
import { isAdminLoggedIn } from '../lib/adminAuth'

export default function ChapterSelect({ nickname, completedChapters = [], onSelectChapter }) {
  const [chapters, setChapters] = useState([])
  const [isLoading, setIsLoading] = useState(true)

  // 컴포넌트 마운트 시 Supabase에서 챕터 목록 조회
  useEffect(() => {
    const loadChapters = async () => {
      try {
        const data = await getChapters()
        setChapters(data || [])
      } catch (err) {
        console.error('Failed to load chapters:', err)
      } finally {
        setIsLoading(false)
      }
    }
    loadChapters()
  }, [])

  if (isLoading) {
    return (
      <div className="size-full flex items-center justify-center bg-gradient-to-br from-[#1a365d] via-[#2d3f6f] to-[#5a2d7c]">
        <div className="text-white text-xl">챕터를 불러오는 중...</div>
      </div>
    )
  }

  return (
    <div className="size-full relative overflow-hidden bg-gradient-to-br from-[#1a365d] via-[#2d3f6f] to-[#5a2d7c]">

      {/* ── 배경 글로우 이펙트 ── */}
      <div className="absolute inset-0 overflow-hidden">
        <motion.div
          className="absolute top-[-50%] left-1/2 w-[500px] h-[500px] bg-white/10 rounded-full blur-3xl"
          animate={{ y: [0, 30, 0], opacity: [0.3, 0.5, 0.3] }}
          transition={{ duration: 4, repeat: Infinity, ease: 'easeInOut' }}
          style={{ transform: 'translateX(-50%)' }}
        />
      </div>

      {/* ── 메인 콘텐츠 ── */}
      <div className="relative z-10 size-full flex flex-col p-10 md:p-16 overflow-hidden">

        {/* 헤더 */}
        <motion.div
          className="text-center mb-12"
          initial={{ opacity: 0, y: -20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8 }}
        >
          <h1 className="text-4xl md:text-5xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-amber-300 via-yellow-200 to-amber-400 mb-2">
            챕터 선택
          </h1>
          <p className="text-xl text-blue-100/90">
            안녕하세요, <span className="text-amber-300 font-semibold">{nickname}</span>님
          </p>
        </motion.div>

        {/* ── 챕터 그리드 ── */}
        <motion.div
          className="flex-1 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 overflow-y-auto overflow-x-hidden pb-2"
          style={{ scrollbarGutter: 'stable' }} // 스크롤바 나타날 때 레이아웃 흔들림 방지
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.8, delay: 0.2 }}
        >
          {(() => {
            const isAdmin = isAdminLoggedIn()              // 어드민 여부 (전체 해금)
            const completedSet = new Set(completedChapters) // O(1) 조회를 위해 Set 변환
            const sorted = [...chapters].sort((a, b) => a.chapter_num - b.chapter_num)

            return sorted.map((chapter, index) => {
              const isCompleted = completedSet.has(chapter.chapter_num)
              const prev = sorted[index - 1] // 직전 챕터

              /**
               * 해금 조건:
               *  - 어드민이면 항상 해금
               *  - 첫 번째 챕터(index===0)이면 항상 해금
               *  - 직전 챕터가 완료된 경우 해금
               */
              const isUnlocked = isAdmin || index === 0 || (prev && completedSet.has(prev.chapter_num))
              const locked = !isUnlocked

              return (
                <motion.button
                  key={chapter.id}
                  onClick={() => { if (!locked) onSelectChapter(chapter.chapter_num) }}
                  disabled={locked}
                  className={`relative group text-left ${locked ? 'cursor-not-allowed' : ''}`}
                  initial={{ opacity: 0, y: 20 }}
                  animate={{ opacity: locked ? 0.55 : 1, y: 0 }} // 잠긴 카드는 흐리게
                  transition={{ delay: 0.1 + index * 0.05 }}
                  whileHover={locked ? undefined : { scale: 1.02 }} // 잠긴 카드는 호버 효과 없음
                >
                  <div className={`backdrop-blur-md border-2 rounded-2xl p-6 h-full transition-all duration-300
                    ${locked
                      ? 'bg-white/5 border-white/10'
                      : 'bg-white/10 border-white/20 hover:border-amber-400/50 hover:bg-amber-400/10'
                    }`}
                  >
                    {/* ── 우상단 배지: 완료 ✓ / 잠김 🔒 / 없음(시작 가능) ── */}
                    {isCompleted ? (
                      <div className="absolute top-4 right-4 w-8 h-8 bg-green-500 rounded-full flex items-center justify-center">
                        <span className="text-white text-lg">✓</span>
                      </div>
                    ) : locked ? (
                      <div className="absolute top-4 right-4 w-8 h-8 bg-black/40 rounded-full flex items-center justify-center">
                        <span className="text-lg">🔒</span>
                      </div>
                    ) : null}

                    {/* 챕터 번호 (잠김 여부에 따라 색상 변경) */}
                    <div className={`text-5xl font-bold mb-2 ${locked ? 'text-white/30' : 'text-amber-300'}`}>
                      {chapter.chapter_num}
                    </div>

                    {/* 챕터 제목 */}
                    <h3 className={`text-xl font-semibold mb-2 ${locked ? 'text-white/50' : 'text-white'}`}>
                      {chapter.title}
                    </h3>

                    {/* 설명 (잠긴 경우 안내 문구 표시) */}
                    <p className="text-white/60 text-sm mb-4">
                      {locked ? '이전 챕터를 완료하면 열립니다.' : (chapter.description || '신약 성경 스토리')}
                    </p>

                    {/* 진행 상태 텍스트 */}
                    <div className="text-sm text-white/50">
                      {isCompleted ? '✓ 완료됨' : locked ? '🔒 잠김' : '▶ 시작 가능'}
                    </div>
                  </div>
                </motion.button>
              )
            })
          })()}
        </motion.div>
      </div>
    </div>
  )
}
