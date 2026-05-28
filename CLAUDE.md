# Bible Quest - Development Guide

## Project Overview

신약 성경의 스토리를 기반으로 한 스토리 리딩 RPG 웹앱.

- **Frontend**: Vite + React 19 + Tailwind CSS
- **Backend**: Supabase (PostgreSQL + Edge Functions)
- **Deployment**: Vercel
- **Target**: University students, non-religious background people

## Architecture

### Frontend Structure
- Components: 타이틀, 챕터 선택, 스토리, 완료 화면
- State Management: React hooks + localStorage (초기), 나중에 Supabase로 이동 예정
- Styling: Tailwind CSS

### Backend Structure
- Database: Supabase PostgreSQL
  - chapters, scenes, choices (스토리 데이터)
  - players, player_progress (진행도)
- Edge Functions: 진행도 저장, 데이터 조회 등

### Data Flow
1. 사용자 닉네임 입력 (localStorage 저장)
2. 챕터 선택 후 스토리 페이지로
3. 선택지 선택 시 다음 장면으로
4. 챕터 완료 시 progress 저장 (Supabase)
5. 다음 챕터 or 챕터 목록으로 이동

## Development Workflow

### Add New Chapter
1. `supabase/migrations/` - 데이터 마이그레이션 (필요시)
2. Supabase에 chapter, scenes, choices 데이터 삽입
3. `src/components/StoryPage.jsx` - 스토리 데이터 통합
4. 테스트

### Add New Feature
1. 요구사항 확인
2. Component or API 함수 작성
3. 테스트 및 배포

### Deploy
- Vercel: 자동 배포 (main branch push)
- Environment variables: `.env` 파일로 설정

## Important Notes

- localStorage 사용으로 초기 프로토타입 빠르게 개발
- 이후 Supabase 마이그레이션으로 cross-device 지원
- 에셋(이미지)는 외부 AI 도구로 제작 후 import
- GitHub Pages 호환 구조 (GitHub 퍼블리싱 가능)

## Environment Variables

```
VITE_SUPABASE_URL=https://xxxxx.supabase.co
VITE_SUPABASE_ANON_KEY=eyJxxxxx
```

## Story Data Structure

```json
{
  "chapter": 1,
  "title": "갈릴리의 부름",
  "scenes": [
    {
      "background": "galilee.jpg",
      "character": "peter.png",
      "text": "예수께서 갈릴리 해변을...",
      "choices": [
        { "label": "따라간다", "next": 2 }
      ]
    }
  ]
}
```

## Next Steps

- [ ] Supabase 초기 설정 (프로젝트 생성)
- [ ] 스토리 콘텐츠 작성 (12개 챕터)
- [ ] 이미지 에셋 생성 및 통합
- [ ] Supabase RLS 정책 최적화
- [ ] 사용자 인증 추가
- [ ] 멀티엔딩 기능 구현
- [ ] 성능 최적화 (이미지 lazy loading 등)
- [ ] GitHub 리포지토리 설정 및 배포
