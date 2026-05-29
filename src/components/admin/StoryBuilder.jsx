import { useState, useEffect } from 'react'
import { Plus, Trash2, Edit2, ChevronDown, ChevronUp, X } from 'lucide-react'
import {
  getChapters, createChapter, deleteChapter,
  getScenes, createScene, updateScene, deleteScene,
  getChoices, createChoice, deleteChoice,
  getImageAssets,
} from '../../lib/api'

/* ───────── 공용 모달 래퍼 ───────── */
function Modal({ title, onClose, children }) {
  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/60 backdrop-blur-sm p-4">
      <div className="bg-gray-800 border border-gray-600 rounded-2xl w-full max-w-lg shadow-2xl">
        {/* 헤더 */}
        <div className="flex items-center justify-between px-6 py-4 border-b border-gray-700">
          <h2 className="text-lg font-bold text-white">{title}</h2>
          <button onClick={onClose} className="p-1 hover:bg-gray-700 rounded-lg transition">
            <X size={20} className="text-gray-400" />
          </button>
        </div>
        {/* 본문 */}
        <div className="px-6 py-5">{children}</div>
      </div>
    </div>
  )
}

/* ───────── 확인 모달 ───────── */
function ConfirmModal({ message, onConfirm, onClose }) {
  return (
    <Modal title="확인" onClose={onClose}>
      <p className="text-gray-300 mb-6">{message}</p>
      <div className="flex justify-end gap-3">
        <button
          onClick={onClose}
          className="px-4 py-2 bg-gray-700 hover:bg-gray-600 text-white rounded-lg transition"
        >
          취소
        </button>
        <button
          onClick={() => { onConfirm(); onClose() }}
          className="px-4 py-2 bg-red-600 hover:bg-red-500 text-white rounded-lg transition"
        >
          삭제
        </button>
      </div>
    </Modal>
  )
}

/* ───────── 챕터 추가 모달 ───────── */
function AddChapterModal({ nextNum, onSubmit, onClose }) {
  const [title, setTitle] = useState('')
  const [description, setDescription] = useState('')

  const handleSubmit = (e) => {
    e.preventDefault()
    if (!title.trim()) return
    onSubmit({ title: title.trim(), description: description.trim() })
    onClose()
  }

  return (
    <Modal title={`Chapter ${nextNum} 추가`} onClose={onClose}>
      <form onSubmit={handleSubmit} className="space-y-4">
        <div>
          <label className="block text-sm text-gray-400 mb-1">챕터 번호</label>
          <input
            value={nextNum}
            disabled
            className="w-full bg-gray-700 text-gray-400 rounded-lg px-3 py-2 text-sm cursor-not-allowed"
          />
        </div>
        <div>
          <label className="block text-sm text-gray-400 mb-1">제목 *</label>
          <input
            autoFocus
            value={title}
            onChange={(e) => setTitle(e.target.value)}
            placeholder="예) 갈릴리의 부름"
            className="w-full bg-gray-700 text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </div>
        <div>
          <label className="block text-sm text-gray-400 mb-1">설명 (선택)</label>
          <input
            value={description}
            onChange={(e) => setDescription(e.target.value)}
            placeholder="챕터 소개 한 줄"
            className="w-full bg-gray-700 text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
          />
        </div>
        <div className="flex justify-end gap-3 pt-2">
          <button type="button" onClick={onClose} className="px-4 py-2 bg-gray-700 hover:bg-gray-600 text-white rounded-lg transition">취소</button>
          <button type="submit" disabled={!title.trim()} className="px-4 py-2 bg-green-600 hover:bg-green-500 disabled:opacity-40 text-white rounded-lg transition">추가</button>
        </div>
      </form>
    </Modal>
  )
}

