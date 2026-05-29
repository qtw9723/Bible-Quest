import { useState, useEffect } from 'react'
import { Upload, X, Pencil, Check, Trash2, Copy } from 'lucide-react'
import { uploadImage, saveImageAsset, getImageAssets, updateImageAsset, deleteImageAsset, deleteImage } from '../../lib/api'

const CATEGORIES = [
  { value: 'backgrounds', label: '🌅 배경' },
  { value: 'characters', label: '👤 캐릭터' },
  { value: 'ui', label: '🎨 UI' },
]

export default function ImageUploader() {
  const [category, setCategory] = useState('backgrounds')
  const [file, setFile] = useState(null)
  const [uploading, setUploading] = useState(false)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState('')

  // 이미지 리스트
  const [assets, setAssets] = useState([])
  const [loadingAssets, setLoadingAssets] = useState(false)
  const [editingId, setEditingId] = useState(null)
  const [editingName, setEditingName] = useState('')
  const [filterCategory, setFilterCategory] = useState('all')

  useEffect(() => { loadAssets() }, [])

  const loadAssets = async () => {
    try {
      setLoadingAssets(true)
      const data = await getImageAssets()
      setAssets(data || [])
    } catch (e) {
      setError(e.message)
    } finally {
      setLoadingAssets(false)
    }
  }

  const handleFileSelect = (e) => {
    const selected = e.target.files?.[0]
    if (!selected) return
    if (selected.size > 5 * 1024 * 1024) {
      setError('파일 크기는 5MB 이하여야 합니다.')
      return
    }
    setFile(selected)
    setError('')
  }

  const handleUpload = async () => {
    if (!file) { setError('파일을 선택해주세요.'); return }

    try {
      setUploading(true)
      setError('')
      setSuccess('')

      const ext = file.name.split('.').pop().toLowerCase()
      const safeName = file.name
        .replace(/\.[^.]+$/, '')
        .replace(/[^\w\s-]/g, '')
        .replace(/\s+/g, '_')
        .replace(/[^\x00-\x7F]/g, '')
        .replace(/_{2,}/g, '_')
        .replace(/^_|_$/g, '')
        || 'image'
      const fileName = `${Date.now()}-${safeName}.${ext}`
      const filePath = `${category}/${fileName}`

      const publicUrl = await uploadImage('bible-quest', filePath, file)

      // 초기 이름은 파일명에서 자동 생성
      const displayName = file.name.replace(/\.[^.]+$/, '') || safeName

      await saveImageAsset({ name: displayName, category, file_path: filePath, public_url: publicUrl })

      setSuccess(`✓ 업로드 완료: ${displayName}`)
      setFile(null)
      // 파일 input 초기화
      const input = document.getElementById('file-input')
      if (input) input.value = ''
      loadAssets()
    } catch (e) {
      setError(`업로드 실패: ${e.message}`)
    } finally {
      setUploading(false)
    }
  }

  const handleStartEdit = (asset) => {
    setEditingId(asset.id)
    setEditingName(asset.name)
  }

  const handleSaveEdit = async (id) => {
    try {
      await updateImageAsset(id, { name: editingName })
      setAssets(prev => prev.map(a => a.id === id ? { ...a, name: editingName } : a))
      setEditingId(null)
    } catch (e) {
      setError(e.message)
    }
  }

  const handleDelete = async (asset) => {
    if (!window.confirm(`"${asset.name}" 이미지를 삭제하시겠습니까?`)) return
    try {
      await deleteImage('bible-quest', asset.file_path)
      await deleteImageAsset(asset.id)
      setAssets(prev => prev.filter(a => a.id !== asset.id))
      setSuccess('✓ 삭제 완료')
    } catch (e) {
      setError(e.message)
    }
  }

  const copyUrl = (url) => {
    navigator.clipboard.writeText(url)
    setSuccess('✓ URL 복사됨')
    setTimeout(() => setSuccess(''), 2000)
  }

  const filteredAssets = filterCategory === 'all'
    ? assets
    : assets.filter(a => a.category === filterCategory)

  return (
    <div className="space-y-6 max-w-4xl">
      {/* ── 업로드 영역 ── */}
      <div className="bg-gray-800 p-6 rounded-xl border border-gray-700">
        <h2 className="text-lg font-semibold mb-4 text-white">이미지 업로드</h2>
        <div className="space-y-4">
          {/* 카테고리 */}
          <div>
            <label className="block text-sm text-gray-400 mb-2">카테고리</label>
            <div className="flex gap-2">
              {CATEGORIES.map(({ value, label }) => (
                <button
                  key={value}
                  onClick={() => setCategory(value)}
                  className={`px-4 py-2 rounded-lg text-sm transition ${
                    category === value ? 'bg-blue-600 text-white' : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
                  }`}
                >
                  {label}
                </button>
              ))}
            </div>
          </div>

          {/* 파일 선택 */}
          <div>
            <label className="block text-sm text-gray-400 mb-2">파일 선택</label>
            <div className="border-2 border-dashed border-gray-600 rounded-xl p-6 text-center hover:border-gray-500 transition">
              <input type="file" accept="image/*" onChange={handleFileSelect} className="hidden" id="file-input" />
              <label htmlFor="file-input" className="cursor-pointer block">
                <Upload className="mx-auto mb-2 text-gray-400" size={32} />
                <p className="text-gray-400 text-sm">{file ? file.name : '클릭하여 파일 선택 (최대 5MB)'}</p>
              </label>
            </div>
          </div>

          <button
            onClick={handleUpload}
            disabled={!file || uploading}
            className="w-full py-2 bg-green-600 hover:bg-green-500 disabled:bg-gray-600 text-white font-semibold rounded-lg transition"
          >
            {uploading ? '업로드 중...' : '업로드'}
          </button>

          {error && (
            <div className="bg-red-900 border border-red-700 text-red-200 p-3 rounded-lg flex items-center justify-between text-sm">
              <span>{error}</span>
              <button onClick={() => setError('')}><X size={16} /></button>
            </div>
          )}
          {success && (
            <div className="bg-green-900 border border-green-700 text-green-200 p-3 rounded-lg flex items-center justify-between text-sm">
              <span>{success}</span>
              <button onClick={() => setSuccess('')}><X size={16} /></button>
            </div>
          )}
        </div>
      </div>

      {/* ── 이미지 리스트 ── */}
      <div className="bg-gray-800 rounded-xl border border-gray-700">
        <div className="p-4 border-b border-gray-700 flex items-center justify-between">
          <h2 className="text-lg font-semibold text-white">
            이미지 목록 <span className="text-gray-400 text-sm font-normal">({filteredAssets.length}개)</span>
          </h2>
          {/* 필터 */}
          <div className="flex gap-2">
            <button
              onClick={() => setFilterCategory('all')}
              className={`px-3 py-1 rounded-lg text-xs transition ${filterCategory === 'all' ? 'bg-blue-600 text-white' : 'bg-gray-700 text-gray-300 hover:bg-gray-600'}`}
            >전체</button>
            {CATEGORIES.map(({ value, label }) => (
              <button
                key={value}
                onClick={() => setFilterCategory(value)}
                className={`px-3 py-1 rounded-lg text-xs transition ${filterCategory === value ? 'bg-blue-600 text-white' : 'bg-gray-700 text-gray-300 hover:bg-gray-600'}`}
              >
                {label}
              </button>
            ))}
          </div>
        </div>

        {loadingAssets ? (
          <p className="text-gray-400 text-sm p-6">로딩 중...</p>
        ) : filteredAssets.length === 0 ? (
          <p className="text-gray-500 text-sm p-6 text-center">업로드된 이미지가 없습니다</p>
        ) : (
          <div className="divide-y divide-gray-700">
            {filteredAssets.map((asset) => (
              <div key={asset.id} className="flex items-center gap-4 p-4 hover:bg-gray-750 transition">
                {/* 썸네일 */}
                <img
                  src={asset.public_url}
                  alt={asset.name}
                  className="w-16 h-16 object-cover rounded-lg bg-gray-700 shrink-0"
                  onError={(e) => { e.target.src = ''; e.target.className = 'w-16 h-16 rounded-lg bg-gray-700 shrink-0' }}
                />

                {/* 이름 + 카테고리 */}
                <div className="flex-1 min-w-0">
                  {editingId === asset.id ? (
                    <div className="flex items-center gap-2">
                      <input
                        autoFocus
                        value={editingName}
                        onChange={(e) => setEditingName(e.target.value)}
                        onKeyDown={(e) => { if (e.key === 'Enter') handleSaveEdit(asset.id); if (e.key === 'Escape') setEditingId(null) }}
                        className="flex-1 bg-gray-700 text-white rounded px-2 py-1 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
                      />
                      <button onClick={() => handleSaveEdit(asset.id)} className="p-1 hover:bg-green-900 rounded">
                        <Check size={16} className="text-green-400" />
                      </button>
                      <button onClick={() => setEditingId(null)} className="p-1 hover:bg-gray-700 rounded">
                        <X size={16} className="text-gray-400" />
                      </button>
                    </div>
                  ) : (
                    <p className="text-white text-sm font-medium truncate">{asset.name}</p>
                  )}
                  <p className="text-xs text-gray-500 mt-0.5">
                    {CATEGORIES.find(c => c.value === asset.category)?.label} · {new Date(asset.created_at).toLocaleDateString('ko-KR')}
                  </p>
                </div>

                {/* 액션 버튼 */}
                <div className="flex items-center gap-1 shrink-0">
                  <button
                    onClick={() => copyUrl(asset.public_url)}
                    className="p-2 hover:bg-gray-700 rounded-lg transition"
                    title="URL 복사"
                  >
                    <Copy size={15} className="text-gray-400" />
                  </button>
                  <button
                    onClick={() => handleStartEdit(asset)}
                    className="p-2 hover:bg-blue-900 rounded-lg transition"
                    title="이름 수정"
                  >
                    <Pencil size={15} className="text-blue-400" />
                  </button>
                  <button
                    onClick={() => handleDelete(asset)}
                    className="p-2 hover:bg-red-900 rounded-lg transition"
                    title="삭제"
                  >
                    <Trash2 size={15} className="text-red-500" />
                  </button>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  )
}
