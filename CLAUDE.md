# Bible Quest - Development Guide

> Claude Code 작업용 개발 가이드

## Project Overview

신약 성경의 주요 사건을 배경으로 한 스토리 리딩 RPG 웹앱.

- **Frontend**: Vite + React 19 + Tailwind CSS v4 + Framer Motion
- **Backend**: Supabase PostgreSQL + Storage (REST API, SDK 미사용)
- **Deployment**: Vercel (main 브랜치 자동 배포)
- **Supabase Project**: `elqomxaemqiqalzhczfc`

## Architecture

### Frontend Structure
- `App.jsx` — 화면 라우팅, 메인 BGM 관리, 전역 볼륨 (volumeRef)
- `TitlePage.jsx` — 이름 + 팀 선택 필수 로그인
- `ChapterSelect.jsx` — 챕터 목록, 완료 여부 표시
- `StoryPage.jsx` — 스토리 렌더링, BGM/SFX, 캐릭터 최대 4명
- `ChapterComplete.jsx` — 완료 화면
- `GlobalMenu.jsx` — 전 화면 우상단 고정 메뉴 (볼륨, 이동, 스킵)
- `AdminPanel.jsx` — 어드민 진입점 (쿠키 인증)
- `admin/Dashboard.jsx` — 팀별/사용자별 통계
- `admin/TeamManager.jsx` — 팀 CRUD

### State Management
- `gameState.js` — localStorage (nickname, teamId, teamName, completedChapters, lastChapter)
- `adminAuth.js` — 쿠키 기반 어드민 인증 (7일 슬라이딩)
- React state (`App.jsx`) — 현재 화면, 볼륨, gameState 동기화

### Audio System
- **메인 BGM**: `App.jsx`의 `mainAudioRef` (타이틀/챕터선택/완료 화면)
- **스토리 BGM**: `StoryPage.jsx`의 내부 audioRef (`externalAudioRef`로 App에 공유)
- **bgmUrlRef**: 씬 전환 시 동일 BGM 비교 (브라우저가 src를 절대경로로 변환하므로 ref 필요)
- **volumeRef**: stale closure 방지 (setInterval/ended 이벤트에서 사용)
- **SFX**: Web Audio API (타이핑=화이트노이즈+밴드패스, 호버=520Hz, 클릭=660+880Hz, 스킵=400→320Hz)

### Character Display
- 최대 4명, CSS `mask-image`로 엣지 페이드, `border-radius: 1.5rem`
- 인원수별 width: `{ 1: 'w-64 sm:w-96', 2: 'w-36 sm:w-52', 3: 'w-28 sm:w-40', 4: 'w-24 sm:w-36' }`
- 위치: top 8% ~ bottom 36% 중앙 배치

### Admin Auth
- 쿠키명: `bq_admin_auth`, 값: `'1'`, 7일 만료, SameSite=Strict
- `isAdminLoggedIn()` — GlobalMenu 스킵 버튼 표시 여부
- `refreshAdminSession()` — AdminPanel 진입 시 만료일 갱신

## Database Schema

```sql
chapters       (id, chapter_num, title, description)
scenes         (id, chapter_id, scene_num, text, speaker, character, character2, character3, character4, background_url, character_url, bgm_url, next_scene_id)
choices        (id, scene_id, label, next_scene_id, order_num)
image_assets   (id, name, url, category)  -- category: backgrounds | characters | bgm
teams          (id, name, created_at)
player_sessions(id, player_name, team_id, chapter_num, completed_at)
```

## API Functions (`src/lib/api.js`)

- `getStoryData(chapterNum)` — 챕터 전체 데이터 (scenes + choices)
- `getTeams()` — 팀 목록
- `createTeam(name)` / `deleteTeam(id)` — 팀 CRUD
- `recordChapterComplete(playerName, chapterNum, teamId)` — 완료 기록 (중복 무시)
- `getDashboardStats()` — 대시보드 통계 집계

## Development Workflow

### Deploy
```bash
git add .
git commit -m "feat: ..."
git push  # Vercel 자동 배포
```

### Add New Chapter
1. `supabase/migrations/` 에 SQL 작성
2. Supabase Dashboard SQL Editor에서 실행
3. image_assets에 배경/캐릭터/BGM URL 등록
4. scenes.bgm_url, background_url, character_url 매핑

### Admin Access
- URL: `/admin`
- 비밀번호: 환경변수 또는 직접 입력 (쿠키 저장 후 7일 유지)

## Environment Variables

```
VITE_SUPABASE_URL=https://elqomxaemqiqalzhczfc.supabase.co
VITE_SUPABASE_ANON_KEY=eyJxxxxx
```

## Important Patterns

### volumeRef (stale closure 방지)
```js
const volumeRef = useRef(0.7)
// volume state 변경 시 반드시 volumeRef도 동기화
const handleVolumeChange = (v) => { setVolume(v); volumeRef.current = v }
// audio ended / setInterval 에서는 volumeRef.current 사용
```

### bgmUrlRef (동일 BGM 유지)
```js
const bgmUrlRef = useRef('')
// 씬 전환 시 URL 비교 — audio.src는 브라우저가 절대경로로 변환하므로 ref로 원본 보관
if (bgmUrlRef.current === newUrl) return  // 동일 BGM이면 재시작 안 함
```

### externalAudioRef (볼륨 동기화)
```js
// App.jsx에서 storyAudioRef를 StoryPage에 전달
<StoryPage audioRef={storyAudioRef} />
// handleVolumeChange에서 storyAudioRef.current.volume = v 로 동기화
```