/* ───────── 미디어 드롭다운 ───────── */
function MediaSelect({ label, value, onChange, assets, category, preview = 'image' }) {
  const filtered = assets.filter(a => a.category === category)
  return (
    <div>
      <label className="block text-sm text-gray-400 mb-1">{label}</label>
      <select
        value={value}
        onChange={(e) => onChange(e.target.value)}
        className="w-full bg-gray-700 text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
      >
        <option value="">선택 안 함</option>
        {filtered.map(a => (
          <option key={a.id} value={a.public_url}>{a.name}</option>
        ))}
      </select>
      {value && preview === 'image' && (
        <img src={value} alt="preview" className="mt-2 h-20 w-full object-cover rounded-lg opacity-80" />
      )}
      {value && preview === 'audio' && (
        <audio controls src={value} className="mt-2 w-full h-8" />
      )}
    </div>
  )
}

/* ───────── 장면 추가/수정 모달 ───────── */
function SceneModal({ scene, sceneOrder, onSubmit, onClose }) {
  const isEdit = !!scene
  const [text, setText] = useState(scene?.text || '')
  const [background, setBackground] = useState(scene?.background || '')
  const [character, setCharacter] = useState(scene?.character || '')
  const [bgmUrl, setBgmUrl] = useState(scene?.bgm_url || '')
  const [bgmTransition, setBgmTransition] = useState(scene?.bgm_transition || 'fade')
  const [assets, setAssets] = useState([])

  useEffect(() => {
    getImageAssets().then(setAssets).catch(() => {})
  }, [])

  const handleSubmit = (e) => {
    e.preventDefault()
    if (!text.trim()) return
    onSubmit({ text: text.trim(), background, character, bgm_url: bgmUrl, bgm_transition: bgmTransition })
    onClose()
  }

  return (
    <Modal title={isEdit ? '장면 수정' : `Scene ${sceneOrder} 추가`} onClose={onClose}>
      <form onSubmit={handleSubmit} className="space-y-4 max-h-[75vh] overflow-y-auto pr-1">
        <div>
          <label className="block text-sm text-gray-400 mb-1">장면 텍스트 *</label>
          <textarea
            autoFocus
            value={text}
            onChange={(e) => setText(e.target.value)}
            rows={5}
            placeholder="장면에 표시될 내레이션 또는 대사를 입력하세요"
            className="w-full bg-gray-700 text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500 resize-none"
          />
        </div>
        <MediaSelect label="🌅 배경 이미지" value={background} onChange={setBackground} assets={assets} category="backgrounds" preview="image" />
        <MediaSelect label="👤 캐릭터 이미지" value={character} onChange={setCharacter} assets={assets} category="characters" preview="image" />

        {/* BGM */}
        <div className="border-t border-gray-700 pt-4 space-y-3">
          <MediaSelect label="🎵 BGM" value={bgmUrl} onChange={setBgmUrl} assets={assets} category="bgm" preview="audio" />
          {bgmUrl && (
            <div>
              <label className="block text-sm text-gray-400 mb-2">전환 방식</label>
              <div className="flex gap-2">
                {[
                  { value: 'fade', label: '🌊 페이드 인/아웃', desc: '이전 BGM이 서서히 사라지고 새 BGM이 서서히 등장' },
                  { value: 'cut',  label: '✂️ 컷', desc: '즉시 전환' },
                ].map(opt => (
                  <button
                    key={opt.value}
                    type="button"
                    onClick={() => setBgmTransition(opt.value)}
                    title={opt.desc}
                    className={`flex-1 py-2 px-3 rounded-lg text-sm transition ${
                      bgmTransition === opt.value
                        ? 'bg-blue-600 text-white'
                        : 'bg-gray-700 text-gray-300 hover:bg-gray-600'
                    }`}
                  >
                    {opt.label}
                  </button>
                ))}
              </div>
            </div>
          )}
        </div>

        <div className="flex justify-end gap-3 pt-2">
          <button type="button" onClick={onClose} className="px-4 py-2 bg-gray-700 hover:bg-gray-600 text-white rounded-lg transition">취소</button>
          <button type="submit" disabled={!text.trim()} className="px-4 py-2 bg-blue-600 hover:bg-blue-500 disabled:opacity-40 text-white rounded-lg transition">
            {isEdit ? '저장' : '추가'}
          </button>
        </div>
      </form>
    </Modal>
  )
}

