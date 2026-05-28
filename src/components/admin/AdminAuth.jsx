import { useState } from 'react'
import { Lock } from 'lucide-react'

export default function AdminAuth({ onSuccess }) {
  const [password, setPassword] = useState('')
  const [error, setError] = useState('')

  const handleLogin = () => {
    const adminPassword = import.meta.env.VITE_ADMIN_PASSWORD || 'admin123'
    if (password === adminPassword) {
      onSuccess()
    } else {
      setError('비밀번호가 틀렸습니다.')
      setPassword('')
    }
  }

  const handleKeyPress = (e) => {
    if (e.key === 'Enter') handleLogin()
  }

  return (
    <div className="min-h-screen bg-gradient-to-b from-gray-900 to-gray-800 flex items-center justify-center">
      <div className="bg-gray-800 p-8 rounded-lg shadow-2xl w-full max-w-md border border-gray-700">
        <div className="flex justify-center mb-6">
          <Lock size={48} className="text-blue-400" />
        </div>
        <h1 className="text-2xl font-bold text-center mb-2 text-white">관리자 로그인</h1>
        <p className="text-gray-400 text-center mb-6">Bible Quest 어드민 패널</p>

        <div className="space-y-4">
          <input
            type="password"
            value={password}
            onChange={(e) => {
              setPassword(e.target.value)
              setError('')
            }}
            onKeyPress={handleKeyPress}
            placeholder="관리자 비밀번호"
            className="w-full px-4 py-2 bg-gray-700 border border-gray-600 rounded-lg text-white placeholder-gray-400 focus:outline-none focus:border-blue-500"
            autoFocus
          />

          {error && <p className="text-red-400 text-sm">{error}</p>}

          <button
            onClick={handleLogin}
            className="w-full px-4 py-2 bg-blue-600 hover:bg-blue-500 text-white font-semibold rounded-lg transition"
          >
            로그인
          </button>
        </div>

        <p className="text-gray-500 text-xs mt-6 text-center">
          환경변수: VITE_ADMIN_PASSWORD
        </p>
      </div>
    </div>
  )
}
