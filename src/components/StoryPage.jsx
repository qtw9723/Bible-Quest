import { useState, useEffect } from 'react'
import { ChevronDown } from 'lucide-react'

// 임시 스토리 데이터 (실제로는 Supabase에서 로드)
const STORY_DATA = {
  1: {
    chapter: 1,
    title: '갈릴리의 부름',
    scenes: [
      {
        background: 'bg-blue-900',
        character: 'Peter',
        text: '예수께서 갈릴리 해변을 지나가시다가...',
        choices: null,
      },
      {
        background: 'bg-blue-900',
        character: 'Jesus',
        text: '나를 따라오라. 내가 너희를 사람을 낚는 어부가 되게 하리라.',
        choices: [
          { label: '그물을 내려놓고 따라간다', next: 2 },
          { label: '망설이며 서 있는다', next: 3 },
        ],
      },
      {
        background: 'bg-blue-500',
        character: 'Peter',
        text: '그 순간, 베드로는 모든 것을 내려놓고 예수를 따라갔다.',
        choices: null,
      },
      {
        background: 'bg-amber-900',
        character: 'Peter',
        text: '하지만 베드로는 다시 생각했다. 과연 이 자를 따를 수 있을까?',
        choices: null,
      },
    ],
  },
}

export default function StoryPage({ chapter, onComplete, onScene }) {
  const [currentScene, setCurrentScene] = useState(0)
  const [isAutoNext, setIsAutoNext] = useState(true)

  const storyData = STORY_DATA[chapter]
  const scene = storyData?.scenes[currentScene]

  const handleChoice = (nextScene) => {
    if (nextScene < storyData.scenes.length) {
      setCurrentScene(nextScene)
      onScene(nextScene)
    } else {
      onComplete()
    }
  }

  const handleNext = () => {
    if (currentScene < storyData.scenes.length - 1) {
      setCurrentScene(currentScene + 1)
      onScene(currentScene + 1)
    } else {
      onComplete()
    }
  }

  if (!scene) return <div>Loading...</div>

  return (
    <div className={`w-full h-screen ${scene.background} flex flex-col text-white transition-colors duration-500`}>
      {/* 배경 + 캐릭터 영역 */}
      <div className="flex-1 flex flex-col items-center justify-center">
        <div className="text-6xl opacity-30">[{scene.character}]</div>
      </div>

      {/* 텍스트 박스 */}
      <div className="bg-black bg-opacity-70 p-8 min-h-64 flex flex-col justify-between">
        <div>
          <h2 className="text-2xl font-bold mb-4 text-yellow-300">{storyData.title}</h2>
          <p className="text-xl leading-relaxed">{scene.text}</p>
        </div>

        {/* 선택지 또는 다음 버튼 */}
        <div className="mt-8 space-y-3">
          {scene.choices ? (
            scene.choices.map((choice, idx) => (
              <button
                key={idx}
                onClick={() => handleChoice(choice.next)}
                className="w-full p-3 bg-blue-600 hover:bg-blue-500 rounded-lg text-left transition"
              >
                ▶ {choice.label}
              </button>
            ))
          ) : (
            <button
              onClick={handleNext}
              className="w-full p-3 bg-blue-600 hover:bg-blue-500 rounded-lg flex items-center justify-between transition"
            >
              <span>다음</span>
              <ChevronDown size={20} />
            </button>
          )}
        </div>

        {/* 진행 표시 */}
        <div className="mt-4 flex items-center justify-between text-sm text-gray-400">
          <span>Scene {currentScene + 1} / {storyData.scenes.length}</span>
          <div className="flex gap-2">
            {storyData.scenes.map((_, idx) => (
              <div
                key={idx}
                className={`w-2 h-2 rounded-full ${idx <= currentScene ? 'bg-yellow-300' : 'bg-gray-600'}`}
              />
            ))}
          </div>
        </div>
      </div>
    </div>
  )
}
