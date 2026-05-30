const COOKIE_NAME = 'bq_admin_auth'
const COOKIE_DAYS = 7

function setCookie(value, days) {
  const expires = new Date()
  expires.setDate(expires.getDate() + days)
  document.cookie = `${COOKIE_NAME}=${value}; expires=${expires.toUTCString()}; path=/; SameSite=Strict`
}

function getCookie() {
  const match = document.cookie.split('; ').find(row => row.startsWith(`${COOKIE_NAME}=`))
  return match ? match.split('=')[1] : null
}

function deleteCookie() {
  document.cookie = `${COOKIE_NAME}=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/`
}

export function isAdminLoggedIn() {
  return getCookie() === '1'
}

export function adminLogin() {
  setCookie('1', COOKIE_DAYS)
}

// 접속할 때마다 만료일 갱신 (1주일 미접속 시 자동 로그아웃)
export function refreshAdminSession() {
  if (isAdminLoggedIn()) setCookie('1', COOKIE_DAYS)
}

export function adminLogout() {
  deleteCookie()
}
