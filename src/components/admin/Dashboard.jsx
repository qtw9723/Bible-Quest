/**
 * Dashboard.jsx — 어드민 대시보드
 *
 * 표시 정보:
 *  - 요약 카드: 총 플레이어 / 총 완료 횟수 / 팀 수 / 엔딩 수집 합계
 *  - 전체 현황: 챕터별 완료 수 바차트 + 최근 완료 기록
 *  - 팀별: 팀 플레이어 수 / 완료 횟수 / 평균 챕터
 *  - 사용자별: 완료 챕터 수 + 챕터별 엔딩 수집 현황 (●●○ 형태)
 */
import { useState, useEffect } from 'react'
import { Users, Trophy, BookOpen, Clock, RefreshCw, TrendingUp, Shield, Sparkles } from 'lucide-react'
import { getDashboardStats } from '../../lib/api'

function StatCard({ icon: Icon, label, value, color = 'blue' }) {
  const colors = {
    blue:   'bg-blue-500/10   text-blue-400   border-blue-500/20',
    green:  'bg-green-500/10  text-green-400  border-green-500/20',
    amber:  'bg-amber-500/10  text-amber-400  border-amber-500/20',
    purple: 'bg-purple-500/10 text-purple-400 border-purple-500/20',
  }
  return (
    <div className={`rounded-xl border p-5 ${colors[color]}`}>
      <div className="flex items-center gap-3 mb-2">
        <Icon size={20} /><span className="text-sm text-gray-400">{label}</span>
      </div>
      <p className="text-3xl font-bold text-white">{value}</p>
    </div>
  )
}

/**
 * 챕터별 엔딩 수집 현황을 3개 점(●●○)으로 표시하는 컴포넌트
 * endings: { "1": [0, 2], "3": [1] } 형태
 */
function EndingDots({ endings, chapterCount }) {
  if (!endings || Object.keys(endings).length === 0) return null

  // 완료된 챕터만 표시 (최대 11개)
  const completedChapters = Object.keys(endings)
    .map(Number)
    .sort((a, b) => a - b)

  if (completedChapters.length === 0) return null

  return (
    <div className="mt-1.5 flex flex-wrap gap-1.5">
      {completedChapters.map(chap => {
        const done = endings[String(chap)] ?? []
        const allDone = done.length === 3
        return (
          <div
            key={chap}
            title={`챕터 ${chap}: ${done.length}/3 엔딩`}
            className={`inline-flex items-center gap-0.5 px-1.5 py-0.5 rounded text-xs border ${
              allDone
                ? 'bg-amber-500/15 border-amber-500/30 text-amber-400'
                : 'bg-gray-700/50 border-gray-600/50 text-gray-400'
            }`}
          >
            <span className="font-medium">{chap}</span>
            <span className="ml-0.5 flex gap-0.5">
              {[0, 1, 2].map(i => (
                <span
                  key={i}
                  className={`inline-block w-1.5 h-1.5 rounded-full ${
                    done.includes(i) ? 'bg-amber-400' : 'bg-gray-600'
                  }`}
                />
              ))}
            </span>
          </div>
        )
      })}
    </div>
  )
}

