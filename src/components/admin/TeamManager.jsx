import { useState, useEffect } from 'react'
import { Plus, Trash2, Users, X } from 'lucide-react'
import { getTeams, createTeam, deleteTeam } from '../../lib/api'

export default function TeamManager() {
  const [teams, setTeams] = useState([])
  const [loading, setLoading] = useState(false)
  const [newName, setNewName] = useState('')
  const [error, setError] = useState('')

  const load = async () => {
    try {
      setLoading(true)
      setTeams(await getTeams())
    } catch (e) { setError(e.message) }
    finally { setLoading(false) }
  }

  useEffect(() => { load() }, [])

  const handleCreate = async (e) => {
    e.preventDefault()
    if (!newName.trim()) return
    try {
      await createTeam(newName.trim())
      setNewName('')
      load()
    } catch (e) { setError(e.message) }
  }

  const handleDelete = async (team) => {
    if (!window.confirm(`"${team.name}" 팀을 삭제하시겠습니까?`)) return
    try {
      await deleteTeam(team.id)
      load()
    } catch (e) { setError(e.message) }
  }

  return (
    <div className="space-y-6 max-w-lg">
      <div>
        <h2 className="text-lg font-bold text-white mb-1">팀 관리</h2>
        <p className="text-sm text-gray-400">팀을 등록하면 사용자가 로그인 시 팀을 선택할 수 있습니다.</p>
      </div>

      {error && (
        <div className="bg-red-900 border border-red-700 text-red-200 p-3 rounded-lg flex items-center justify-between text-sm">
          <span>{error}</span>
          <button onClick={() => setError('')}><X size={14} /></button>
        </div>
      )}

      {/* 팀 추가 */}
      <form onSubmit={handleCreate} className="flex gap-2">
        <input
          value={newName} onChange={(e) => setNewName(e.target.value)}
          placeholder="새 팀 이름 입력"
          className="flex-1 bg-gray-700 text-white rounded-lg px-4 py-2.5 text-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
          maxLength={30}
        />
        <button type="submit" disabled={!newName.trim()}
          className="flex items-center gap-1.5 px-4 py-2.5 bg-green-600 hover:bg-green-500 disabled:opacity-40 text-white rounded-lg text-sm transition">
          <Plus size={16} /> 추가
        </button>
      </form>

      {/* 팀 목록 */}
      {loading ? (
        <p className="text-gray-400 text-sm">로딩 중...</p>
      ) : teams.length === 0 ? (
        <div className="text-center py-10 text-gray-500">
          <Users size={32} className="mx-auto mb-2 opacity-30" />
          <p className="text-sm">등록된 팀이 없습니다</p>
        </div>
      ) : (
        <div className="space-y-2">
          {teams.map((team, i) => (
            <div key={team.id} className="flex items-center justify-between bg-gray-800 border border-gray-700 rounded-xl px-4 py-3">
              <div className="flex items-center gap-3">
                <span className="text-xs text-gray-500 w-4">{i + 1}</span>
                <Users size={16} className="text-blue-400" />
                <span className="text-white text-sm font-medium">{team.name}</span>
              </div>
              <button onClick={() => handleDelete(team)}
                className="p-1.5 hover:bg-red-900 rounded-lg transition">
                <Trash2 size={15} className="text-red-500" />
              </button>
            </div>
          ))}
        </div>
      )}
    </div>
  )
}