/* ───────── 선택지 추가 모달 ───────── */
function AddChoiceModal({ allScenes, onSubmit, onClose }) {
  const [label, setLabel] = useState('')
  const [nextSceneId, setNextSceneId] = useState('')

  const handleSubmit = (e) => {
    e.preventDefault()
    if (!label.trim()) return
    onSubmit({ label: label.trim(), next_scene_id: nextSceneId || null })
    onClose()
  }

  return (
    <Modal title="선택지 추가" onClose={onClose}>
      <form onSubmit={handleSubmit} className="space-y-4">
        <div>
          <label className="block text-sm text-gray-400 mb-1">선택지 텍스트 *</label>
          <input
            autoFocus
            value={label}
            onChange={(e) => setLabel(e.target.value)}
            placeholder="예) 예수님을 따라간다"
            className="w-full bg-gray-700 text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-purple-500"
          />
        </div>
        <div>
          <label className="block text-sm text-gray-400 mb-1">다음 장면 (선택 — 없으면 챕터 완료)</label>
          <select
            value={nextSceneId}
            onChange={(e) => setNextSceneId(e.target.value)}
            className="w-full bg-gray-700 text-white rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-purple-500"
          >
            <option value="">챕터 완료</option>
            {allScenes.map((s) => (
              <option key={s.id} value={s.id}>
                Scene {s.scene_order}: {s.text?.substring(0, 40)}…
              </option>
            ))}
          </select>
        </div>
        <div className="flex justify-end gap-3 pt-2">
          <button type="button" onClick={onClose} className="px-4 py-2 bg-gray-700 hover:bg-gray-600 text-white rounded-lg transition">취소</button>
          <button type="submit" disabled={!label.trim()} className="px-4 py-2 bg-purple-600 hover:bg-purple-500 disabled:opacity-40 text-white rounded-lg transition">추가</button>
        </div>
      </form>
    </Modal>
  )
}

