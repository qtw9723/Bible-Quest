// Supabase API calls
const SUPABASE_URL = import.meta.env.VITE_SUPABASE_URL
const SUPABASE_ANON_KEY = import.meta.env.VITE_SUPABASE_ANON_KEY

async function request(method, table, data = null, filters = {}) {
  let url = `${SUPABASE_URL}/rest/v1/${table}?`
  Object.entries(filters).forEach(([key, value]) => {
    url += `${key}=eq.${value}&`
  })

  const options = {
    method,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
      'apikey': SUPABASE_ANON_KEY,
    },
  }

  if (data) {
    options.body = JSON.stringify(data)
  }

  const res = await fetch(url, options)

  if (!res.ok) {
    const text = await res.text()
    throw new Error(text || `HTTP ${res.status}`)
  }

  if (method === 'DELETE') return null

  // Supabase는 POST/PATCH 요청 후 빈 응답을 반환할 수 있음
  const text = await res.text()
  if (!text) return null
  return JSON.parse(text)
}

// Chapters
export async function getChapters() {
  return request('GET', 'chapters')
}

export async function createChapter(chapter) {
  return request('POST', 'chapters', chapter)
}

export async function updateChapter(id, data) {
  let url = `${SUPABASE_URL}/rest/v1/chapters?id=eq.${id}`
  const res = await fetch(url, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
      'apikey': SUPABASE_ANON_KEY,
    },
    body: JSON.stringify(data),
  })
  if (!res.ok) throw new Error(`HTTP ${res.status}`)
  const text = await res.text()
  return text ? JSON.parse(text) : null
}

export async function deleteChapter(id) {
  let url = `${SUPABASE_URL}/rest/v1/chapters?id=eq.${id}`
  const res = await fetch(url, {
    method: 'DELETE',
    headers: {
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
      'apikey': SUPABASE_ANON_KEY,
    },
  })
  if (!res.ok) throw new Error(`HTTP ${res.status}`)
  return null
}

// Scenes
export async function getScenes(chapterId) {
  let url = `${SUPABASE_URL}/rest/v1/scenes?chapter_id=eq.${chapterId}&order=scene_order.asc`
  const res = await fetch(url, {
    method: 'GET',
    headers: {
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
      'apikey': SUPABASE_ANON_KEY,
    },
  })
  if (!res.ok) throw new Error(`HTTP ${res.status}`)
  return res.json()
}

export async function createScene(scene) {
  return request('POST', 'scenes', scene)
}

export async function updateScene(id, data) {
  let url = `${SUPABASE_URL}/rest/v1/scenes?id=eq.${id}`
  const res = await fetch(url, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
      'apikey': SUPABASE_ANON_KEY,
    },
    body: JSON.stringify(data),
  })
  if (!res.ok) throw new Error(`HTTP ${res.status}`)
  const text = await res.text()
  return text ? JSON.parse(text) : null
}

export async function deleteScene(id) {
  let url = `${SUPABASE_URL}/rest/v1/scenes?id=eq.${id}`
  const res = await fetch(url, {
    method: 'DELETE',
    headers: {
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
      'apikey': SUPABASE_ANON_KEY,
    },
  })
  if (!res.ok) throw new Error(`HTTP ${res.status}`)
  return null
}

// Choices
export async function getChoices(sceneId) {
  let url = `${SUPABASE_URL}/rest/v1/choices?scene_id=eq.${sceneId}&order=choice_order.asc`
  const res = await fetch(url, {
    method: 'GET',
    headers: {
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
      'apikey': SUPABASE_ANON_KEY,
    },
  })
  if (!res.ok) throw new Error(`HTTP ${res.status}`)
  return res.json()
}

export async function createChoice(choice) {
  return request('POST', 'choices', choice)
}

export async function updateChoice(id, data) {
  let url = `${SUPABASE_URL}/rest/v1/choices?id=eq.${id}`
  const res = await fetch(url, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
      'apikey': SUPABASE_ANON_KEY,
    },
    body: JSON.stringify(data),
  })
  if (!res.ok) throw new Error(`HTTP ${res.status}`)
  const text = await res.text()
  return text ? JSON.parse(text) : null
}

