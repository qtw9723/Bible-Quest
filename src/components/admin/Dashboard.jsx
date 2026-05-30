import { useState, useEffect } from 'react'
import { Users, Trophy, BookOpen, Clock, RefreshCw, TrendingUp } from 'lucide-react'
import { getDashboardStats } from '../../lib/api'

function StatCard({ icon: Icon, label, value, color = 'blue' }) {
  const colors = {
    blue: 'bg-blue-500/10 text-blue-400 border-blue-500/20',
    green: 'bg-green-500/10 text-green-400 border-green-500/20',
    amber: 'bg-amber-500/10 text-amber-400 border-amber-500/20',
    purple: 'bg-purple-500/10 text-purple-400 border-purple-500/20',
  }
  return (
    <div className={`rounded-xl border p-5 ${colors[color]}`}>
      <div className="flex items-center gap-3 mb-2">
        <Icon size={20} />
        <span className="text-sm text-gray-400">{label}</span>
      </div>
      <p className="text-3xl font-bold text-white">{value}</p>
    </div>
  )
}

export default function Dashboard() {
  const [stats, setStats] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')

  const load = async () => {
    try {
      setLoading(true)
      setError('')
      const data = await getDashboardStats()
      setStats(data)
    } catch (e) {
      setError(e.message)
    } finally {
      setLoading(false)
    }
  }

  useEffect(() => { load() }, [])

  const fmtDate = (iso) => {
    const d = new Date(iso)
    return d.toLocaleDateString('ko-KR', { month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit' })
  }

  if (loading) return <p className="text-gray-400 text-sm">로딩 중...</p>
  if (error) return <p className="text-red-400 text-sm">{error}</p>

  const maxCount = Math.max(...(stats.chapterStats.map(c => c.count)), 1)

  return (
    <div className="space-y-8">
      {/* 헤더 */}
      <div className="flex items-center justify-between">
        <h2 className="text-xl font-bold text-white">전체 현황</h2>
        <button onClick={load} className="flex items-center gap-1 px-3 py-1.5 bg-gray-700 hover:bg-gray-600 text-gray-300 rounded-lg text-sm transition">
          <RefreshCw size={14} />
          새로고침
        </button>
      </div>

      {/* 요약 카드 */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
        <StatCard icon={Users}    label="총 플레이어"    value={stats.totalPlayers}     color="blue" />
        <StatCard icon={Trophy}   label="총 완료 횟수"   value={stats.totalCompletions}  color="green" />
        <StatCard icon={BookOpen} label="챕터 수"        value={stats.chapterStats.length} color="amber" />
        <StatCard icon={TrendingUp} label="평균 완료 챕터" value={
          stats.totalPlayers > 0
            ? (stats.totalCompletions / stats.totalPlayers).toFixed(1)
            : '0'
        } color="purple" />
      </div>

      {/* 챕터별 완료 현황 */}
      <div className="bg-gray-800 rounded-xl border border-gray-700 p-5">
        <h3 className="text-base font-semibold text-white mb-4">챕터별 완료 수</h3>
        <div className="space-y-2.5">
          {stats.chapterStats.map(ch => (
            <div key={ch.chapter_num} className="flex items-center gap-3">
              <span className="text-xs text-gray-400 w-4 text-right shrink-0">{ch.chapter_num}</span>
              <span className="text-xs text-gray-300 w-28 shrink-0 truncate">{ch.title}</span>
              <div className="flex-1 bg-gray-700 rounded-full h-2">
                <div
                  className="bg-blue-500 h-2 rounded-full transition-all duration-500"
                  style={{ width: `${(ch.count / maxCount) * 100}%` }}
                />
              </div>
              <span className="text-xs text-gray-400 w-6 text-right shrink-0">{ch.count}</span>
            </div>
          ))}
        </div>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
        {/* 사용자별 현황 */}
        <div className="bg-gray-800 rounded-xl border border-gray-700 p-5">
          <h3 className="text-base font-semibold text-white mb-4">
            사용자별 현황 <span className="text-gray-500 text-sm font-normal">({stats.players.length}명)</span>
          </h3>
          {stats.players.length === 0 ? (
            <p className="text-gray-500 text-sm">아직 완료 기록이 없습니다</p>
          ) : (
            <div className="space-y-2 max-h-72 overflow-y-auto">
              {stats.players.map((p, i) => (
                <div key={p.nickname} className="flex items-center gap-3 py-2 border-b border-gray-700 last:border-0">
                  <span className="text-xs text-gray-500 w-5 text-right">{i + 1}</span>
                  <div className="flex-1 min-w-0">
                    <p className="text-sm text-white font-medium truncate">{p.nickname}</p>
                    <p className="text-xs text-gray-500">{fmtDate(p.lastAt)}</p>
                  </div>
                  <div className="shrink-0 text-right">
                    <span className="inline-flex items-center gap-1 px-2 py-0.5 bg-green-500/10 text-green-400 rounded-full text-xs">
                      <Trophy size={10} />
                      {p.completed.length}챕터
                    </span>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>

        {/* 최근 활동 */}
        <div className="bg-gray-800 rounded-xl border border-gray-700 p-5">
          <h3 className="text-base font-semibold text-white mb-4">최근 완료 기록</h3>
          {stats.recent.length === 0 ? (
            <p className="text-gray-500 text-sm">아직 기록이 없습니다</p>
          ) : (
            <div className="space-y-2 max-h-72 overflow-y-auto">
              {stats.recent.map((r) => (
                <div key={r.id} className="flex items-center gap-3 py-2 border-b border-gray-700 last:border-0">
                  <div className="w-7 h-7 rounded-full bg-amber-500/10 flex items-center justify-center shrink-0">
                    <span className="text-xs text-amber-400 font-bold">{r.chapter_num}</span>
                  </div>
                  <div className="flex-1 min-w-0">
                    <p className="text-sm text-white truncate">{r.nickname}</p>
                    <p className="text-xs text-gray-500">{fmtDate(r.completed_at)}</p>
                  </div>
                  <Clock size={12} className="text-gray-600 shrink-0" />
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  )
}
