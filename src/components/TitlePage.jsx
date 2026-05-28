import { useState } from 'react'

export default function TitlePage({ onStart, onContinue, canContinue }) {
  const [nickname, setNickname] = useState('')
  const [showInput, setShowInput] = useState(false)

  const handleStart = () => {
    if (nickname.trim()) {
      onStart(nickname)
    }
  }

  return (
    <div className="w-full h-screen bg-gradient-to-b from-blue-900 to-purple-900 flex flex-col items-center justify-center text-white">
      <div className="text-center">
        <h1 className="text-6xl font-bold mb-2">Bible Quest</h1>
        <p className="text-2xl mb-12 text-blue-200">신앙 성장 RPG</p>

        {!showInput ? (
          <div className="space-y-4">
            <button
              onClick={() => setShowInput(true)}
              className="px-8 py-3 bg-yellow-500 hover:bg-yellow-600 text-black font-bold rounded-lg text-xl transition"
            >
              게임 시작
            </button>
            {canContinue && (
              <button
                onClick={onContinue}
                className="px-8 py-3 bg-green-500 hover:bg-green-600 text-black font-bold rounded-lg text-xl transition block mx-auto"
              >
                이어하기
              </button>
            )}
          </div>
        ) : (
          <div className="space-y-4">
            <input
              type="text"
              value={nickname}
              onChange={(e) => setNickname(e.target.value)}
              onKeyPress={(e) => e.key === 'Enter' && handleStart()}
              placeholder="닉네임을 입력하세요"
              className="px-4 py-2 rounded-lg text-black text-lg w-64"
              autoFocus
            />
            <div className="space-x-4">
              <button
                onClick={handleStart}
                className="px-6 py-2 bg-yellow-500 hover:bg-yellow-600 text-black font-bold rounded-lg"
              >
                시작
              </button>
              <button
                onClick={() => setShowInput(false)}
                className="px-6 py-2 bg-gray-500 hover:bg-gray-600 text-white font-bold rounded-lg"
              >
                취소
              </button>
            </div>
          </div>
        )}
      </div>
    </div>
  )
}
