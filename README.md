# Bible Quest - 신앙 성장 RPG

신약 성경의 주요 사건을, **그 곁에서 지켜보던 이름 없는 한 사람**의 시점으로 체험하는 스토리 리딩 웹 RPG입니다.

## 프로젝트 개요

- **타깃**: 교회 대학부, 성경에 익숙하지 않은 사람들
- **핵심 컨셉**: 성경 사건의 결과는 성경 그대로 두되, 플레이어는 그 사건을 곁에서 지켜보는 **이름 없는 관찰자**로 참여합니다. 선택은 성경의 흐름을 바꾸지 않고, 오직 *나의 위치·마음·반응*만을 바꿉니다.
- **구조**: 11개 챕터 · 챕터마다 6개의 분기점과 3개의 엔딩 · 순차 해금 진행 · 팀 기반 진행 관리

## 기술 스택

- **프론트**: Vite + React 19 + Tailwind CSS v4 + Framer Motion
- **백엔드**: Supabase (PostgreSQL + Storage), REST API 직접 호출 (SDK 미사용)
- **배포**: Vercel (main 브랜치 자동 배포)
- **인증**: 팀 선택 기반 로그인 + 어드민 쿠키 인증

## 설치 및 실행

```bash
# 의존성 설치
npm install

# 개발 서버 실행
npm run dev

# 프로덕션 빌드
npm run build
```

## 환경 변수

`.env` 파일을 생성하고 다음을 설정하세요:

```
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
```

## 프로젝트 구조

```
Bible-Quest/
├── src/
│   ├── components/
│   │   ├── TitlePage.jsx          # 로그인 (이름 + 팀 선택)
│   │   ├── ChapterSelect.jsx      # 챕터 목록 + 진행도 + 순차 잠금
│   │   ├── StoryPage.jsx          # 스토리 화면 (BGM, 캐릭터, 선택지, 경로 기준 진행도)
│   │   ├── ChapterComplete.jsx    # 챕터 완료 화면
│   │   ├── GlobalMenu.jsx         # 전역 사이드바 메뉴
│   │   └── admin/
│   │       ├── Dashboard.jsx      # 어드민 대시보드
│   │       ├── TeamManager.jsx    # 팀 관리
│   │       ├── StoryManager.jsx   # 스토리 관리
│   │       └── MediaManager.jsx   # 미디어 관리
│   ├── lib/
│   │   ├── api.js                 # Supabase REST API 함수
│   │   ├── adminAuth.js           # 어드민 쿠키 인증
│   │   └── gameState.js           # localStorage 진행도 관리
│   ├── App.jsx                    # 라우팅, 메인 BGM, 볼륨 관리
│   └── main.jsx
├── public/
│   └── favicon.png
├── supabase/
│   └── migrations/                # DB 마이그레이션 파일 (002 ~ 025)
├── index.html
├── package.json
└── vite.config.js
```

## 화면 목록

1. **타이틀 화면** - 이름 + 팀 선택 로그인
2. **챕터 선택** - 전체 챕터 목록 + 완료 여부 + **순차 잠금**(이전 챕터 완료 시 다음 챕터 해금)
3. **스토리 화면** - 메인 게임 (텍스트 타이핑 + 캐릭터 + 선택지 분기 + BGM + 경로 기준 진행도)
4. **챕터 완료** - 완료 메시지 + 다음 챕터 이동
5. **어드민 패널** - 대시보드, 팀 관리, 스토리/미디어 관리

## 챕터 목록

각 챕터는 6씬 → **약 28~30씬**으로 확장되었으며, 6개의 분기점과 3개의 엔딩(믿음 / 따름 / 씨앗 계열)을 가집니다.

| 챕터 | 제목 | 성경 본문 | 관찰자 시점 |
|------|------|-----------|-------------|
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

## 주요 기능

- [x] 11개 챕터 스토리 (신약 주요 사건, 이름 없는 관찰자 시점)
- [x] 챕터당 6개 분기점 + 3개 엔딩 (선택에 따른 분기/재합류)
- [x] **순차 해금** — 이전 챕터를 완료해야 다음 챕터 시작 가능 (어드민은 전체 해금)
- [x] **경로 기준 진행도** — 실제로 지나온 씬 기준으로 n/N 표시
- [x] 타이핑 애니메이션 + 선택지 분기
- [x] 캐릭터 최대 4명 동시 표시
- [x] BGM 시스템 (씬 전환 시 동일 BGM 유지)
- [x] 효과음 (타이핑, 호버, 클릭, 스킵)
- [x] 전역 볼륨 조절 + 음소거
- [x] 팀 기반 로그인 시스템
- [x] 어드민 대시보드 (팀별/사용자별 현황)
- [x] 쿠키 기반 어드민 인증 (7일 슬라이딩)
- [x] Vercel 자동 배포

## 중요 링크

- **배포 URL**: https://bible-quest-nine.vercel.app
- **GitHub**: https://github.com/qtw9723/Bible-Quest
- **Supabase**: https://supabase.com/dashboard (프로젝트: elqomxaemqiqalzhczfc)
- **어드민**: https://bible-quest-nine.vercel.app/admin

## 라이선스

MIT
