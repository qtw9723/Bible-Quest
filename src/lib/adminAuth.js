/**
 * adminAuth.js — 어드민 쿠키 인증 유틸
 *
 * 방식: 쿠키 기반 (서버 세션 없음)
 *  - 로그인 성공 시 쿠키 'bq_admin_auth=1' 저장 (7일 만료)
 *  - AdminPanel 진입 시마다 refreshAdminSession() 호출 → 만료일 갱신 (슬라이딩 만료)
 *  - 7일 이상 미접속 시 쿠키 자동 만료 → 자동 로그아웃
 *
 * 사용처:
 *  - GlobalMenu: 스킵 버튼 표시 여부 (isAdminLoggedIn)
 *  - ChapterSelect: 전체 챕터 잠금 해제 (isAdminLoggedIn)
 *  - AdminPanel: 로그인·로그아웃·세션 갱신
 */

const COOKIE_NAME = 'bq_admin_auth' // 어드민 쿠키 이름
const COOKIE_DAYS = 7               // 쿠키 유효 기간 (일)

/** 쿠키 저장 헬퍼 */
function setCookie(value, days) {
  const expires = new Date()
  expires.setDate(expires.getDate() + days)
  document.cookie = `${COOKIE_NAME}=${value}; expires=${expires.toUTCString()}; path=/; SameSite=Strict`
}

/** 쿠키 조회 헬퍼 — 해당 쿠키가 없으면 null 반환 */
function getCookie() {
  const match = document.cookie.split('; ').find(row => row.startsWith(`${COOKIE_NAME}=`))
  return match ? match.split('=')[1] : null
}

/** 쿠키 삭제 헬퍼 (만료일을 과거로 설정) */
function deleteCookie() {
  document.cookie = `${COOKIE_NAME}=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/`
}

/**
 * 현재 어드민으로 로그인되어 있는지 확인한다.
 * @returns {boolean}
 */
export function isAdminLoggedIn() {
  return getCookie() === '1'
}

/**
 * 어드민 로그인 처리 — 쿠키를 COOKIE_DAYS일 유효로 저장한다.
 */
export function adminLogin() {
  setCookie('1', COOKIE_DAYS)
}

/**
 * 어드민 세션 갱신 — AdminPanel 진입 시 호출하여 만료일을 연장한다.
 * 슬라이딩 만료: 접속할 때마다 7일 연장되어, 7일 이상 미접속 시 자동 로그아웃.
 */
export function refreshAdminSession() {
  if (isAdminLoggedIn()) setCookie('1', COOKIE_DAYS)
}

/**
 * 어드민 로그아웃 처리 — 쿠키를 삭제한다.
 */
export function adminLogout() {
  deleteCookie()
}
