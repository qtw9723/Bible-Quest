# Bible Quest - 신앙 성장 RPG

신약 성경의 스토리를 기반으로 한 스토리 리딩 위주의 웹 RPG입니다.

## 프로젝트 개요

- **타깃**: 교회 대학부, 성경에 익숙하지 않은 사람들
- **핵심**: 텍스트 기반 스토리를 통해 자연스럽게 신약 성경 내용 습득
- **구조**: 12개 챕터, 선택지 기반 분기 스토리

## 기술 스택

- **프론트**: Vite + React 19 + Tailwind CSS
- **백엔드**: Supabase (PostgreSQL + Edge Functions)
- **배포**: Vercel
- **인증**: Supabase Auth

## 설치 및 실행

```bash
# 의존성 설치
npm install

# 개발 서버 실행
npm run dev

# 프로덕션 빌드
npm run build
```

## 프로젝트 구조

```
Bible-Quest/
├── src/
│   ├── components/        # React 컴포넌트
│   │   ├── TitlePage.jsx
│   │   ├── ChapterSelect.jsx
│   │   ├── StoryPage.jsx
│   │   └── ChapterComplete.jsx
│   ├── lib/               # 유틸리티 함수
│   │   ├── gameState.js   # 로컬스토리지 기반 상태 관리
│   │   └── api.js         # Supabase API
│   ├── App.jsx
│   ├── main.jsx
│   ├── index.css
│   └── App.css
├── supabase/
│   ├── migrations/        # DB 마이그레이션
│   └── functions/         # Edge Functions
├── public/
├── index.html
├── package.json
├── vite.config.js
└── .env.example
```

## 화면 목록

1. **타이틀 화면** - 게임 시작/이어하기
2. **챕터 선택** - 전체 챕터 목록 + 진행도
3. **스토리 화면** - 메인 게임 (텍스트 + 선택지)
4. **챕터 완료** - 완료 메시지 + 성경 구절

## 환경 변수

`.env` 파일을 생성하고 다음을 설정하세요:

```
VITE_SUPABASE_URL=your_supabase_url
VITE_SUPABASE_ANON_KEY=your_supabase_anon_key
```

## 스토리 데이터 구조

```json
{
  "chapter": 1,
  "title": "갈릴리의 부름",
  "scenes": [
    {
      "background": "galilee.jpg",
      "character": "peter.png",
      "text": "예수께서 갈릴리 해변을 지나가시다가...",
      "choices": null,
      "next": 2
    }
  ]
}
```

## 주요 기능 (예정)

- [x] 기본 UI 레이아웃
- [ ] Supabase 마이그레이션 (chapters, scenes, players 테이블)
- [ ] Supabase Edge Functions (진행도 저장)
- [ ] 이미지 에셋 통합
- [ ] 사용자 인증
- [ ] 멀티엔딩 구현
- [ ] 성능 최적화

## 라이선스

MIT
