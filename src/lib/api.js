/**
 * api.js — Supabase REST API 호출 함수 모음
 *
 * Supabase SDK를 사용하지 않고 fetch()로 직접 PostgREST API를 호출한다.
 * 이유: 번들 크기 절감, Supabase SDK 의존성 제거.
 *
 * 모든 테이블은 RLS(Row Level Security)가 비활성화되어 있으므로
 * anon 키만으로 읽기/쓰기가 모두 가능하다.
 *
 * 환경변수 (Vite):
 *   VITE_SUPABASE_URL      — Supabase 프로젝트 URL
 *   VITE_SUPABASE_ANON_KEY — 공개 anon 키 (소스 노출 무방)
 */

const SUPABASE_URL = import.meta.env.VITE_SUPABASE_URL
const SUPABASE_ANON_KEY = import.meta.env.VITE_SUPABASE_ANON_KEY

// ────────────────────────────────────────────────────────────────
// 내부 유틸
// ────────────────────────────────────────────────────────────────

/**
 * 공용 REST 요청 래퍼.
 * filters 객체는 { column: value } 형태로 전달하면 ?column=eq.value 쿼리로 변환된다.
 *
 * @param {'GET'|'POST'|'PATCH'|'DELETE'} method
 * @param {string} table  — Supabase 테이블명
 * @param {object|null} data    — 요청 바디 (POST/PATCH 시 사용)
 * @param {object} filters      — 필터 조건 (GET 시 WHERE 절)
 */
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

// ────────────────────────────────────────────────────────────────
// Chapters (챕터)
// ────────────────────────────────────────────────────────────────

/** 전체 챕터 목록 조회 */
export async function getChapters() {
  return request('GET', 'chapters')
}

/** 챕터 생성 (어드민용) */
export async function createChapter(chapter) {
  return request('POST', 'chapters', chapter)
}

/** 챕터 수정 (어드민용) */
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

/** 챕터 삭제 (어드민용) */
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

// ────────────────────────────────────────────────────────────────
// Scenes (씬)
// ────────────────────────────────────────────────────────────────

/**
 * 특정 챕터의 씬 목록 조회 (scene_order 오름차순)
 * @param {string} chapterId — chapters.id (UUID)
 */
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

/** 씬 생성 (어드민용) */
export async function createScene(scene) {
  return request('POST', 'scenes', scene)
}

/** 씬 수정 (어드민용) */
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

/** 씬 삭제 (어드민용) */
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

// ────────────────────────────────────────────────────────────────
// Choices (선택지)
// ────────────────────────────────────────────────────────────────

/**
 * 특정 씬의 선택지 목록 조회 (choice_order 오름차순)
 * next_scene_id가 null인 선택지는 챕터 완료를 의미한다.
 * @param {string} sceneId — scenes.id (UUID)
 */
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

/** 선택지 생성 (어드민용) */
export async function createChoice(choice) {
  return request('POST', 'choices', choice)
}

/** 선택지 수정 (어드민용) */
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

/** 선택지 삭제 (어드민용) */
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

// ────────────────────────────────────────────────────────────────
// Storage (이미지/미디어 업로드)
// ────────────────────────────────────────────────────────────────

/**
 * Supabase Storage에 파일을 업로드한다.
 * 동일 경로 파일이 이미 존재하면 PUT으로 덮어쓴다 (409 Conflict 처리).
 *
 * @param {string} bucket — 스토리지 버킷명 (예: 'bible-quest')
 * @param {string} path   — 버킷 내 경로 (예: 'backgrounds/image.jpg')
 * @param {File}   file   — 업로드할 파일 객체
 * @returns {string} 업로드된 파일의 공개 URL
 */
export async function uploadImage(bucket, path, file) {
  const formData = new FormData()
  formData.append('file', file)

  const url = `${SUPABASE_URL}/storage/v1/object/${bucket}/${path}`

  // 먼저 POST(신규 업로드) 시도
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
    } catch (_) { /* 파싱 실패 무시 */ }
    throw new Error(message)
  }

  return `${SUPABASE_URL}/storage/v1/object/public/${bucket}/${path}`
}

