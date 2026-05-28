import { ChevronRight, Lock, CheckCircle } from 'lucide-react'

const CHAPTERS = [
  { num: 1, title: '갈릴리의 부름' },
  { num: 2, title: '제자 선택' },
  { num: 3, title: '산 위의 설교' },
  { num: 4, title: '폭풍 위의 승리' },
  { num: 5, title: '귀신 들린 자의 치유' },
  { num: 6, title: '오병이어' },
  { num: 7, title: '물 위를 걷다' },
  { num: 8, title: '가나안 여인' },
  { num: 9, title: '변화산 위의 영광' },
  { num: 10, title: '좋은 사마리아인' },
  { num: 11, title: '나사로의 부활' },
  { num: 12, title: '십자가와 부활' },
]

export default function ChapterSelect({ nickname, completedChapters, onSelectChapter }) {
  return (
    <div className="min-h-screen bg-gradient-to-b from-slate-900 to-slate-800 text-white p-8">
      <div className="max-w-4xl mx-auto">
        <h1 className="text-4xl font-bold mb-2">Bible Quest</h1>
        <p className="text-xl text-blue-300 mb-8">{nickname}님의 여정</p>

        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          {CHAPTERS.map((ch) => {
            const isCompleted = completedChapters.includes(ch.num)
            const isLocked = !isCompleted && ch.num > 1
            const isPrevCompleted = ch.num === 1 || completedChapters.includes(ch.num - 1)
            const isPlayable = !isLocked || isPrevCompleted

            return (
              <button
                key={ch.num}
                onClick={() => isPlayable && onSelectChapter(ch.num)}
                disabled={!isPlayable && !isCompleted}
                className={`p-6 rounded-lg transition ${
                  isCompleted
                    ? 'bg-green-700 hover:bg-green-600'
                    : isPlayable
                    ? 'bg-blue-700 hover:bg-blue-600'
                    : 'bg-gray-700 cursor-not-allowed opacity-50'
                }`}
              >
                <div className="flex items-center justify-between">
                  <div className="text-left">
                    <p className="text-sm text-gray-300">Chapter {ch.num}</p>
                    <p className="text-lg font-semibold">{ch.title}</p>
                  </div>
                  <div>
                    {isCompleted && <CheckCircle size={24} className="text-white" />}
                    {!isPlayable && <Lock size={24} />}
                    {isPlayable && !isCompleted && <ChevronRight size={24} />}
                  </div>
                </div>
              </button>
            )
          })}
        </div>
      </div>
    </div>
  )
}
