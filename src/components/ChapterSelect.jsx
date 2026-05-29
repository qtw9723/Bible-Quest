import { useState, useEffect } from 'react'
import { motion } from 'framer-motion'
import { getChapters } from '../lib/api'

export default function ChapterSelect({ nickname, completedChapters = [], onSelectChapter }) {
  const [chapters, setChapters] = useState([])
  const [isLoading, setIsLoading] = useState(true)

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
      {/* 배경 이펙트 */}
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

      {/* 콘텐츠 */}
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

        {/* 챕터 그리드 */}
        <motion.div
          className="flex-1 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 overflow-y-auto overflow-x-hidden pb-2"
          style={{ scrollbarGutter: 'stable' }}
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 0.8, delay: 0.2 }}
        >
          {chapters.map((chapter, index) => {
            const isCompleted = completedChapters.includes(chapter.id)
            return (
              <motion.button
                key={chapter.id}
                onClick={() => onSelectChapter(chapter.chapter_num)}
                className="relative group"
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ delay: 0.1 + index * 0.05 }}
                whileHover={{ scale: 1.02 }}
              >
                <div className="bg-white/10 backdrop-blur-md border-2 border-white/20 rounded-2xl p-6 h-full hover:border-amber-400/50 hover:bg-amber-400/10 transition-all duration-300">
                  {/* 완료 배지 */}
                  {isCompleted && (
                    <div className="absolute top-4 right-4 w-8 h-8 bg-green-500 rounded-full flex items-center justify-center">
                      <span className="text-white text-lg">✓</span>
                    </div>
                  )}

                  {/* 챕터 번호 */}
                  <div className="text-5xl font-bold text-amber-300 mb-2">
                    {chapter.chapter_num}
                  </div>

                  {/* 제목 */}
                  <h3 className="text-xl font-semibold text-white mb-2">
                    {chapter.title}
                  </h3>

                  {/* 설명 */}
                  <p className="text-white/70 text-sm mb-4">
                    {chapter.description || '신약 성경 스토리'}
                  </p>

                  {/* 상태 표시 */}
                  <div className="text-sm text-white/50">
                    {isCompleted ? '✓ 완료됨' : '미진행'}
                  </div>
                </div>
              </motion.button>
            )
          })}
        </motion.div>
      </div>
    </div>
  )
}