// ────────────────────────────────────────────────────────────────
// Image Assets (이미지 에셋 메타데이터)
// ────────────────────────────────────────────────────────────────

/**
 * image_assets 테이블에서 에셋 목록 조회.
 * @param {string|null} category — 'backgrounds' | 'characters' | 'ui' | null(전체)
 */
export async function getImageAssets(category = null) {
  let url = `${SUPABASE_URL}/rest/v1/image_assets?order=created_at.desc`
  if (category) url += `&category=eq.${category}`
  const res = await fetch(url, {
    headers: { 'Authorization': `Bearer ${SUPABASE_ANON_KEY}`, 'apikey': SUPABASE_ANON_KEY },
  })
  if (!res.ok) throw new Error(`Failed to load images: ${res.status}`)
  return res.json()
}

/** image_assets에 새 에셋 메타데이터 저장 */
export async function saveImageAsset({ name, category, file_path, public_url }) {
  return request('POST', 'image_assets', { name, category, file_path, public_url })
}

/** image_assets의 에셋 이름 수정 */
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

/** image_assets 레코드 삭제 (Storage 실제 파일은 deleteImage로 별도 삭제 필요) */
export async function deleteImageAsset(id) {
  const url = `${SUPABASE_URL}/rest/v1/image_assets?id=eq.${id}`
  const res = await fetch(url, {
    method: 'DELETE',
    headers: { 'Authorization': `Bearer ${SUPABASE_ANON_KEY}`, 'apikey': SUPABASE_ANON_KEY },
  })
  if (!res.ok) throw new Error(`Delete failed: ${res.status}`)
  return null
}

/**
 * Supabase Storage 버킷 내 파일 목록 조회 (어드민 미디어 관리용)
 * @param {string} bucket — 버킷명
 * @param {string} folder — 폴더 prefix (예: 'backgrounds/')
 */
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

/**
 * Supabase Storage에서 파일 삭제
 * @param {string} bucket — 버킷명
 * @param {string} path   — 버킷 내 경로
 */
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

// ────────────────────────────────────────────────────────────────
// Teams (팀)
// ────────────────────────────────────────────────────────────────

/** 팀 목록 조회 (이름 오름차순) */
export async function getTeams() {
  const res = await fetch(`${SUPABASE_URL}/rest/v1/teams?order=name.asc`, {
    headers: { 'Authorization': `Bearer ${SUPABASE_ANON_KEY}`, 'apikey': SUPABASE_ANON_KEY },
  })
  if (!res.ok) throw new Error(`Failed to load teams: ${res.status}`)
  return res.json()
}

/**
 * 팀 생성
 * @param {string} name — 팀 이름
 * @returns {object} 생성된 팀 객체
 */
export async function createTeam(name) {
  const res = await fetch(`${SUPABASE_URL}/rest/v1/teams`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
      'apikey': SUPABASE_ANON_KEY,
      'Prefer': 'return=representation', // 생성된 레코드를 응답으로 반환
    },
    body: JSON.stringify({ name }),
  })
  if (!res.ok) { const t = await res.text(); throw new Error(t || `HTTP ${res.status}`) }
  const data = await res.json()
  return data[0]
}

/** 팀 삭제 */
export async function deleteTeam(id) {
  const res = await fetch(`${SUPABASE_URL}/rest/v1/teams?id=eq.${id}`, {
    method: 'DELETE',
    headers: { 'Authorization': `Bearer ${SUPABASE_ANON_KEY}`, 'apikey': SUPABASE_ANON_KEY },
  })
  if (!res.ok) throw new Error(`HTTP ${res.status}`)
}

// ────────────────────────────────────────────────────────────────
// Player Sessions (플레이어 진행 기록 — 어드민 대시보드용)
// ────────────────────────────────────────────────────────────────