/* ───────── 메인 StoryBuilder ───────── */
export default function StoryBuilder() {
  const [chapters, setChapters] = useState([])
  const [expandedChapter, setExpandedChapter] = useState(null)
  const [expandedScene, setExpandedScene] = useState(null)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')

  // 모달 상태
  const [modal, setModal] = useState(null)
  // modal = { type: 'addChapter' | 'addScene' | 'editScene' | 'addChoice' | 'confirm', ...payload }

  const closeModal = () => setModal(null)

  useEffect(() => { loadChapters() }, [])

  const loadChapters = async () => {
    try {
      setLoading(true)
      const data = await getChapters()
      const chaptersWithScenes = await Promise.all(
        data.map(async (chapter) => {
          const scenes = await getScenes(chapter.id)
          const scenesWithChoices = await Promise.all(
            scenes.map(async (scene) => ({
              ...scene,
              choices: await getChoices(scene.id),
            }))
          )
          return { ...chapter, scenes: scenesWithChoices }
        })
      )
      setChapters(chaptersWithScenes)
    } catch (e) {
      setError(e.message)
    } finally {
      setLoading(false)
    }
  }

  /* ── 챕터 ── */
  const handleAddChapter = async ({ title, description }) => {
    const chapterNum = chapters.length + 1
    try {
      await createChapter({ chapter_num: chapterNum, title, description })
      loadChapters()
    } catch (e) { setError(e.message) }
  }

  const handleDeleteChapter = async (id) => {
    try {
      await deleteChapter(id)
      loadChapters()
    } catch (e) { setError(e.message) }
  }

  /* ── 장면 ── */
  const handleAddScene = async (chapterId, { text, background, character, bgm_url, bgm_transition }) => {
    const chapter = chapters.find(ch => ch.id === chapterId)
    const sceneOrder = (chapter.scenes?.length || 0) + 1
    try {
      await createScene({ chapter_id: chapterId, scene_order: sceneOrder, text, background, character, bgm_url, bgm_transition })
      setExpandedChapter(chapterId)
      loadChapters()
    } catch (e) { setError(e.message) }
  }

  const handleEditScene = async (sceneId, { text, background, character, bgm_url, bgm_transition }) => {
    try {
      await updateScene(sceneId, { text, background, character, bgm_url, bgm_transition })
      loadChapters()
    } catch (e) { setError(e.message) }
  }

  const handleDeleteScene = async (sceneId) => {
    try {
      await deleteScene(sceneId)
      loadChapters()
    } catch (e) { setError(e.message) }
  }

  /* ── 선택지 ── */
  const handleAddChoice = async (sceneId, { label, next_scene_id }) => {
    try {
      const choices = await getChoices(sceneId)
      await createChoice({ scene_id: sceneId, choice_order: choices.length + 1, label, next_scene_id })
      setExpandedScene(sceneId)
      loadChapters()
    } catch (e) { setError(e.message) }
  }

  const handleDeleteChoice = async (choiceId) => {
    try {
      await deleteChoice(choiceId)
      loadChapters()
    } catch (e) { setError(e.message) }
  }

  return (
    <div className="space-y-6">
      {/* ── 모달 렌더링 ── */}
      {modal?.type === 'addChapter' && (
        <AddChapterModal
          nextNum={chapters.length + 1}
          onSubmit={handleAddChapter}
          onClose={closeModal}
        />
      )}
      {modal?.type === 'addScene' && (
        <SceneModal
          sceneOrder={(chapters.find(c => c.id === modal.chapterId)?.scenes?.length || 0) + 1}
          onSubmit={(data) => handleAddScene(modal.chapterId, data)}
          onClose={closeModal}
        />
      )}
      {modal?.type === 'editScene' && (
        <SceneModal
          scene={modal.scene}
          onSubmit={(data) => handleEditScene(modal.scene.id, data)}
          onClose={closeModal}
        />
      )}
      {modal?.type === 'addChoice' && (
        <AddChoiceModal
          allScenes={modal.allScenes}
          onSubmit={(data) => handleAddChoice(modal.sceneId, data)}
          onClose={closeModal}
        />
      )}
      {modal?.type === 'confirm' && (
        <ConfirmModal
          message={modal.message}
          onConfirm={modal.onConfirm}
          onClose={closeModal}
        />
      )}

      {/* ── 에러 ── */}
      {error && (
        <div className="bg-red-900 border border-red-700 text-red-200 p-4 rounded-lg flex items-center justify-between">
          <span>{error}</span>
          <button onClick={() => setError('')}><X size={16} /></button>
        </div>
      )}

      {/* ── 챕터 추가 버튼 ── */}
      <button
        onClick={() => setModal({ type: 'addChapter' })}
        className="flex items-center gap-2 px-4 py-2 bg-green-600 hover:bg-green-500 text-white rounded-lg transition"
      >
        <Plus size={20} />
        새 챕터 추가
      </button>

      {/* ── 챕터 목록 ── */}
      <div className="space-y-3">
        {chapters.map((chapter) => (
          <div key={chapter.id} className="bg-gray-800 rounded-lg border border-gray-700">
            {/* 챕터 헤더 */}
            <div
              onClick={() => setExpandedChapter(expandedChapter === chapter.id ? null : chapter.id)}
              className="p-4 cursor-pointer hover:bg-gray-750 flex items-center justify-between transition"
            >
              <div className="flex items-center gap-3">
                {expandedChapter === chapter.id
                  ? <ChevronUp size={20} className="text-blue-400" />
                  : <ChevronDown size={20} className="text-gray-400" />}
                <div>
                  <p className="font-semibold text-white">Chapter {chapter.chapter_num}: {chapter.title}</p>
                  <p className="text-sm text-gray-400">{chapter.scenes?.length || 0} 장면</p>
                </div>
              </div>
              <button
                onClick={(e) => {
                  e.stopPropagation()
                  setModal({
                    type: 'confirm',
                    message: `"${chapter.title}" 챕터를 삭제하시겠습니까? 포함된 모든 장면과 선택지도 삭제됩니다.`,
                    onConfirm: () => handleDeleteChapter(chapter.id),
                  })
                }}
                className="p-2 hover:bg-red-900 rounded transition"
              >
                <Trash2 size={18} className="text-red-500" />
              </button>
            </div>

            {/* 챕터 상세 */}
            {expandedChapter === chapter.id && (
              <div className="bg-gray-750 p-4 border-t border-gray-700 space-y-3">
                <button
                  onClick={() => setModal({ type: 'addScene', chapterId: chapter.id })}
                  className="flex items-center gap-2 px-3 py-2 bg-blue-600 hover:bg-blue-500 text-white rounded text-sm transition"
                >
                  <Plus size={16} />
                  장면 추가
                </button>

                <div className="space-y-2">
                  {chapter.scenes?.map((scene) => (
                    <div key={scene.id} className="bg-gray-800 p-3 rounded border border-gray-700">
                      {/* 장면 헤더 */}
                      <div
                        onClick={() => setExpandedScene(expandedScene === scene.id ? null : scene.id)}
                        className="cursor-pointer flex items-center justify-between"
                      >
                        <div className="flex items-center gap-2 min-w-0">
                          {expandedScene === scene.id
                            ? <ChevronUp size={16} className="shrink-0" />
                            : <ChevronDown size={16} className="shrink-0" />}
                          <p className="text-sm text-gray-300 truncate">
                            Scene {scene.scene_order}: {scene.text?.substring(0, 50)}…
                          </p>
                        </div>
                        <div className="flex items-center gap-1 shrink-0 ml-2">
                          <button
                            onClick={(e) => {
                              e.stopPropagation()
                              setModal({ type: 'editScene', scene })
                            }}
                            className="p-1 hover:bg-blue-900 rounded transition"
                          >
                            <Edit2 size={16} className="text-blue-400" />
                          </button>
                          <button
                            onClick={(e) => {
                              e.stopPropagation()
                              setModal({
                                type: 'confirm',
                                message: `Scene ${scene.scene_order}을 삭제하시겠습니까?`,
                                onConfirm: () => handleDeleteScene(scene.id),
                              })
                            }}
                            className="p-1 hover:bg-red-900 rounded transition"
                          >
                            <Trash2 size={16} className="text-red-500" />
                          </button>
                        </div>
                      </div>

                      {/* 장면 상세 */}
                      {expandedScene === scene.id && (
                        <div className="mt-3 pt-3 border-t border-gray-700 space-y-2">
                          <p className="text-xs text-gray-400">텍스트:</p>
                          <p className="text-sm text-gray-200 bg-gray-900 p-2 rounded max-h-24 overflow-y-auto whitespace-pre-wrap">
                            {scene.text}
                          </p>
                          {scene.background && (
                            <p className="text-xs text-gray-500 truncate">🖼 배경: {scene.background}</p>
                          )}
                          {scene.character && (
                            <p className="text-xs text-gray-500 truncate">🧍 캐릭터: {scene.character}</p>
                          )}

                          <button
                            onClick={() =>
                              setModal({
                                type: 'addChoice',
                                sceneId: scene.id,
                                allScenes: chapter.scenes.filter((s) => s.id !== scene.id),
                              })
                            }
                            className="text-xs px-2 py-1 bg-purple-600 hover:bg-purple-500 text-white rounded transition"
                          >
                            + 선택지 추가
                          </button>

                          {scene.choices?.length > 0 && (
                            <div className="mt-2 space-y-1">
                              {scene.choices.map((choice) => (
                                <div key={choice.id} className="flex items-center justify-between text-xs bg-gray-900 p-2 rounded">
                                  <span className="text-gray-300 truncate">▸ {choice.label}</span>
                                  <button
                                    onClick={() =>
                                      setModal({
                                        type: 'confirm',
                                        message: `"${choice.label}" 선택지를 삭제하시겠습니까?`,
                                        onConfirm: () => handleDeleteChoice(choice.id),
                                      })
                                    }
                                    className="p-1 hover:bg-red-900 rounded shrink-0 ml-2"
                                  >
                                    <Trash2 size={14} className="text-red-500" />
                                  </button>
                                </div>
                              ))}
                            </div>
                          )}
                        </div>
                      )}
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>
        ))}
      </div>

      {loading && <p className="text-gray-400 text-sm">로딩 중...</p>}
    </div>
  )
}
