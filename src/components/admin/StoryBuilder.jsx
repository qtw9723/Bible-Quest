import { useState, useEffect } from 'react'
import { Plus, Trash2, Edit2, ChevronDown, ChevronUp } from 'lucide-react'
import { getChapters, createChapter, updateChapter, deleteChapter, getScenes, createScene, updateScene, deleteScene, getChoices, createChoice, updateChoice, deleteChoice } from '../../lib/api'

export default function StoryBuilder() {
  const [chapters, setChapters] = useState([])
  const [expandedChapter, setExpandedChapter] = useState(null)
  const [expandedScene, setExpandedScene] = useState(null)
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState('')

  useEffect(() => {
    loadChapters()
  }, [])

  const loadChapters = async () => {
    try {
      setLoading(true)
      const data = await getChapters()

      // Load scenes and choices for each chapter
      const chaptersWithScenes = await Promise.all(
        data.map(async (chapter) => {
          const scenes = await getScenes(chapter.id)
          const scenesWithChoices = await Promise.all(
            scenes.map(async (scene) => ({
              ...scene,
              choices: await getChoices(scene.id),
            }))
          )
          return {
            ...chapter,
            scenes: scenesWithChoices,
          }
        })
      )

      setChapters(chaptersWithScenes)
    } catch (e) {
      setError(e.message)
    } finally {
      setLoading(false)
    }
  }

  const handleAddChapter = async () => {
    const chapterNum = chapters.length + 1
    const title = prompt(`Chapter ${chapterNum} 제목:`)
    if (!title) return

    try {
      await createChapter({
        chapter_num: chapterNum,
        title,
        description: '',
      })
      loadChapters()
    } catch (e) {
      setError(e.message)
    }
  }

  const handleDeleteChapter = async (id) => {
    if (!confirm('챕터를 삭제하시겠습니까?')) return
    try {
      await deleteChapter(id)
      loadChapters()
    } catch (e) {
      setError(e.message)
    }
  }

  const handleAddScene = async (chapterId) => {
    const chapter = chapters.find(ch => ch.id === chapterId)
    const sceneOrder = (chapter.scenes?.length || 0) + 1

    const text = prompt(`Scene ${sceneOrder} 텍스트:`)
    if (!text) return

    try {
      await createScene({
        chapter_id: chapterId,
        scene_order: sceneOrder,
        text,
        character: '',
        background: '',
      })
      setExpandedChapter(chapterId)
      loadChapters()
    } catch (e) {
      setError(e.message)
    }
  }

  const handleDeleteScene = async (sceneId) => {
    if (!confirm('장면을 삭제하시겠습니까?')) return
    try {
      await deleteScene(sceneId)
      loadChapters()
    } catch (e) {
      setError(e.message)
    }
  }

  const handleEditScene = async (sceneId, currentScene) => {
    const text = prompt('장면 텍스트:', currentScene.text)
    if (text === null) return

    try {
      await updateScene(sceneId, { text })
      loadChapters()
    } catch (e) {
      setError(e.message)
    }
  }

  const handleAddChoice = async (sceneId) => {
    const label = prompt('선택지 텍스트:')
    if (!label) return

    try {
      const choices = await getChoices(sceneId)
      await createChoice({
        scene_id: sceneId,
        choice_order: choices.length + 1,
        label,
        next_scene_id: null,
      })
      setExpandedScene(sceneId)
      loadChapters()
    } catch (e) {
      setError(e.message)
    }
  }

  const handleDeleteChoice = async (choiceId) => {
    if (!confirm('선택지를 삭제하시겠습니까?')) return
    try {
      await deleteChoice(choiceId)
      loadChapters()
    } catch (e) {
      setError(e.message)
    }
  }

  return (
    <div className="space-y-6">
      {error && (
        <div className="bg-red-900 border border-red-700 text-red-200 p-4 rounded-lg">
          {error}
        </div>
      )}

      <button
        onClick={handleAddChapter}
        className="flex items-center gap-2 px-4 py-2 bg-green-600 hover:bg-green-500 text-white rounded-lg transition"
      >
        <Plus size={20} />
        새 챕터 추가
      </button>

      <div className="space-y-3">
        {chapters.map((chapter) => (
          <div key={chapter.id} className="bg-gray-800 rounded-lg border border-gray-700">
            <div
              onClick={() => setExpandedChapter(expandedChapter === chapter.id ? null : chapter.id)}
              className="p-4 cursor-pointer hover:bg-gray-750 flex items-center justify-between transition"
            >
              <div className="flex items-center gap-3">
                {expandedChapter === chapter.id ? (
                  <ChevronUp size={20} className="text-blue-400" />
                ) : (
                  <ChevronDown size={20} className="text-gray-400" />
                )}
                <div>
                  <p className="font-semibold text-white">Chapter {chapter.chapter_num}: {chapter.title}</p>
                  <p className="text-sm text-gray-400">{chapter.scenes?.length || 0} 장면</p>
                </div>
              </div>
              <button
                onClick={(e) => {
                  e.stopPropagation()
                  handleDeleteChapter(chapter.id)
                }}
                className="p-2 hover:bg-red-900 rounded transition"
              >
                <Trash2 size={18} className="text-red-500" />
              </button>
            </div>

            {expandedChapter === chapter.id && (
              <div className="bg-gray-750 p-4 border-t border-gray-700 space-y-3">
                <button
                  onClick={() => handleAddScene(chapter.id)}
                  className="flex items-center gap-2 px-3 py-2 bg-blue-600 hover:bg-blue-500 text-white rounded text-sm transition"
                >
                  <Plus size={16} />
                  장면 추가
                </button>

                <div className="space-y-2">
                  {chapter.scenes?.map((scene) => (
                    <div key={scene.id} className="bg-gray-800 p-3 rounded border border-gray-700">
                      <div
                        onClick={() => setExpandedScene(expandedScene === scene.id ? null : scene.id)}
                        className="cursor-pointer flex items-center justify-between"
                      >
                        <div className="flex items-center gap-2">
                          {expandedScene === scene.id ? (
                            <ChevronUp size={16} />
                          ) : (
                            <ChevronDown size={16} />
                          )}
                          <p className="text-sm text-gray-300 truncate">
                            Scene {scene.scene_order}: {scene.text?.substring(0, 50)}...
                          </p>
                        </div>
                        <div className="flex items-center gap-1">
                          <button
                            onClick={(e) => {
                              e.stopPropagation()
                              handleEditScene(scene.id, scene)
                            }}
                            className="p-1 hover:bg-blue-900 rounded transition"
                          >
                            <Edit2 size={16} className="text-blue-400" />
                          </button>
                          <button
                            onClick={(e) => {
                              e.stopPropagation()
                              handleDeleteScene(scene.id)
                            }}
                            className="p-1 hover:bg-red-900 rounded transition"
                          >
                            <Trash2 size={16} className="text-red-500" />
                          </button>
                        </div>
                      </div>

                      {expandedScene === scene.id && (
                        <div className="mt-3 pt-3 border-t border-gray-700 space-y-2">
                          <p className="text-xs text-gray-400">텍스트:</p>
                          <p className="text-sm text-gray-200 bg-gray-900 p-2 rounded max-h-24 overflow-y-auto">
                            {scene.text}
                          </p>

                          <button
                            onClick={() => handleAddChoice(scene.id)}
                            className="text-xs px-2 py-1 bg-purple-600 hover:bg-purple-500 text-white rounded transition"
                          >
                            + 선택지 추가
                          </button>

                          {scene.choices?.length > 0 && (
                            <div className="mt-2 space-y-1">
                              {scene.choices.map((choice) => (
                                <div key={choice.id} className="flex items-center justify-between text-xs bg-gray-900 p-2 rounded">
                                  <span className="text-gray-300">▸ {choice.label}</span>
                                  <button
                                    onClick={() => handleDeleteChoice(choice.id)}
                                    className="p-1 hover:bg-red-900 rounded"
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

      {loading && <p className="text-gray-400">로딩 중...</p>}
    </div>
  )
}
