import { useState } from 'react'
import { Upload, X } from 'lucide-react'
import { uploadImage } from '../../lib/api'

export default function ImageUploader() {
  const [category, setCategory] = useState('backgrounds') // backgrounds, characters
  const [file, setFile] = useState(null)
  const [uploading, setUploading] = useState(false)
  const [error, setError] = useState('')
  const [success, setSuccess] = useState('')
  const [imageUrl, setImageUrl] = useState('')

  const handleFileSelect = (e) => {
    const selected = e.target.files?.[0]
    if (selected) {
      if (selected.size > 5 * 1024 * 1024) {
        setError('파일 크기는 5MB 이하여야 합니다.')
        return
      }
      setFile(selected)
      setError('')
    }
  }

  const handleUpload = async () => {
    if (!file) {
      setError('파일을 선택해주세요.')
      return
    }

    try {
      setUploading(true)
      setError('')
      setSuccess('')

      const fileName = `${Date.now()}-${file.name}`
      const path = `${category}/${fileName}`

      const url = await uploadImage('bible-quest', path, file)
      setImageUrl(url)
      setSuccess(`✓ 업로드 완료: ${fileName}`)
      setFile(null)
    } catch (e) {
      setError(`업로드 실패: ${e.message}`)
    } finally {
      setUploading(false)
    }
  }

  const copyToClipboard = (text) => {
    navigator.clipboard.writeText(text)
    setSuccess('✓ URL이 클립보드에 복사되었습니다.')
  }

  return (
    <div className="space-y-6 max-w-2xl">
      <div className="bg-gray-800 p-6 rounded-lg border border-gray-700">
        <h2 className="text-lg font-semibold mb-4 text-white">이미지 업로드</h2>

        <div className="space-y-4">
          {/* Category */}
          <div>
            <label className="block text-sm font-medium text-gray-300 mb-2">카테고리</label>
            <div className="flex gap-2">
              {['backgrounds', 'characters', 'ui'].map((cat) => (
                <button
                  key={cat}
                  onClick={() => setCategory(cat)}
                  className={`px-4 py-2 rounded-lg transition ${
                    category === cat
                      ? 'bg-blue-600 text-white'
                      : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
                  }`}
                >
                  {cat === 'backgrounds' && '🌅'}
                  {cat === 'characters' && '👤'}
                  {cat === 'ui' && '🎨'}
                  {' '}
                  {cat}
                </button>
              ))}
            </div>
          </div>

          {/* File Input */}
          <div>
            <label className="block text-sm font-medium text-gray-300 mb-2">파일 선택</label>
            <div className="border-2 border-dashed border-gray-600 rounded-lg p-6 text-center hover:border-gray-500 transition">
              <input
                type="file"
                accept="image/*"
                onChange={handleFileSelect}
                className="hidden"
                id="file-input"
              />
              <label htmlFor="file-input" className="cursor-pointer block">
                <Upload className="mx-auto mb-2 text-gray-400" size={32} />
                <p className="text-gray-400">
                  {file ? file.name : '클릭하여 파일 선택 또는 드래그'}
                </p>
                <p className="text-xs text-gray-500 mt-1">최대 5MB</p>
              </label>
            </div>
          </div>

          {/* Upload Button */}
          <button
            onClick={handleUpload}
            disabled={!file || uploading}
            className="w-full px-4 py-2 bg-green-600 hover:bg-green-500 disabled:bg-gray-600 text-white font-semibold rounded-lg transition"
          >
            {uploading ? '업로드 중...' : '업로드'}
          </button>

          {/* Messages */}
          {error && (
            <div className="bg-red-900 border border-red-700 text-red-200 p-3 rounded-lg flex items-center justify-between">
              <span>{error}</span>
              <button onClick={() => setError('')}>
                <X size={18} />
              </button>
            </div>
          )}

          {success && (
            <div className="bg-green-900 border border-green-700 text-green-200 p-3 rounded-lg flex items-center justify-between">
              <span>{success}</span>
              <button onClick={() => setSuccess('')}>
                <X size={18} />
              </button>
            </div>
          )}

          {/* Image URL */}
          {imageUrl && (
            <div className="bg-gray-900 p-4 rounded-lg border border-gray-700">
              <p className="text-xs text-gray-400 mb-2">생성된 URL:</p>
              <div className="flex items-center gap-2">
                <input
                  type="text"
                  value={imageUrl}
                  readOnly
                  className="flex-1 px-3 py-2 bg-gray-800 border border-gray-600 rounded text-sm text-gray-300 font-mono truncate"
                />
                <button
                  onClick={() => copyToClipboard(imageUrl)}
                  className="px-3 py-2 bg-blue-600 hover:bg-blue-500 text-white rounded transition"
                >
                  복사
                </button>
              </div>
              <img src={imageUrl} alt="preview" className="mt-4 max-w-full max-h-64 rounded-lg" />
            </div>
          )}
        </div>
      </div>

      {/* Instructions */}
      <div className="bg-blue-900 border border-blue-700 text-blue-200 p-4 rounded-lg text-sm">
        <p className="font-semibold mb-2">📋 사용 방법:</p>
        <ul className="list-disc list-inside space-y-1">
          <li>카테고리를 선택하고 이미지 파일을 업로드합니다.</li>
          <li>업로드 완료 후 생성된 URL을 복사합니다.</li>
          <li>스토리 관리에서 scene이나 chapter에 이미지 URL을 붙여넣습니다.</li>
        </ul>
      </div>
    </div>
  )
}
