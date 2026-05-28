// Supabase API calls
const SUPABASE_URL = import.meta.env.VITE_SUPABASE_URL
const SUPABASE_ANON_KEY = import.meta.env.VITE_SUPABASE_ANON_KEY

async function request(method, table, filters = {}) {
  let url = `${SUPABASE_URL}/rest/v1/${table}?`
  Object.entries(filters).forEach(([key, value]) => {
    url += `${key}=eq.${value}&`
  })

  const res = await fetch(url, {
    method,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${SUPABASE_ANON_KEY}`,
      'apikey': SUPABASE_ANON_KEY,
    },
  })

  if (!res.ok) {
    const text = await res.text()
    throw new Error(text || `HTTP ${res.status}`)
  }

  if (method === 'DELETE') return null
  return res.json()
}

export async function getChapters() {
  return request('GET', 'chapters')
}

export async function getStoryData(chapterNum) {
  const chapters = await request('GET', 'chapters', { chapter_num: chapterNum })
  return chapters[0] || null
}

export async function savePlayerProgress(playerId, chapterNum, completed) {
  // Will be called via Supabase Edge Function
}