export async function deleteChoice(id) {
  let url = `${SUPABASE_URL}/rest/v1/choices?id=eq.${id}`
  const res = await fetch(url, {
    method: 'DELETE',
    headers: {
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
      'apikey': SUPABASE_ANON_KEY,
    },
  })
  if (!res.ok) throw new Error(`HTTP ${res.status}`)
  return null
}

// Storage (Images)
export async function uploadImage(bucket, path, file) {
  const formData = new FormData()
  formData.append('file', file)

  // 먼저 POST(신규) 시도, 이미 존재하면 PUT(덮어쓰기)으로 재시도
  const url = `${SUPABASE_URL}/storage/v1/object/${bucket}/${path}`

  let res = await fetch(url, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
      'apikey': SUPABASE_ANON_KEY,
    },
    body: formData,
  })

  // 409 Conflict = 동일 경로 파일 이미 존재 → PUT으로 덮어쓰기
  if (res.status === 409) {
    res = await fetch(url, {
      method: 'PUT',
      headers: {
        'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
        'apikey': SUPABASE_ANON_KEY,
      },
      body: formData,
    })
  }

  if (!res.ok) {
    let message = `Upload failed: ${res.status}`
    try {
      const body = await res.json()
      message = body.error || body.message || message
    } catch (_) { /* 무시 */ }
    throw new Error(message)
  }

  return `${SUPABASE_URL}/storage/v1/object/public/${bucket}/${path}`
}

// Image Assets
export async function getImageAssets(category = null) {
  let url = `${SUPABASE_URL}/rest/v1/image_assets?order=created_at.desc`
  if (category) url += `&category=eq.${category}`
  const res = await fetch(url, {
    headers: { 'Authorization': `Bearer ${SUPABASE_ANON_KEY}`, 'apikey': SUPABASE_ANON_KEY },
  })
  if (!res.ok) throw new Error(`Failed to load images: ${res.status}`)
  return res.json()
}

export async function saveImageAsset({ name, category, file_path, public_url }) {
  return request('POST', 'image_assets', { name, category, file_path, public_url })
}

export async function updateImageAsset(id, { name }) {
  const url = `${SUPABASE_URL}/rest/v1/image_assets?id=eq.${id}`
  const res = await fetch(url, {
    method: 'PATCH',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
      'apikey': SUPABASE_ANON_KEY,
    },
    body: JSON.stringify({ name }),
  })
  if (!res.ok) throw new Error(`Update failed: ${res.status}`)
  return null
}

export async function deleteImageAsset(id) {
  const url = `${SUPABASE_URL}/rest/v1/image_assets?id=eq.${id}`
  const res = await fetch(url, {
    method: 'DELETE',
    headers: { 'Authorization': `Bearer ${SUPABASE_ANON_KEY}`, 'apikey': SUPABASE_ANON_KEY },
  })
  if (!res.ok) throw new Error(`Delete failed: ${res.status}`)
  return null
}

// Storage에서 파일 목록 조회
export async function listStorageFiles(bucket, folder = '') {
  const url = `${SUPABASE_URL}/storage/v1/object/list/${bucket}`
  const res = await fetch(url, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
      'apikey': SUPABASE_ANON_KEY,
    },
    body: JSON.stringify({ prefix: folder, limit: 200, offset: 0 }),
  })
  if (!res.ok) throw new Error(`Failed to list files: ${res.status}`)
  return res.json()
}

export async function deleteImage(bucket, path) {
  const url = `${SUPABASE_URL}/storage/v1/object/${bucket}/${path}`
  const res = await fetch(url, {
    method: 'DELETE',
    headers: {
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
      'apikey': SUPABASE_ANON_KEY,
    },
  })
  if (!res.ok) throw new Error(`Delete failed: ${res.status}`)
  return null
}

// Teams
export async function getTeams() {
  const res = await fetch(`${SUPABASE_URL}/rest/v1/teams?order=name.asc`, {
    headers: { 'Authorization': `Bearer ${SUPABASE_ANON_KEY}`, 'apikey': SUPABASE_ANON_KEY },
  })
  if (!res.ok) throw new Error(`Failed to load teams: ${res.status}`)
  return res.json()
}