/**
 * 챕터 완료 기록을 player_sessions 테이블에 저장한다.
 * 동일 (player_name, chapter_num, ending_index) 조합이 이미 있으면 무시한다 (중복 방지).
 * ending_index가 다르면 같은 챕터를 여러 번 완료한 것으로 별도 기록된다 (엔딩 수집).
 *
 * @param {string} playerName      — 플레이어 이름
 * @param {number} chapterNum      — 완료한 챕터 번호
 * @param {string|null} teamId     — 팀 ID
 * @param {number|null} endingIndex — 완료한 엔딩 인덱스 (0·1·2)
 */
export async function recordChapterComplete(playerName, chapterNum, teamId, endingIndex = null) {
  const body = { player_name: playerName, nickname: playerName, chapter_num: chapterNum }
  if (teamId) body.team_id = teamId
  if (endingIndex !== null) body.ending_index = endingIndex
  const res = await fetch(`${SUPABASE_URL}/rest/v1/player_sessions`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
      'apikey': SUPABASE_ANON_KEY,
      'Prefer': 'resolution=ignore-duplicates', // 동일 엔딩 중복 기록 무시
    },
    body: JSON.stringify(body),
  })
  if (!res.ok) console.warn('Failed to record progress:', res.status)
}

/**
 * 어드민 대시보드용 통계 데이터를 조회하고 집계한다.
 * player_sessions, chapters, teams 세 테이블을 병렬로 조회해 클라이언트에서 집계.
 *
 * @returns {{
 *   totalPlayers: number,
 *   totalCompletions: number,
 *   players: object[],
 *   teamStats: object[],
 *   chapterStats: object[],
 *   recent: object[]
 * }}
 */
export async function getDashboardStats() {
  const base = `${SUPABASE_URL}/rest/v1`
  const h = { 'Authorization': `Bearer ${SUPABASE_ANON_KEY}`, 'apikey': SUPABASE_ANON_KEY }

  // 세 테이블을 병렬로 조회
  const [sessions, chapters, teams] = await Promise.all([
    fetch(`${base}/player_sessions?order=completed_at.desc&limit=500`, { headers: h }).then(r => r.json()),
    fetch(`${base}/chapters?order=chapter_num.asc`, { headers: h }).then(r => r.json()),
    fetch(`${base}/teams?order=name.asc`, { headers: h }).then(r => r.json()),
  ])

  // teamId → 팀 이름 매핑 (빠른 조회용)
  const teamMap = Object.fromEntries((teams || []).map(t => [t.id, t.name]))

  // ── 플레이어별 집계 ──
  // key: "이름__팀ID" (같은 이름이라도 팀이 다르면 별개의 플레이어로 취급)
  const playerMap = {}
  sessions.forEach(s => {
    const key = `${s.player_name || s.nickname}__${s.team_id || ''}`
    if (!playerMap[key]) playerMap[key] = {
      name: s.player_name || s.nickname,
      teamId: s.team_id,
      teamName: teamMap[s.team_id] || '팀 없음',
      completed: [],         // 완료한 챕터 번호 목록 (중복 포함 — 여러 엔딩 완료 시 중복)
      completedSet: new Set(), // 완료한 챕터 번호 집합 (해금 판정용)
      endings: {},           // { chapterNum: Set([endingIndex, ...]) }
      lastAt: s.completed_at,
    }
    playerMap[key].completed.push(s.chapter_num)
    playerMap[key].completedSet.add(s.chapter_num)
    // 엔딩 인덱스 집계
    if (s.ending_index !== null) {
      const ek = String(s.chapter_num)
      if (!playerMap[key].endings[ek]) playerMap[key].endings[ek] = new Set()
      playerMap[key].endings[ek].add(s.ending_index)
    }
    if (s.completed_at > playerMap[key].lastAt) playerMap[key].lastAt = s.completed_at
  })
  const players = Object.values(playerMap)
    .map(p => ({
      ...p,
      completed: [...p.completedSet], // 챕터 해금용: 중복 제거된 배열
      // endings를 { chapterNum: [0,1,2] } 형태로 직렬화
      endings: Object.fromEntries(
        Object.entries(p.endings).map(([k, v]) => [k, [...v].sort()])
      ),
      totalEndingCount: Object.values(p.endings).reduce((sum, s) => sum + s.size, 0),
    }))
    .sort((a, b) => b.lastAt.localeCompare(a.lastAt))

  // ── 팀별 집계 ──
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

  // ── 챕터별 완료 수 ──
  const chapterStats = chapters.map(ch => ({
    chapter_num: ch.chapter_num,
    title: ch.title,
    count: sessions.filter(s => s.chapter_num === ch.chapter_num).length,
  }))

  // 전체 엔딩 수집 수 (중복 없이 카운트)
  const totalEndingsCollected = players.reduce((sum, p) => sum + p.totalEndingCount, 0)

  return {
    totalPlayers: players.length,
    totalCompletions: sessions.length,
    totalEndingsCollected,  // 전체 플레이어의 엔딩 수집 합산
    players,
    teamStats,
    chapterStats,
    recent: sessions.slice(0, 20).map(s => ({ ...s, teamName: teamMap[s.team_id] || '' })),
  }
}

