import { useState, useEffect } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { getStoryData } from '../lib/api'

export default function StoryPage({ chapter, onComplete, onScene }) {
  const [scenes, setScenes] = useState([])
  const [currentSceneIndex, setCurrentSceneIndex] = useState(0)
  const [isLoading, setIsLoading] = useState(true)
  const [imageLoaded, setImageLoaded] = useState(false)
  const [error, setError] = useState(null)

  // 챕터 데이터 로드 (Supabase에서)
  useEffect(() => {
    const loadScenes = async () => {
      setIsLoading(true)
      setError(null)
      try {
        const data = await getStoryData(chapter)
        if (data && data.scenes && data.scenes.length > 0) {
          setScenes(data.scenes)
          setCurrentSceneIndex(0)
        } else {
          setError('스토리 데이터를 찾을 수 없습니다.')
        }
      } catch (err) {
        console.error('Failed to load story data:', err)
        setError('스토리를 불러오는 중 오류가 발생했습니다.')
      } finally {
        setIsLoading(false)
      }
    }

    loadScenes()
  }, [chapter])

  const currentScene = scenes[currentSceneIndex]

  // 배경 이미지 미리 로드
  useEffect(() => {
    if (currentScene?.background) {
      setImageLoaded(false)
      const img = new Image()
      img.src = currentScene.background
      img.onload = () => setImageLoaded(true)
      img.onerror = () => {
        console.error('Failed to load background image:', currentScene.background)
        setImageLoaded(true) // 이미지 로드 실패해도 계속 진행
      }
    }
  }, [currentScene?.background])

  // 선택지 클릭 핸들러
  const handleChoice = (nextSceneId) => {
    if (nextSceneId === null) {
      // 챕터 완료
      onComplete()
    } else {
      // 다음 장면으로 이동
      const nextIndex = scenes.findIndex(s => s.id === nextSceneId)
      if (nextIndex !== -1) {
        setCurrentSceneIndex(nextIndex)
        if (onScene) {
          onScene(nextIndex)
        }
      }
    }
  }

  if (isLoading) {
    return (
      <div className="size-full flex items-center justify-center bg-gradient-to-br from-[#1a365d] via-[#2d3f6f] to-[#5a2d7c]">
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          className="text-white text-xl"
        >
          스토리를 불러오는 중...
        </motion.div>
      </div>
    )
  }

  if (error) {
    return (
      <div className="size-full flex items-center justify-center bg-gradient-to-br from-[#1a365d] via-[#2d3f6f] to-[#5a2d7c]">
        <div className="text-center">
          <p className="text-white text-xl mb-4">{error}</p>
          <button
            onClick={onComplete}
            className="px-6 py-3 bg-amber-400 hover:bg-amber-300 text-gray-900 font-semibold rounded-xl transition-all"
          >
            돌아가기
          </button>
        </div>
      </div>
    )
  }

  if (!currentScene) {
    return (
      <div className="size-full flex items-center justify-center bg-gradient-to-br from-[#1a365d] via-[#2d3f6f] to-[#5a2d7c]">
        <div className="text-white text-xl">장면을 찾을 수 없습니다.</div>
      </div>
    )
  }

  return (
    <div className="size-full relative overflow-hidden">
      {/* 배경 이미지 */}
      <AnimatePresence mode="wait">
        {imageLoaded && currentScene.background && (
          <motion.div
            key={`bg-${currentScene.id}`}
            initial={{ opacity: 0 }}
            animate={{ opacity: 1 }}
            exit={{ opacity: 0 }}
            transition={{ duration: 0.5 }}
            className="absolute inset-0"
          >
            <div
              className="size-full bg-cover bg-center"
              style={{
                backgroundImage: `url(${currentScene.background})`,
                filter: 'brightness(0.5)',
              }}
            />
          </motion.div>
        )}
      </AnimatePresence>

      {/* 어두운 오버레이 */}
      <div className="absolute inset-0 bg-black/30" />

      {/* 캐릭터 이미지 (있는 경우) */}
      {currentScene.character && (
        <AnimatePresence mode="wait">
          <motion.div
            key={`char-${currentScene.id}`}
            initial={{ opacity: 0, x: -50 }}
            animate={{ opacity: 1, x: 0 }}
            exit={{ opacity: 0, x: 50 }}
            transition={{ duration: 0.6 }}
            className="absolute bottom-0 left-0 h-3/5 w-2/5 max-w-md"
          >
            <img
              src={currentScene.character}
              alt="Character"
              className="h-full w-full object-contain object-bottom"
              onError={(e) => {
                console.error('Failed to load character image:', currentScene.character)
                e.target.style.display = 'none'
              }}
            />
          </motion.div>
        </AnimatePresence>
      )}

      {/* 텍스트 및 선택지 영역 */}
      <div className="relative z-10 size-full flex flex-col justify-end p-6 md:p-10">
        <AnimatePresence mode="wait">
          <motion.div
            key={`scene-${currentScene.id}`}
            initial={{ opacity: 0, y: 30 }}
            animate={{ opacity: 1, y: 0 }}
            exit={{ opacity: 0, y: -30 }}
            transition={{ duration: 0.5 }}
            className="w-full max-w-4xl mx-auto"
          >
            {/* 텍스트 카드 */}
            <div className="bg-black/70 backdrop-blur-md rounded-2xl p-6 md:p-8 mb-6 border border-white/10">
              <p className="text-white text-lg md:text-xl leading-relaxed">
                {currentScene.text}
              </p>
            </div>

            {/* 선택지 버튼들 */}
            <div className="space-y-3">
              {currentScene.choices && currentScene.choices.map((choice, index) => (
                <motion.button
                  key={index}
                  onClick={() => handleChoice(choice.next_scene_id)}
                  className="w-full px-6 py-4 bg-white/10 backdrop-blur-sm border-2 border-white/20 rounded-xl text-white text-left hover:bg-amber-400/20 hover:border-amber-400/50 transition-all duration-300 group"
                  initial={{ opacity: 0, x: -20 }}
                  animate={{ opacity: 1, x: 0 }}
                  transition={{ delay: 0.2 + index * 0.1 }}
                  whileHover={{ scale: 1.02 }}
                  whileTap={{ scale: 0.98 }}
                >
                  <span className="text-base md:text-lg group-hover:text-amber-300 transition-colors">
                    {choice.text}
                  </span>
                </motion.button>
              ))}
            </div>

            {/* 진행 상황 표시 */}
            <div className="mt-6 text-center">
              <div className="inline-flex items-center gap-2 px-4 py-2 bg-black/50 rounded-full">
                <span className="text-amber-300 text-sm">
                  챕터 {chapter}
                </span>
                <span className="text-white/50">•</span>
                <span className="text-white/70 text-sm">
                  {currentSceneIndex + 1} / {scenes.length}
                </span>
              </div>
            </div>
          </motion.div>
        </AnimatePresence>
      </div>

      {/* 로딩 오버레이 (이미지 로딩 중) */}
      {!imageLoaded && (
        <div className="absolute inset-0 bg-gradient-to-br from-[#1a365d] via-[#2d3f6f] to-[#5a2d7c] flex items-center justify-center z-50">
          <motion.div
            animate={{ rotate: 360 }}
            transition={{ duration: 1, repeat: Infinity, ease: 'linear' }}
            className="w-12 h-12 border-4 border-amber-400/30 border-t-amber-400 rounded-full"
          />
        </div>
      )}
    </div>
  )
}
