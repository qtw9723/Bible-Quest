const STORAGE_KEY = 'biblequest_gamestate'

export function initializeGame() {
  const saved = localStorage.getItem(STORAGE_KEY)
  if (saved) return JSON.parse(saved)
  return {
    nickname: null,
    teamId: null,
    teamName: null,
    completedChapters: [],
    lastChapter: null,
    createdAt: new Date().toISOString(),
  }
}

export function saveProgress(nickname, chapterNum, teamId, teamName) {
  const state = initializeGame()
  state.nickname = nickname
  if (teamId) state.teamId = teamId
  if (teamName) state.teamName = teamName
  state.lastChapter = chapterNum
  if (!state.completedChapters.includes(chapterNum)) {
    state.completedChapters.push(chapterNum)
  }
  localStorage.setItem(STORAGE_KEY, JSON.stringify(state))
}

export function getGameState() {
  return initializeGame()
}
