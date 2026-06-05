/**
 * gameState.js — 게임 진행 상태 관리 (localStorage)
 *
 * localStorage 키: 'biblequest_gamestate'
 * 저장 구조:
 *   nickname         : string   — 플레이어 이름
 *   teamId           : string   — 소속 팀 ID (Supabase teams.id)
 *   teamName         : string   — 소속 팀 이름 (표시용)
 *   completedChapters: number[] — 완료한 챕터 번호 목록 (예: [1, 2, 3])
 *                                 챕터 해금 판정에 사용 (최소 1회 완료 여부만 체크)
 *   completedEndings : object   — 챕터별 완료한 엔딩 인덱스 목록
 *                                 예: { "1": [0, 2], "2": [1] }
 *                                 0=첫 번째 엔딩, 1=두 번째, 2=세 번째
 *   lastChapter      : number   — 마지막으로 플레이한 챕터 번호 (이어하기용)
 *   createdAt        : string   — 최초 저장 시각 (ISO 8601)
 */

const STORAGE_KEY = 'biblequest_gamestate'

/**
 * 게임 상태를 초기화하거나 localStorage에서 복원한다.
 * 저장된 데이터가 있으면 그대로 반환, 없으면 기본값 반환.
 * completedEndings가 없는 구버전 데이터도 안전하게 처리한다.
 *
 * @returns {object} 게임 상태 객체
 */
export function initializeGame() {
  const saved = localStorage.getItem(STORAGE_KEY)
  if (saved) {
    const parsed = JSON.parse(saved)
    // 구버전 데이터 호환: completedEndings 필드가 없으면 빈 객체로 초기화
    if (!parsed.completedEndings) parsed.completedEndings = {}
    return parsed
  }
  return {
    nickname: null,
    teamId: null,
    teamName: null,
    completedChapters: [],
    completedEndings: {},   // 챕터별 완료한 엔딩 인덱스 목록 (0·1·2)
    lastChapter: null,
    createdAt: new Date().toISOString(),
  }
}

/**
 * 챕터 완료 시 진행도를 localStorage에 저장한다.
 * - completedChapters: 챕터 번호를 중복 없이 추가 (챕터 해금 판정용)
 * - completedEndings: 챕터별로 완료한 엔딩 인덱스를 중복 없이 추가 (엔딩 수집 표시용)
 * - lastChapter: 방금 완료한 챕터로 갱신
 *
 * @param {string} nickname    — 플레이어 이름
 * @param {number} chapterNum  — 완료한 챕터 번호
 * @param {string} teamId      — 팀 ID (없으면 null)
 * @param {string} teamName    — 팀 이름 (없으면 null)
 * @param {number} endingIndex — 완료한 엔딩 인덱스 (0·1·2, 없으면 null)
 */
export function saveProgress(nickname, chapterNum, teamId, teamName, endingIndex = null) {
  const state = initializeGame()
  state.nickname = nickname
  if (teamId) state.teamId = teamId
  if (teamName) state.teamName = teamName
  state.lastChapter = chapterNum

  // 챕터 완료 목록 (해금 판정용 — 최소 1회 완료 여부만 기록)
  if (!state.completedChapters.includes(chapterNum)) {
    state.completedChapters.push(chapterNum)
  }

  // 엔딩 완료 목록 (수집 표시용 — 어떤 엔딩을 완료했는지 기록)
  if (endingIndex !== null) {
    const key = String(chapterNum)
    if (!state.completedEndings[key]) state.completedEndings[key] = []
    if (!state.completedEndings[key].includes(endingIndex)) {
      state.completedEndings[key].push(endingIndex)
    }
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
