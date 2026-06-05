# Bible Quest 개발 진행 현황

> 마지막 업데이트: 2026-06-05

## 완료된 기능

### 스토리 시스템
- **챕터 1~11 전면 확장** — 각 챕터 6씬 → 약 28~30씬 (총 300씬 이상)
- **이름 없는 관찰자 컨셉** — 플레이어는 성경 사건을 곁에서 지켜보는 이름 없는 한 사람. 선택은 성경의 결과를 바꾸지 않고 나의 위치/마음/반응만 바꾼다.
- **챕터당 분기 6곳 + 엔딩 3개** — 분기는 갈라졌다가 성경의 고정점(anchor)에서 재합류, 마지막에 3가지 엔딩(믿음 / 따름 / 씨앗 계열)으로 갈림
- **경로 기준 진행도** — 전체 씬 인덱스가 아니라 실제 방문한 씬 수 기준으로 n/N 표시 (분기를 타도 단조 증가, 엔딩에서 N/N)
- 타이핑 애니메이션 (스킵 클릭, 첫 씬 즉시 시작)
- 캐릭터 최대 4명, 화면 중앙 배치, 라운드(border-radius 1.5rem) + 엣지 페이드(mask-image)
- 캐릭터 수에 따른 자동 크기 조정 (1:w-64/w-96 ~ 4:w-24/w-36)

### 챕터별 관찰자 시점 / 본문
| # | 제목 | 본문 | 시점 |
|---|------|------|------|
| 1 | 갈릴리의 부름 | 마 4 / 눅 5 | 베드로의 어린 조수 |
| 2 | 광야의 시험 | 마 4 | 광야의 어린 목동 |
| 3 | 산상수훈 | 마 5–7 | 군중 속 한 사람 |
| 4 | 풍랑을 잠재우심 | 막 4 | 배에 탄 어린 일꾼 |
| 5 | 오병이어의 기적 | 요 6 | 도시락을 가진 소년 |
| 6 | 물 위를 걸으심 | 마 14 | 배에서 지켜보는 일꾼 |
| 7 | 선한 사마리아인 | 눅 10 | 여리고 길의 나그네 |
| 8 | 탕자의 귀환 | 눅 15 | 아버지 집의 종 |
| 9 | 나사로를 살리심 | 요 11 | 베다니 마을의 벗 |
| 10 | 최후의 만찬 | 눅 22 | 다락방을 준비한 사람 |
| 11 | 겟세마네 기도 | 마 26 | 동산의 불침번 경비 |

### 진행/잠금
- **순차 해금** — 첫 챕터만 열린 상태로 시작, 이전 챕터를 완료해야 다음 챕터가 해금됨 (`ChapterSelect.jsx`)
- 어드민 쿠키가 있으면 전체 챕터 해금 (테스트용)
- 잠긴 챕터: 클릭 비활성 + 🔒 배지 + 흐림 처리
- 챕터 완료 → 다음 챕터 자동 진행 (`handleContinueToNext`, 11챕터에서 안전하게 종료)

### BGM/효과음
- 타이틀: Marimba Meadow (TAP TO START 후 재생)
- 챕터별 3종 BGM 배치 (잔잔함 → 긴장 → 여운 아크)
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

### 팀 관리 (어드민)
- 팀 추가/삭제 CRUD (teams 테이블)

### 이미지/미디어
- 배경/캐릭터/BGM 업로드 및 챕터별 씬 매핑
- 어드민 미디어 관리 (업로드/싱크/미리보기)

---

## DB 구조

| 테이블 | 주요 컬럼 |
|--------|-----------|
| `chapters` | id, chapter_num, title, description |
| `scenes` | id, chapter_id, scene_order, text, speaker, character, character2~4, background, bgm_url, bgm_transition |
| `choices` | id, scene_id, label, next_scene_id, choice_order |
| `image_assets` | id, name, category(backgrounds/characters/ui), file_path, public_url |
| `teams` | id, name, created_at |
| `player_sessions` | id, player_name, nickname, team_id, chapter_num, completed_at |

> 참고: `chapters.id`는 `chapter_num`과 1 차이가 있음 (chapter_num=1 → id=2). 마이그레이션/스크립트에서는 `chapter_num`으로 조회 권장.

---

## 마이그레이션 이력 (주요)

| 파일 | 내용 |
|------|------|
| `006_chapter1_scenario.sql` | (구) 1챕터 시나리오 |
| `010_chapters_2_to_11.sql` | (구) 챕터 2~11 |
| `013_player_progress.sql` | player_sessions 테이블 |
| `014_teams.sql` | teams 테이블 |
| `015_chapter1_expansion.sql` | 1챕터 확장 (23씬, 분기 6, 엔딩 3) |
| `016_chapter2_expansion.sql` | 2챕터 확장 (26씬) |
| `017_chapter3_expansion.sql` | 3챕터 확장 (30씬) |
| `018_chapter4_expansion.sql` | 4챕터 확장 (28씬) |
| `019_chapter5_expansion.sql` | 5챕터 확장 (29씬) |
| `020_chapter6_expansion.sql` | 6챕터 확장 (30씬) |
| `021_chapter7_expansion.sql` | 7챕터 확장 (30씬) |
| `022_chapter8_expansion.sql` | 8챕터 확장 (28씬) |
| `023_chapter9_expansion.sql` | 9챕터 확장 (30씬) |
| `024_chapter10_expansion.sql` | 10챕터 확장 (30씬) |
| `025_chapter11_expansion.sql` | 11챕터 확장 (30씬) |

> 확장 마이그레이션은 `chapter_num` 기준으로 기존 씬/선택지를 비우고 재삽입한다. RLS 비활성 상태이므로 anon 키 REST API로도 동일 적용 가능.

---

## 환경

- **Vercel**: main 브랜치 push 시 자동 배포
- **Supabase 프로젝트**: `elqomxaemqiqalzhczfc`
- **환경변수**: `VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY`

---

## 알려진 버그 수정 이력

| 버그 | 해결 |
|------|------|
| 진행도가 분기에서 튐 | 전체 씬 인덱스 → 경로 기준(방문 씬 / 남은 최장 경로) |
| 11챕터 완료 후 12챕터 로드 시도 | `handleContinueToNext` 상한 12 → 11 |
| 캐릭터 이미지 category 오분류 | SQL UPDATE로 category='characters' 수정 |
| 챕터 완료 목록 미반영 | `chapter.id` → `chapter.chapter_num` 비교 |
| 완료 후 새로고침 필요 | `setGameState` 즉시 업데이트 추가 |
| 음소거 후 곡 재시작 시 해제됨 | `volumeRef` 패턴으로 stale closure 해결 |
| BGM 같은 URL 씬 전환 시 재시작 | `bgmUrlRef`로 URL 비교 |
| ChapterSelect 호버 스크롤 | scale 1.02 + overflow-hidden |