// ────────────────────────────────────────────────────────────────
// Player Progress (플레이어 진행도 조회 — 로그인 시 DB→localStorage 동기화)
// ────────────────────────────────────────────────────────────────

/**
 * 특정 플레이어의 player_sessions를 DB에서 조회해
 * completedChapters(챕터 번호 배열)와 completedEndings(챕터별 엔딩 인덱스 맵)를 반환한다.
 *
 * 로그인 시 호출 → localStorage와 합산해 gameState에 반영.
 * 이를 통해 다른 기기에서 완료한 챕터도 동기화된다.
 *
 * @param {string} playerName — 플레이어 이름
 * @returns {{ completedChapters: number[], completedEndings: object }}
 */
export async function getPlayerProgress(playerName) {
  if (!playerName) return { completedChapters: [], completedEndings: {} }
  try {
    const res = await fetch(
      `${SUPABASE_URL}/rest/v1/player_sessions?player_name=eq.${encodeURIComponent(playerName)}&select=chapter_num,ending_index`,
      { headers: { Authorization: `Bearer ${SUPABASE_ANON_KEY}`, apikey: SUPABASE_ANON_KEY } }
    )
    if (!res.ok) return { completedChapters: [], completedEndings: {} }
    const sessions = await res.json()

    // 챕터 번호 목록 (중복 제거, 오름차순)
    const completedChapters = [...new Set(sessions.map(s => s.chapter_num))].sort((a,b) => a-b)

    // 챕터별 완료 엔딩 인덱스 맵: { "1": [0, 2], "2": [1] }
    const completedEndings = {}
    sessions.forEach(s => {
      if (s.ending_index === null) return // 구버전 데이터(엔딩 미기록)는 무시
      const key = String(s.chapter_num)
      if (!completedEndings[key]) completedEndings[key] = []
      if (!completedEndings[key].includes(s.ending_index)) {
        completedEndings[key].push(s.ending_index)
      }
    })
    return { completedChapters, completedEndings }
  } catch {
    return { completedChapters: [], completedEndings: {} }
  }
}

// ────────────────────────────────────────────────────────────────
// Story Data (스토리 통합 조회 — StoryPage에서 사용)
// ────────────────────────────────────────────────────────────────

/**
 * 특정 챕터의 전체 스토리 데이터를 한 번에 조회한다.
 * 씬 목록을 조회한 뒤, 각 씬에 해당하는 선택지를 병렬로 붙인다.
 *
 * 참고: chapters.id 와 chapters.chapter_num 은 1 차이가 있음 (chapter_num=1 → id=2).
 *       여기서는 chapter_num으로 챕터를 찾기 때문에 혼동하지 말 것.
 *
 * @param {number} chapterNum — 챕터 번호 (1~11)
 * @returns {object|null} { ...chapter, scenes: [ { ...scene, choices: [...] }, ... ] }
 */
export async function getStoryData(chapterNum) {
  const chapters = await getChapters()
  const chapter = chapters.find(ch => ch.chapter_num === chapterNum)
  if (!chapter) return null

  const scenes = await getScenes(chapter.id)

  // 각 씬의 선택지를 병렬로 조회해 씬 객체에 붙임
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
