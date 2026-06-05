/**
 * gameState.js — 게임 진행 상태 관리 (localStorage)
 *
 * localStorage 키: 'biblequest_gamestate'
 * 저장 구조:
 *   nickname         : string   — 플레이어 이름
 *   teamId           : string   — 소속 팀 ID (Supabase teams.id)
 *   teamName         : string   — 소속 팀 이름 (표시용)
 *   completedChapters: number[] — 완료한 챕터 번호 목록 (예: [1, 2, 3])
 *   lastChapter      : number   — 마지막으로 플레이한 챕터 번호 (이어하기용)
 *   createdAt        : string   — 최초 저장 시각 (ISO 8601)
 */

const STORAGE_KEY = 'biblequest_gamestate'

/**
 * 게임 상태를 초기화하거나 localStorage에서 복원한다.
 * 저장된 데이터가 있으면 그대로 반환, 없으면 기본값 반환.
 *
 * @returns {object} 게임 상태 객체
 */
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

/**
 * 챕터 완료 시 진행도를 localStorage에 저장한다.
 * - completedChapters에 중복 없이 해당 챕터 번호 추가
 * - lastChapter를 방금 완료한 챕터로 갱신
 *
 * @param {string} nickname   — 플레이어 이름
 * @param {number} chapterNum — 완료한 챕터 번호
 * @param {string} teamId     — 팀 ID (없으면 null)
 * @param {string} teamName   — 팀 이름 (없으면 null)
 */
export function saveProgress(nickname, chapterNum, teamId, teamName) {
  const state = initializeGame()
  state.nickname = nickname
  if (teamId) state.teamId = teamId
  if (teamName) state.teamName = teamName
  state.lastChapter = chapterNum
  // 이미 완료한 챕터라면 중복 추가 방지
  if (!state.completedChapters.includes(chapterNum)) {
    state.completedChapters.push(chapterNum)
  }
  localStorage.setItem(STORAGE_KEY, JSON.stringify(state))
}

/**
 * 현재 게임 상태를 반환한다 (initializeGame과 동일, 명시적 조회용).
 *
 * @returns {object} 게임 상태 객체
 */
export function getGameState() {
  return initializeGame()
}
