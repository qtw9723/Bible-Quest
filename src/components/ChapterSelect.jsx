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

export default function ChapterSelect({ nickname, completedChapters = [], completedEndings = {}, onSelectChapter }) {
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
            const completedSet = new Set(completedChapters) // O(1) 조회를 위해 Set 변환
            const sorted = [...chapters].sort((a, b) => a.chapter_num - b.chapter_num)

            return sorted.map((chapter, index) => {
              const isCompleted = completedSet.has(chapter.chapter_num)
              const prev = sorted[index - 1] // 직전 챕터

              /**
               * 해금 조건 (어드민 여부와 무관하게 동일하게 적용):
               *  - 첫 번째 챕터(index===0)이면 항상 해금
               *  - 직전 챕터가 완료된 경우 해금
               * 어드민도 게임 플레이 시에는 일반 유저와 동일한 순서로 진행.
               * (챕터 스킵은 GlobalMenu의 스킵 버튼으로만 가능)
               */
              const isUnlocked = index === 0 || (prev && completedSet.has(prev.chapter_num))
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

                    {/* 진행 상태 텍스트 + 엔딩 수집 현황 */}
                    <div className="space-y-2">
                      <div className="text-sm text-white/50">
                        {isCompleted ? '✓ 완료됨' : locked ? '🔒 잠김' : '▶ 시작 가능'}
                      </div>

                      {/* 완료된 챕터: 항상 엔딩 수집 현황 표시
                          ● = 해당 엔딩 완료, ○ = 미완료 (0/3도 표시 — 재플레이 유도)
                          3개 모두 완료 시 amber 강조 */}
                      {isCompleted && (() => {
                        const done = completedEndings[String(chapter.chapter_num)] ?? []
                        const count = done.length
                        const allDone = count === 3
                        return (
                          <div className="flex items-center gap-2 mt-0.5">
                            {/* 3개 점: 각 엔딩(0·1·2) 완료 여부 */}
                            <div className="flex items-center gap-1">
                              {[0, 1, 2].map(i => (
                                <div
                                  key={i}
                                  className={`w-2 h-2 rounded-full transition-colors ${
                                    done.includes(i)
                                      ? 'bg-amber-400 shadow-[0_0_4px_rgba(251,191,36,0.6)]'
                                      : 'bg-white/15'
                                  }`}
                                />
                              ))}
                            </div>
                            <span className={`text-xs font-medium ${
                              allDone ? 'text-amber-300' : 'text-white/35'
                            }`}>
                              {count}/3 엔딩
                            </span>
                          </div>
                        )
                      })()}
                    </div>

                    {/* 잠긴 챕터 호버 툴팁
                        이전 챕터 번호를 명시해 어떤 챕터를 먼저 해야 하는지 안내.
                        카드 하단에 말풍선 형태로 올라옴 (overflow 이슈 없음) */}
                    {locked && prev && (
                      <div className="absolute inset-x-0 bottom-0 flex justify-center pb-4 opacity-0 group-hover:opacity-100 translate-y-1 group-hover:translate-y-0 transition-all duration-200 pointer-events-none">
                        <div className="relative bg-gray-950/95 backdrop-blur-sm border border-amber-400/20 text-white text-xs px-3 py-2 rounded-lg shadow-xl whitespace-nowrap">
                          <span className="text-amber-400 font-semibold">챕터 {prev.chapter_num}</span>
                          <span className="text-white/70">을 완료하면 열립니다</span>
                          {/* 말풍선 꼬리 */}
                          <div className="absolute -bottom-1.5 left-1/2 -translate-x-1/2 w-3 h-3 bg-gray-950 border-b border-r border-amber-400/20 rotate-45" />
                        </div>
                      </div>
                    )}
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
