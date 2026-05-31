# Bible Quest - 개발 로드맵

> 마지막 업데이트: 2026-06-01

---

## ✅ 완료된 작업

### Phase 1: 기초 구조
- [x] Vite + React 19 + Tailwind CSS v4 프로젝트 설정
- [x] Supabase 연동 (PostgreSQL REST API)
- [x] TitlePage / ChapterSelect / StoryPage / ChapterComplete 구현
- [x] Framer Motion 애니메이션 통합
- [x] Vercel 배포 + vercel.json SPA 라우팅

### Phase 2: 스토리 콘텐츠
- [x] Chapter 1: 갈릴리의 부름
- [x] Chapter 2: 광야의 시험
- [x] Chapter 3: 산상수훈
- [x] Chapter 4: 오병이어의 기적
- [x] Chapter 5: 풍랑을 잠재우시다
- [x] Chapter 6: 선한 사마리아인
- [x] Chapter 7: 탕자의 귀환
- [x] Chapter 8: 나사로를 살리시다
- [x] Chapter 9: 예루살렘 입성
- [x] Chapter 10: 최후의 만찬
- [x] Chapter 11: 부활의 아침

### Phase 3: 이미지/미디어 에셋
- [x] 배경 이미지 11개 생성 및 Supabase Storage 업로드
- [x] 캐릭터 이미지 7개 생성 및 업로드
- [x] 챕터별 씬 배경/캐릭터/BGM URL 매핑
- [x] 파비콘 적용 (골든 성경책 아이콘)

### Phase 4: BGM/효과음
- [x] 메인 BGM: Marimba Meadow (타이틀/선택/완료 화면 공유)
- [x] 스토리 BGM: Morning Calm / Throne of Dawn / Falling Snowfield
- [x] 동일 BGM 씬 전환 시 끊기지 않음 (bgmUrlRef)
- [x] 곡 종료 시 페이드인 재시작
- [x] 효과음: 타이핑 / 호버 / 클릭 / 스킵 (Web Audio API)
- [x] 전역 볼륨 조절 + 음소거 (volumeRef stale closure 수정)

### Phase 5: UI/UX 개선
- [x] 캐릭터 최대 4명, 라운드 + 엣지 페이드, 중앙 배치
- [x] GlobalMenu: 전 화면 우상단 고정, 화면별 버튼 구성
- [x] 타이핑 즉시 시작 (씬 전환 시 1초 딜레이)
- [x] ChapterSelect 호버 스크롤 버그 수정

### Phase 6: 팀/로그인 시스템
- [x] 이름 + 팀 선택 필수 로그인
- [x] teams 테이블 + 어드민 팀 CRUD
- [x] player_sessions 테이블 (챕터 완료 기록)
- [x] 챕터 완료 즉시 React state 반영

### Phase 7: 어드민 패널
- [x] 쿠키 기반 어드민 로그인 (7일 슬라이딩 만료)
- [x] 대시보드: 총 플레이어 / 완료 횟수 / 팀별 / 사용자별 현황
- [x] 챕터별 완료 수 바차트 + 최근 활동 피드
- [x] 스킵 버튼 어드민 전용 (쿠키 있을 때만 표시)

---

## 🔄 진행 중 / 확인 필요

- [ ] 대시보드 데이터 실사용 검증 (팀 등록 후 플레이어 데이터 쌓이는지 확인)
- [ ] 챕터별 BGM 매핑 최종 확인

---

## 📋 예정된 작업

### 콘텐츠 보완
- [ ] 각 챕터 완료 시 표시되는 성경 구절 추가
- [ ] 챕터별 엔딩 분기 (선택에 따른 2가지 엔딩)

### 기능 확장
- [ ] 진행도 요약 화면 (완료한 챕터 / 선택 통계)
- [ ] 챕터 완료 시 공유 기능 (카카오톡 등)
- [ ] 모바일 전체화면 최적화

### 성능 최적화
- [ ] 이미지 lazy loading / WebP 변환
- [ ] 코드 스플리팅
- [ ] 번들 크기 최적화

### 어드민 고도화
- [ ] 어드민에서 씬별 데이터 직접 편집
- [ ] 팀별 진행 현황 상세 뷰

---

## 📊 진행률

| Phase | 상태 | 진행률 |
|-------|------|--------|
| 기초 구조 | ✅ 완료 | 100% |
| 스토리 콘텐츠 (11챕터) | ✅ 완료 | 100% |
| 이미지/미디어 에셋 | ✅ 완료 | 100% |
| BGM/효과음 | ✅ 완료 | 100% |
| UI/UX 개선 | ✅ 완료 | 100% |
| 팀/로그인 시스템 | ✅ 완료 | 100% |
| 어드민 패널 | ✅ 완료 | 100% |
| 콘텐츠 보완 | ⏳ 예정 | 0% |
| 기능 확장 | ⏳ 예정 | 0% |
| 성능 최적화 | ⏳ 예정 | 0% |

**전체 진행률: ~85%**

---

## 🔗 중요 링크

- **배포 URL**: https://bible-quest-nine.vercel.app
- **GitHub**: https://github.com/qtw9723/Bible-Quest
- **Supabase**: https://supabase.com/dashboard (프로젝트: elqomxaemqiqalzhczfc)
- **어드민**: https://bible-quest-nine.vercel.app/admin
