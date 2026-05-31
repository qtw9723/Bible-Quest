# Bible Quest - 신앙 성장 RPG

신약 성경의 주요 사건을 배경으로 한 스토리 리딩 웹 RPG입니다.

## 프로젝트 개요

- **타깃**: 교회 대학부, 성경에 익숙하지 않은 사람들
- **핵심**: 텍스트 기반 스토리 + 선택지를 통해 신약 성경 내용 체험
- **구조**: 11개 챕터, 선택지 기반 분기 스토리, 팀 기반 진행 관리

## 기술 스택

- **프론트**: Vite + React 19 + Tailwind CSS v4 + Framer Motion
- **백엔드**: Supabase (PostgreSQL + Storage)
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
│   │   ├── ChapterSelect.jsx      # 챕터 목록 + 진행도
│   │   ├── StoryPage.jsx          # 스토리 화면 (BGM, 캐릭터, 선택지)
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
│   └── migrations/                # DB 마이그레이션 파일
├── index.html
├── package.json
└── vite.config.js
```

## 화면 목록

1. **타이틀 화면** - 이름 + 팀 선택 로그인
2. **챕터 선택** - 전체 챕터 목록 + 완료 여부 표시
3. **스토리 화면** - 메인 게임 (텍스트 타이핑 + 캐릭터 + 선택지 + BGM)
4. **챕터 완료** - 완료 메시지 + 다음 챕터 이동
5. **어드민 패널** - 대시보드, 팀 관리, 스토리/미디어 관리

## 챕터 목록

| 챕터 | 제목 | 성경 사건 |
|------|------|-----------|
| 1 | 갈릴리의 부름 | 제자들을 부르심 |
| 2 | 광야의 시험 | 예수님의 시험 |
| 3 | 산상수훈 | 팔복 말씀 |
| 4 | 오병이어의 기적 | 5000명을 먹이심 |
| 5 | 풍랑을 잠재우시다 | 바다 위를 걸으심 |
| 6 | 선한 사마리아인 | 이웃 사랑의 비유 |
| 7 | 탕자의 귀환 | 아버지의 용서 |
| 8 | 나사로를 살리시다 | 부활의 기적 |
| 9 | 예루살렘 입성 | 종려주일 |
| 10 | 최후의 만찬 | 성만찬 제정 |
| 11 | 부활의 아침 | 빈 무덤 |

## 주요 기능

- [x] 11개 챕터 스토리 (신약 주요 사건)
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
