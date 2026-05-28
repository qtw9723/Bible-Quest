import { CheckCircle } from 'lucide-react'

const CHAPTER_VERSES = {
  1: { ref: '마태복음 4:18-20', text: '"예수께서 갈릴리 해변을 지나가시다가 두 형제 시몬 베드로와 그 형제 안드레가 바다에 그물을 던지는 것을 보시고 이르시되 나를 따라오라 내가 너희로 사람을 낚는 어부가 되게 하리라 하시니 그들이 곧 그물을 버려두고 따라가시니라"' },
  2: { ref: '마태복음 10:1-4', text: '"예수께서 그의 열두 제자를 부르사 그들에게 권능을 주사 더러운 귀신을 내쫓고 모든 병과 모든 약한 것을 고치게 하시니라"' },
}

export default function ChapterComplete({ chapter, onContinueNext, onBackToSelect }) {
  const verse = CHAPTER_VERSES[chapter] || { ref: '', text: '' }
  const hasNextChapter = chapter < 12

  return (
    <div className="w-full min-h-screen bg-gradient-to-b from-green-900 to-green-800 flex flex-col items-center justify-center text-white p-8">
      <div className="text-center max-w-2xl">
        <CheckCircle size={80} className="mx-auto mb-8 text-green-300" />
        <h1 className="text-5xl font-bold mb-4">챕터 완료!</h1>
        <p className="text-2xl mb-12 text-green-200">Chapter {chapter}: {['갈릴리의 부름', '제자 선택'][chapter - 1]} 완료</p>

        {/* 성경 구절 */}
        <div className="bg-black bg-opacity-40 p-8 rounded-lg mb-8">
          <p className="text-sm text-yellow-300 mb-4">{verse.ref}</p>
          <p className="text-lg leading-relaxed text-gray-200">"{verse.text}"</p>
        </div>

        {/* 버튼 */}
        <div className="space-y-4">
          {hasNextChapter ? (
            <button
              onClick={onContinueNext}
              className="w-full px-8 py-3 bg-yellow-500 hover:bg-yellow-600 text-black font-bold rounded-lg text-xl transition"
            >
              다음 챕터로
            </button>
          ) : (
            <div className="p-4 bg-yellow-500 text-black font-bold rounded-lg">
              축하합니다! 모든 챕터를 완료했습니다!
            </div>
          )}
          <button
            onClick={onBackToSelect}
            className="w-full px-8 py-3 bg-blue-500 hover:bg-blue-600 text-white font-bold rounded-lg text-xl transition"
          >
            챕터 목록으로
          </button>
        </div>
      </div>
    </div>
  )
}
