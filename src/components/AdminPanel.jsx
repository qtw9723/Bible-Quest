import { useState, useEffect } from 'react'
import { ChevronLeft, LogOut } from 'lucide-react'
import AdminAuth from './admin/AdminAuth'
import StoryBuilder from './admin/StoryBuilder'
import ImageUploader from './admin/ImageUploader'
import Dashboard from './admin/Dashboard'
import TeamManager from './admin/TeamManager'
import { isAdminLoggedIn, refreshAdminSession, adminLogout } from '../lib/adminAuth'

export default function AdminPanel({ onBack }) {
  const [isAuthenticated, setIsAuthenticated] = useState(false)
  const [tab, setTab] = useState('dashboard')

  // 마운트 시 쿠키 확인 + 세션 갱신
  useEffect(() => {
    if (isAdminLoggedIn()) {
      refreshAdminSession() // 접속할 때마다 7일 연장
      setIsAuthenticated(true)
    }
  }, [])

  const handleLogout = () => {
    adminLogout()
    setIsAuthenticated(false)
  }

  if (!isAuthenticated) {
    return <AdminAuth onSuccess={() => setIsAuthenticated(true)} />
  }

  return (
    <div className="min-h-screen bg-gray-900 text-white">
      <div className="max-w-6xl mx-auto">
        {/* Header */}
        <div className="bg-gray-800 p-6 border-b border-gray-700">
          <div className="flex items-center justify-between">
            <h1 className="text-3xl font-bold">Bible Quest Admin</h1>
            <div className="flex items-center gap-2">
              <button onClick={handleLogout}
                className="flex items-center gap-2 px-4 py-2 bg-gray-700 hover:bg-red-900 hover:text-red-300 rounded-lg transition text-gray-400 text-sm">
                <LogOut size={16} />
                로그아웃
              </button>
              <button onClick={onBack}
                className="flex items-center gap-2 px-4 py-2 bg-gray-700 hover:bg-gray-600 rounded-lg transition">
                <ChevronLeft size={20} />
                돌아가기
              </button>
            </div>
          </div>
        </div>

        {/* Tabs */}
        <div className="flex gap-2 bg-gray-800 p-4 border-b border-gray-700 flex-wrap">
          {[
            { key: 'dashboard', label: '📊 대시보드' },
            { key: 'teams',     label: '👥 팀 관리' },
            { key: 'story',     label: '📖 스토리 관리' },
            { key: 'images',    label: '🖼️ 미디어 관리' },
          ].map(({ key, label }) => (
            <button key={key} onClick={() => setTab(key)}
              className={`px-5 py-2 rounded-lg font-semibold transition ${
                tab === key ? 'bg-blue-600 text-white' : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
              }`}>
              {label}
            </button>
          ))}
        </div>

        {/* Content */}
        <div className="p-6">
          {tab === 'dashboard' && <Dashboard />}
          {tab === 'teams'     && <TeamManager />}
          {tab === 'story'     && <StoryBuilder />}
          {tab === 'images'    && <ImageUploader />}
        </div>
      </div>
    </div>
  )
}
