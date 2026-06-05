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
- `ChapterSelect.jsx` — 챕터 목록, 완료 여부 + 순차 잠금(이전 챕터 완료 시 해금, 어드민 전체 해금)
- `StoryPage.jsx` — 스토리 렌더링, BGM/SFX, 캐릭터 최대 4명, 경로 기준 진행도
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

## Story Content & Progression

### 컨셉
- 플레이어는 성경 사건을 곁에서 지켜보는 **이름 없는 관찰자**. 선택은 성경의 결과를 바꾸지 않고 *나의 위치/마음/반응*만 바꾼다. 분기는 갈라졌다가 성경 고정점(anchor)에서 재합류.
- 챕터마다 분기 6곳 + 엔딩 3개(믿음/따름/씨앗 계열). 엔딩은 `choices.next_scene_id = NULL`로 챕터 완료 처리.
- 챕터당 약 28~30씬, 모든 본문/선택지는 DB에 저장 (하드코딩 없음).

### 순차 해금 (`ChapterSelect.jsx`)
- 첫 챕터만 열린 상태로 시작. `completedChapters`(localStorage)에 직전 챕터가 있으면 다음 챕터 해금.
- `isAdminLoggedIn()`이면 전체 해금(테스트용). 잠긴 챕터는 클릭 비활성 + 🔒 + 흐림.
- 챕터 정렬은 `chapter_num` 기준, 해금 판정은 정렬된 직전 챕터의 완료 여부.

### 경로 기준 진행도 (`StoryPage.jsx`)
- 전체 씬 인덱스가 아니라 **경로 기준**: `path.length / (path.length + 현재 씬에서 엔딩까지 남은 최장 경로)`.
- `remainingFrom()`이 choices 그래프를 DFS(순환 방어)로 최장 경로 계산 → 분기를 타도 단조 증가, 엔딩에서 N/N.

### 챕터 확장 마이그레이션 (`015`~`025`)
- 챕터 1~11 확장본. `chapter_num`으로 기존 씬/선택지를 비우고 재삽입.
- RLS 비활성이라 anon 키 REST API(`POST/DELETE /rest/v1/scenes|choices`)로도 동일 적용 가능. 선택지는 `(chapter_id, scene_order)`로 대상 씬을 참조해 연결.

## Database Schema

```sql
chapters       (id, chapter_num, title, description)   -- 주의: chapter_num=1 → id=2 (1 오프셋), 조회는 chapter_num 사용
scenes         (id, chapter_id, scene_order, text, speaker, character, character2, character3, character4, background, bgm_url, bgm_transition)
choices        (id, scene_id, label, next_scene_id, choice_order)   -- next_scene_id=NULL 이면 챕터 완료
image_assets   (id, name, category, file_path, public_url, created_at)  -- category: backgrounds | characters | ui
teams          (id, name, created_at)
player_sessions(id, player_name, nickname, team_id, chapter_num, completed_at)
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
4. scenes.bgm_url, background, character 매핑

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
