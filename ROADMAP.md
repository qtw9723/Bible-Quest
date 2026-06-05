# Bible Quest - 개발 로드맵

> 마지막 업데이트: 2026-06-05

---

## ✅ 완료된 작업

### Phase 1: 기초 구조
- [x] Vite + React 19 + Tailwind CSS v4 프로젝트 설정
- [x] Supabase 연동 (PostgreSQL REST API)
- [x] TitlePage / ChapterSelect / StoryPage / ChapterComplete 구현
- [x] Framer Motion 애니메이션 통합
- [x] Vercel 배포 + vercel.json SPA 라우팅

### Phase 2: 스토리 콘텐츠 (전 챕터 확장 완료)
모든 챕터를 "이름 없는 관찰자" 시점으로 재집필 — 각 6씬 → 약 28~30씬, 분기 6곳, 엔딩 3개.
- [x] Chapter 1: 갈릴리의 부름 (베드로의 조수)
- [x] Chapter 2: 광야의 시험 (광야의 목동)
- [x] Chapter 3: 산상수훈 (군중 속 한 사람)
- [x] Chapter 4: 풍랑을 잠재우심 (배의 어린 일꾼)
- [x] Chapter 5: 오병이어의 기적 (도시락 소년)
- [x] Chapter 6: 물 위를 걸으심 (배에서 지켜보는 일꾼)
- [x] Chapter 7: 선한 사마리아인 (여리고 길의 나그네)
- [x] Chapter 8: 탕자의 귀환 (아버지 집의 종)
- [x] Chapter 9: 나사로를 살리심 (베다니 마을의 벗)
- [x] Chapter 10: 최후의 만찬 (다락방을 준비한 사람)
- [x] Chapter 11: 겟세마네 기도 (동산의 불침번)

### Phase 3: 이미지/미디어 에셋
- [x] 배경/캐릭터 이미지 생성 및 Supabase Storage 업로드
- [x] 챕터별 씬 배경/캐릭터/BGM URL 매핑
- [x] 파비콘 적용

### Phase 4: BGM/효과음
- [x] 메인 BGM: Marimba Meadow (타이틀/선택/완료 화면 공유)
- [x] 스토리 BGM 아크: 잔잔함 → 긴장 → 여운 (3종)
- [x] 동일 BGM 씬 전환 시 끊기지 않음 (bgmUrlRef)
- [x] 효과음: 타이핑 / 호버 / 클릭 / 스킵 (Web Audio API)
- [x] 전역 볼륨 조절 + 음소거 (volumeRef stale closure 수정)

### Phase 5: UI/UX 개선
- [x] 캐릭터 최대 4명, 라운드 + 엣지 페이드, 중앙 배치
- [x] GlobalMenu: 전 화면 우상단 고정
- [x] ChapterSelect 호버 스크롤 버그 수정
- [x] **경로 기준 진행도** (분기에서 숫자가 튀지 않도록)

### Phase 6: 팀/로그인 시스템
- [x] 이름 + 팀 선택 필수 로그인
- [x] teams 테이블 + 어드민 팀 CRUD
- [x] player_sessions 테이블 (챕터 완료 기록)
- [x] 챕터 완료 즉시 React state 반영

### Phase 7: 어드민 패널
- [x] 쿠키 기반 어드민 로그인 (7일 슬라이딩 만료)
- [x] 대시보드: 총 플레이어 / 완료 횟수 / 팀별 / 사용자별 현황
- [x] 챕터별 완료 수 바차트 + 최근 활동 피드
- [x] 스킵 버튼 어드민 전용

### Phase 8: 진행 구조 (신규)
- [x] **챕터 순차 해금** (이전 챕터 완료 시 다음 챕터 오픈, 어드민 전체 해금)
- [x] 챕터별 멀티 엔딩 (3개)
- [x] 각 챕터 마무리 성경 구절

---

## 🔄 진행 중 / 확인 필요

- [ ] 확장된 전 챕터 플레이 검수 (톤/문구 다듬기)
- [ ] 대시보드 데이터 실사용 검증

---

## 📋 예정된 작업

### 콘텐츠 보완
- [ ] 엔딩별 결과 요약/배지
- [ ] 선택 통계(어떤 분기를 많이 택했는지) 시각화

### 기능 확장
- [ ] 진행도 요약 화면 (완료한 챕터 / 엔딩 기록)
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
| 스토리 콘텐츠 (11챕터 확장) | ✅ 완료 | 100% |
| 이미지/미디어 에셋 | ✅ 완료 | 100% |
| BGM/효과음 | ✅ 완료 | 100% |
| UI/UX 개선 | ✅ 완료 | 100% |
| 팀/로그인 시스템 | ✅ 완료 | 100% |
| 어드민 패널 | ✅ 완료 | 100% |
| 진행 구조(순차 해금/멀티엔딩) | ✅ 완료 | 100% |
| 콘텐츠 보완 | ⏳ 예정 | 10% |
| 기능 확장 | ⏳ 예정 | 0% |
| 성능 최적화 | ⏳ 예정 | 0% |

**전체 진행률: ~92%**

---

## 🔗 중요 링크

- **배포 URL**: https://bible-quest-nine.vercel.app
- **GitHub**: https://github.com/qtw9723/Bible-Quest
- **Supabase**: https://supabase.com/dashboard (프로젝트: elqomxaemqiqalzhczfc)
- **어드민**: https://bible-quest-nine.vercel.app/admin
