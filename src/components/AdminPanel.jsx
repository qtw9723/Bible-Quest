import { useState } from 'react'
import { ChevronLeft } from 'lucide-react'
import AdminAuth from './admin/AdminAuth'
import StoryBuilder from './admin/StoryBuilder'
import ImageUploader from './admin/ImageUploader'

export default function AdminPanel({ onBack }) {
  const [isAuthenticated, setIsAuthenticated] = useState(false)
  const [tab, setTab] = useState('story') // story, images

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
            <button
              onClick={onBack}
              className="flex items-center gap-2 px-4 py-2 bg-gray-700 hover:bg-gray-600 rounded-lg transition"
            >
              <ChevronLeft size={20} />
              돌아가기
            </button>
          </div>
        </div>

        {/* Tabs */}
        <div className="flex gap-4 bg-gray-800 p-4 border-b border-gray-700">
          <button
            onClick={() => setTab('story')}
            className={`px-6 py-2 rounded-lg font-semibold transition ${
              tab === 'story'
                ? 'bg-blue-600 text-white'
                : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
            }`}
          >
            📖 스토리 관리
          </button>
          <button
            onClick={() => setTab('images')}
            className={`px-6 py-2 rounded-lg font-semibold transition ${
              tab === 'images'
                ? 'bg-blue-600 text-white'
                : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
            }`}
          >
            🖼️ 이미지 관리
          </button>
        </div>

        {/* Content */}
        <div className="p-6">
          {tab === 'story' && <StoryBuilder />}
          {tab === 'images' && <ImageUploader />}
        </div>
      </div>
    </div>
  )
}