export default function Dashboard() {
  const [stats, setStats] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState('')
  const [tab, setTab] = useState('overview') // overview | teams | players

  const load = async () => {
    try { setLoading(true); setError(''); setStats(await getDashboardStats()) }
    catch (e) { setError(e.message) }
    finally { setLoading(false) }
  }

  useEffect(() => { load() }, [])

  const fmtDate = (iso) => new Date(iso).toLocaleDateString('ko-KR', {
    month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit',
  })

  if (loading) return <p className="text-gray-400 text-sm">로딩 중...</p>
  if (error)   return <p className="text-red-400 text-sm">오류: {error}</p>

  const maxChapter = Math.max(...stats.chapterStats.map(c => c.count), 1)
  const maxTeam    = Math.max(...stats.teamStats.map(t => t.completions), 1)

  return (
    <div className="space-y-6">
      {/* 헤더 */}
      <div className="flex items-center justify-between">
        <h2 className="text-xl font-bold text-white">대시보드</h2>
        <button
          onClick={load}
          className="flex items-center gap-1 px-3 py-1.5 bg-gray-700 hover:bg-gray-600 text-gray-300 rounded-lg text-sm transition"
        >
          <RefreshCw size={14} /> 새로고침
        </button>
      </div>

      {/* 요약 카드 */}
      <div className="grid grid-cols-2 lg:grid-cols-4 gap-4">
        <StatCard icon={Users}     label="총 플레이어"    value={stats.totalPlayers}           color="blue" />
        <StatCard icon={Trophy}    label="총 완료 횟수"   value={stats.totalCompletions}        color="green" />
        <StatCard icon={Shield}    label="팀 수"          value={stats.teamStats.length}        color="amber" />
        <StatCard icon={Sparkles}  label="엔딩 수집 합계" value={stats.totalEndingsCollected ?? 0} color="purple" />
      </div>

      {/* 탭 */}
      <div className="flex gap-2 border-b border-gray-700 pb-1">
        {[['overview','전체 현황'], ['teams','팀별'], ['players','사용자별']].map(([k, l]) => (
          <button key={k} onClick={() => setTab(k)}
            className={`px-4 py-1.5 rounded-t-lg text-sm font-medium transition ${
              tab === k ? 'bg-gray-700 text-white' : 'text-gray-400 hover:text-white'
            }`}
          >
            {l}
          </button>
        ))}
      </div>

      {/* ── 전체 현황 ── */}
      {tab === 'overview' && (
        <div className="space-y-6">

          {/* 챕터별 완료 수 바차트 */}
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
                      style={{ width: `${(ch.count / maxChapter) * 100}%` }}
                    />
                  </div>
                  <span className="text-xs text-gray-400 w-6 text-right shrink-0">{ch.count}</span>
                </div>
              ))}
            </div>
          </div>

          {/* 최근 완료 기록 */}
          <div className="bg-gray-800 rounded-xl border border-gray-700 p-5">
            <h3 className="text-base font-semibold text-white mb-4">최근 완료 기록</h3>
            {stats.recent.length === 0 ? (
              <p className="text-gray-500 text-sm">기록 없음</p>
            ) : (
              <div className="space-y-2 max-h-64 overflow-y-auto">
                {stats.recent.map((r) => (
                  <div key={r.id} className="flex items-center gap-3 py-2 border-b border-gray-700 last:border-0">
                    <div className="w-7 h-7 rounded-full bg-amber-500/10 flex items-center justify-center shrink-0">
                      <span className="text-xs text-amber-400 font-bold">{r.chapter_num}</span>
                    </div>
                    <div className="flex-1 min-w-0">
                      <p className="text-sm text-white truncate">
                        {r.player_name || r.nickname}
                        {r.teamName && <span className="text-xs text-gray-500 ml-1">· {r.teamName}</span>}
                      </p>
                      <p className="text-xs text-gray-500">{fmtDate(r.completed_at)}</p>
                    </div>
                    {/* 엔딩 번호 표시 (ending_index 있을 때) */}
                    {r.ending_index !== null && r.ending_index !== undefined && (
                      <span className="text-xs text-amber-400/70 shrink-0">
                        엔딩 {r.ending_index + 1}
                      </span>
                    )}
                    <Clock size={12} className="text-gray-600 shrink-0" />
                  </div>
                ))}
              </div>
            )}
          </div>
        </div>
      )}

      {/* ── 팀별 현황 ── */}
      {tab === 'teams' && (
        <div className="space-y-4">
          {stats.teamStats.length === 0 ? (
            <p className="text-gray-500 text-sm">등록된 팀이 없거나 아직 기록이 없습니다</p>
          ) : stats.teamStats.map(team => (
            <div key={team.id} className="bg-gray-800 rounded-xl border border-gray-700 p-5">
              <div className="flex items-center justify-between mb-3">
                <div className="flex items-center gap-2">
                  <Shield size={16} className="text-blue-400" />
                  <h3 className="font-semibold text-white">{team.name}</h3>
                </div>
                <div className="flex gap-3 text-xs text-gray-400">
                  <span><span className="text-white font-medium">{team.playerCount}</span>명</span>
                  <span>완료 <span className="text-green-400 font-medium">{team.completions}</span>회</span>
                  <span>평균 <span className="text-amber-400 font-medium">{team.avgCompleted}</span>챕터</span>
                </div>
              </div>
              <div className="bg-gray-700 rounded-full h-2">
                <div
                  className="bg-blue-500 h-2 rounded-full"
                  style={{ width: `${(team.completions / maxTeam) * 100}%` }}
                />
              </div>
            </div>
          ))}
        </div>
      )}

      {/* ── 사용자별 현황 ── */}
      {tab === 'players' && (
        <div className="bg-gray-800 rounded-xl border border-gray-700 p-5">
          <h3 className="text-base font-semibold text-white mb-4">
            사용자 목록{' '}
            <span className="text-gray-500 text-sm font-normal">({stats.players.length}명)</span>
          </h3>
          {stats.players.length === 0 ? (
            <p className="text-gray-500 text-sm">아직 완료 기록이 없습니다</p>
          ) : (
            <div className="space-y-3 max-h-[32rem] overflow-y-auto">
              {stats.players.map((p, i) => (
                <div
                  key={`${p.name}_${p.teamId}`}
                  className="py-2.5 border-b border-gray-700 last:border-0"
                >
                  <div className="flex items-center gap-3">
                    <span className="text-xs text-gray-500 w-5 text-right shrink-0">{i + 1}</span>

                    <div className="flex-1 min-w-0">
                      <p className="text-sm text-white font-medium truncate">{p.name}</p>
                      <p className="text-xs text-gray-500">{p.teamName} · {fmtDate(p.lastAt)}</p>
                    </div>

                    {/* 오른쪽: 챕터 수 + 엔딩 수집 수 */}
                    <div className="flex items-center gap-2 shrink-0">
                      <span className="inline-flex items-center gap-1 px-2 py-0.5 bg-green-500/10 text-green-400 rounded-full text-xs">
                        <Trophy size={10} /> {p.completed.length}챕터
                      </span>
                      {p.totalEndingCount > 0 && (
                        <span className="inline-flex items-center gap-1 px-2 py-0.5 bg-amber-500/10 text-amber-400 rounded-full text-xs">
                          <Sparkles size={10} /> {p.totalEndingCount}엔딩
                        </span>
                      )}
                    </div>
                  </div>

                  {/* 챕터별 엔딩 수집 점 표시 */}
                  <div className="ml-8">
                    <EndingDots endings={p.endings} chapterCount={p.completed.length} />
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      )}
    </div>
  )
}
