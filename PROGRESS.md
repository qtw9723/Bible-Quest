# Bible Quest 개발 진행 현황

> 마지막 업데이트: 2026-05-30

## 완료된 기능

### 스토리 시스템
- 챕터 1~11 시나리오 (신약 10개 사건)
- 타이핑 애니메이션 (스킵 클릭, 첫 씬 즉시 시작)
- 씬 전환 시 1초 딜레이 후 타이핑 시작 (페이더와 겹침 방지)
- 분기 선택지 (2개 분기)
- 캐릭터 최대 4명, 화면 중앙 배치, 라운드(border-radius 1.5rem) + 엣지 페이드(mask-image)
- 캐릭터 수에 따른 자동 크기 조정 (1:w-64/w-96 ~ 4:w-24/w-36)

### BGM/효과음
- 타이틀: Marimba Meadow (TAP TO START 후 재생)
- 챕터별 3종 BGM 배치 (Morning/Throne/Snowfield)
- 동일 BGM 씬 전환 시 끊기지 않음 (bgmUrlRef 비교)
- 곡 종료 시 페이드인 재시작
- 챕터 완료/선택 화면: 타이틀 BGM 유지
- 효과음: 타이핑(양피지 화이트노이즈), 호버(틱 520Hz), 클릭(딩동 660+880Hz), 스킵(슥 400→320Hz)
- 볼륨 조절 (전역, volumeRef 패턴으로 음소거 stale closure 버그 수정)
- externalAudioRef로 스토리 BGM 볼륨 App.jsx에서 동기화

### UI/UX
- GlobalMenu: 모든 화면 우상단 고정 (z-[100])
- 사이드바 버튼 구성: 타이틀(볼륨만), 선택(홈+볼륨), 스토리/완료(홈+챕터선택+볼륨)
- 볼륨 슬라이더 + 음소거 토글
- 챕터 완료 스킵 버튼 (어드민 쿠키 있을 때만 표시)
- ChapterSelect 호버 시 스크롤 버그 수정 (scale 1.02 + overflow-hidden)
- 챕터 완료 즉시 React state 반영 (새로고침 없이 완료 표시)

### 로그인/팀
- 이름 + 팀 선택 필수 로그인 (둘 다 없으면 버튼 비활성화)
- "다른 계정으로 시작" → localStorage 초기화
- 팀 목록 Supabase에서 실시간 fetch
- gameState: nickname, teamId, teamName, completedChapters, lastChapter

### 어드민 패널 (`/admin`)
- 쿠키 기반 로그인 (7일 슬라이딩 만료, SameSite=Strict)
- 탭: 📊대시보드 / 👥팀관리 / 📖스토리관리 / 🖼️미디어관리
- 로그아웃 버튼 (LogOut 아이콘)
- `refreshAdminSession()` - 접속 시마다 만료일 갱신

### 대시보드 (어드민)
- player_sessions 테이블로 챕터 완료 기록
- 통계 카드: 총 플레이어 / 총 완료 횟수 / 팀 수 / 평균 완료
- 탭: 전체현황(챕터별 바차트 + 최근활동) / 팀별 / 사용자별
- 팀별 완료 횟수, 평균 챕터, 플레이어 수

### 팀 관리 (어드민)
- 팀 추가/삭제 CRUD
- teams 테이블 (id, name)

### 이미지/미디어
- 11개 배경, 7개 캐릭터 업로드 및 챕터별 씬 매핑
- 어드민 미디어 관리 (업로드/싱크/미리보기)

---

## DB 구조

| 테이블 | 설명 |
|--------|------|
| `chapters` | 챕터 번호, 제목 |
| `scenes` | 씬 텍스트, 화자, 배경/캐릭터/BGM URL |
| `choices` | 선택지 텍스트, 다음 씬 |
| `image_assets` | 이미지/BGM URL, category(backgrounds/characters/bgm) |
| `teams` | 팀 id, name |
| `player_sessions` | player_name, team_id, chapter_num, completed_at |

---

## 주요 파일

| 파일 | 역할 |
|------|------|
| `src/App.jsx` | 메인 BGM, 볼륨 관리, 화면 라우팅 |
| `src/components/StoryPage.jsx` | 스토리 렌더링, BGM/SFX, 캐릭터 |
| `src/components/GlobalMenu.jsx` | 전역 메뉴 (모든 화면) |
| `src/components/TitlePage.jsx` | 로그인 (이름+팀) |
| `src/components/ChapterSelect.jsx` | 챕터 목록 |
| `src/components/AdminPanel.jsx` | 어드민 진입점 |
| `src/components/admin/Dashboard.jsx` | 대시보드 UI |
| `src/components/admin/TeamManager.jsx` | 팀 CRUD |
| `src/lib/api.js` | Supabase REST API 함수 |
| `src/lib/adminAuth.js` | 어드민 쿠키 인증 |
| `src/lib/gameState.js` | 로컬스토리지 진행도 |

---

## 마이그레이션 이력

| 파일 | 내용 |
|------|------|
| `008_multi_characters.sql` | character2~4 컬럼 추가 |
| `010_chapters_2_to_11.sql` | 챕터 2~11, 60씬, 70선택지 |
| `011_chapters_2_11_assets.sql` | 배경/캐릭터/BGM 씬 매핑 |
| `012_update_bgm_urls.sql` | BGM URL 교체 (35씬) |
| `013_player_progress.sql` | player_sessions 테이블 |
| `014_teams.sql` | teams 테이블, player_sessions에 team_id/player_name |

---

## 환경

- **Vercel**: main 브랜치 push 시 자동 배포
- **Supabase 프로젝트**: `elqomxaemqiqalzhczfc`
- **환경변수**: `VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY`

---

## 알려진 버그 수정 이력

| 버그 | 해결 |
|------|------|
| 캐릭터 이미지 category 오분류 | SQL UPDATE로 category='characters' 수정 |
| 챕터 완료 목록 미반영 | `chapter.id` → `chapter.chapter_num` 비교 |
| 완료 후 새로고침 필요 | `setGameState` 즉시 업데이트 추가 |
| 음소거 후 곡 재시작 시 해제됨 | `volumeRef` 패턴으로 stale closure 해결 |
| BGM 같은 URL 씬 전환 시 재시작 | `bgmUrlRef`로 URL 비교 |
| ChapterSelect 호버 스크롤 | scale 1.02 + overflow-hidden |
| 대시보드 데이터 없음 | 팀 시스템 연동으로 recordChapterComplete 정상 호출 |
| migration 013 충돌 | player_sessions 테이블로 대체, repair --status reverted |