export async function createTeam(name) {
  const res = await fetch(`${SUPABASE_URL}/rest/v1/teams`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
      'apikey': SUPABASE_ANON_KEY,
      'Prefer': 'return=representation',
    },
    body: JSON.stringify({ name }),
  })
  if (!res.ok) { const t = await res.text(); throw new Error(t || `HTTP ${res.status}`) }
  const data = await res.json()
  return data[0]
}

export async function deleteTeam(id) {
  const res = await fetch(`${SUPABASE_URL}/rest/v1/teams?id=eq.${id}`, {
    method: 'DELETE',
    headers: { 'Authorization': `Bearer ${SUPABASE_ANON_KEY}`, 'apikey': SUPABASE_ANON_KEY },
  })
  if (!res.ok) throw new Error(`HTTP ${res.status}`)
}

// Player Sessions (대시보드용)
export async function recordChapterComplete(playerName, chapterNum, teamId) {
  const body = { player_name: playerName, nickname: playerName, chapter_num: chapterNum }
  if (teamId) body.team_id = teamId
  const res = await fetch(`${SUPABASE_URL}/rest/v1/player_sessions`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
      'apikey': SUPABASE_ANON_KEY,
      'Prefer': 'resolution=ignore-duplicates',
    },
    body: JSON.stringify(body),
  })
  if (!res.ok) console.warn('Failed to record progress:', res.status)
}

export async function getDashboardStats() {
  const base = `${SUPABASE_URL}/rest/v1`
  const h = { 'Authorization': `Bearer ${SUPABASE_ANON_KEY}`, 'apikey': SUPABASE_ANON_KEY }

  const [sessions, chapters, teams] = await Promise.all([
    fetch(`${base}/player_sessions?order=completed_at.desc&limit=500`, { headers: h }).then(r => r.json()),
    fetch(`${base}/chapters?order=chapter_num.asc`, { headers: h }).then(r => r.json()),
    fetch(`${base}/teams?order=name.asc`, { headers: h }).then(r => r.json()),
  ])

  const teamMap = Object.fromEntries((teams || []).map(t => [t.id, t.name]))

  // 플레이어별 집계
  const playerMap = {}
  sessions.forEach(s => {
    const key = `${s.player_name || s.nickname}__${s.team_id || ''}`
    if (!playerMap[key]) playerMap[key] = {
      name: s.player_name || s.nickname,
      teamId: s.team_id,
      teamName: teamMap[s.team_id] || '팀 없음',
      completed: [],
      lastAt: s.completed_at,
    }
    playerMap[key].completed.push(s.chapter_num)
    if (s.completed_at > playerMap[key].lastAt) playerMap[key].lastAt = s.completed_at
  })
  const players = Object.values(playerMap).sort((a, b) => b.lastAt.localeCompare(a.lastAt))

  // 팀별 집계
  const teamStats = teams.map(t => {
    const teamPlayers = players.filter(p => p.teamId === t.id)
    const teamSessions = sessions.filter(s => s.team_id === t.id)
    return {
      id: t.id,
      name: t.name,
      playerCount: teamPlayers.length,
      completions: teamSessions.length,
      avgCompleted: teamPlayers.length > 0
        ? (teamSessions.length / teamPlayers.length).toFixed(1)
        : '0',
    }
  })

  // 챕터별 완료 수
  const chapterStats = chapters.map(ch => ({
    chapter_num: ch.chapter_num,
    title: ch.title,
    count: sessions.filter(s => s.chapter_num === ch.chapter_num).length,
  }))

  return {
    totalPlayers: players.length,
    totalCompletions: sessions.length,
    players,
    teamStats,
    chapterStats,
    recent: sessions.slice(0, 20).map(s => ({ ...s, teamName: teamMap[s.team_id] || '' })),
  }
}

export async function getStoryData(chapterNum) {
  const chapters = await getChapters()
  const chapter = chapters.find(ch => ch.chapter_num === chapterNum)
  if (!chapter) return null

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
}
