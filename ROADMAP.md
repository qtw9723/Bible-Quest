# Bible Quest - 개발 로드맵

## ✅ 완료된 작업

### Phase 1: 기초 구조 (완료)
- [x] Vite + React 19 프로젝트 설정
- [x] Supabase 연동 (PostgreSQL)
- [x] TitlePage 컴포넌트 구현
- [x] ChapterSelect 컴포넌트 구현
- [x] StoryPage 컴포넌트 구현
- [x] ChapterComplete 컴포넌트 구현
- [x] Tailwind CSS v4 설정
- [x] Framer Motion 애니메이션 통합

### Phase 2: 어드민 대시보드 (완료)
- [x] AdminPanel 컴포넌트 구현
- [x] StoryBuilder (장, 장면, 선택지 CRUD)
- [x] 어드민 패널 URL 접근 (/admin)
- [x] 어드민 비밀번호 인증 (VITE_ADMIN_PASSWORD)
- [x] Supabase RLS 비활성화 (어드민 데이터 입력 허용)

### Phase 3: 배포 및 환경 설정 (완료)
- [x] Vercel 배포
- [x] SPA 라우팅 (vercel.json)
- [x] 환경 변수 설정 (.env)
- [x] GitHub 저장소 생성

### Phase 4: 버그 수정 및 개선 (완료)
- [x] 어드민 대시보드 scene 로딩 문제 수정
- [x] choice.text → choice.label 필드명 수정
- [x] 모바일 반응형 레이아웃 개선
- [x] 배경 이미지 폴백 설정

---

## 🔄 진행 중인 작업

### Phase 5: 콘텐츠 작성 (진행 중)
- [x] Chapter 1: 갈릴리의 부름 (완료)
- [x] Chapter 2: 광야의 시험 (완료)
- [x] Chapter 3: 산상수훈 (완료)
- [ ] Chapter 4: 귀신 들린 자의 치유
- [ ] Chapter 5: 오병이어의 기적
- [ ] Chapter 6: 풍랑을 잠재우시다
- [ ] Chapter 7: 가나안 여인
- [ ] Chapter 8: 변화산
- [ ] Chapter 9: 부자 청년
- [ ] Chapter 10: 잃은 양의 비유
- [ ] Chapter 11: 십자가의 길
- [ ] Chapter 12: 부활의 아침

---

## 📋 예정된 작업

### Phase 6: 화면 프롬프트 제작 및 이미지 에셋 (우선순위: 높음)
**주요 업무 - 화면 디자인 및 프롬프트 작성**

#### 6-1. Figma 화면 설계
- [ ] 각 장면별 화면 레이아웃 설계 (12개 장면)
  - 배경 이미지 위치/크기 정의
  - 캐릭터 이미지 위치/크기 정의
  - 텍스트 박스 위치/포맷 정의
  - 선택지 버튼 배치
- [ ] 모바일/태블릿/데스크톱 반응형 설계
- [ ] 색상 팔레트 및 UI 요소 정의

#### 6-2. AI 이미지 생성 프롬프트 작성
- [ ] **배경 이미지 프롬프트** (12개)
  - Chapter 1: 갈릴리의 부름 - "갈릴리 호수, 아침 해가 떠오르는 중, 어부들이 보이는 배경, 따뜻한 황금색 조명..."
  - Chapter 2: 광야의 시험 - "광야, 황량한 모래 언덕, 석양, 영적 분위기..."
  - Chapter 3: 산상수훈 - "산 위의 평원, 많은 사람들이 모여있는 장면..."
  - [나머지 9개 프롬프트]

- [ ] **캐릭터 이미지 프롬프트** (주요 인물별)
  - 예수님: "예수님, 흰 색 옷, 자비로운 표정, 성서 시대 배경..."
  - 베드로: "베드로, 어부 복장, 강한 표정..."
  - 여타 제자/인물들

#### 6-3. 이미지 생성 및 에셋 준비
- [ ] Midjourney/DALL-E/Stable Diffusion 등으로 이미지 생성
- [ ] 생성된 이미지 후처리 (해상도, 색감 조정)
- [ ] 이미지 포맷 최적화 (WebP, PNG 등)
- [ ] 이미지 파일명 및 메타데이터 정리

#### 6-4. Supabase 저장소 연동
- [ ] Supabase Storage 버킷 생성 (backgrounds, characters)
- [ ] 모든 이미지 업로드
- [ ] 각 장면에 이미지 URL 연결
- [ ] 이미지 로딩 및 캐싱 최적화

### Phase 7: 선택지 분기 처리 (우선순위: 높음)
- [ ] 각 장면의 선택지에 next_scene_id 설정
- [ ] 선택지에 따른 분기 처리
- [ ] 분기별 엔딩 생성 (최소 2개 이상)

### Phase 8: 사용자 진행도 관리 (우선순위: 중간)
- [ ] player_progress 테이블 활용
- [ ] 각 장면별 진행도 저장
- [ ] 선택지별 영향도 시스템 구현 (선택에 따른 점수/등급 변화)
- [ ] 어드민에서 진행도 조회/수정 기능

### Phase 9: 사용자 인증 (우선순위: 중간)
- [ ] Supabase Auth 연동
- [ ] 회원가입 페이지
- [ ] 로그인 페이지
- [ ] 소셜 로그인 (구글, 카카오 등)

### Phase 10: 고급 기능 (우선순위: 낮음)
- [ ] 멀티엔딩 시스템 (선택에 따른 다양한 엔딩)
- [ ] 성취도 시스템 (배지, 통계)
- [ ] 리더보드 (상위 플레이어 랭킹)
- [ ] 일일 미션/보상 시스템

### Phase 11: 성능 최적화 (우선순위: 낮음)
- [ ] 이미지 lazy loading
- [ ] 코드 분할 (code splitting)
- [ ] 번들 크기 최적화
- [ ] 캐싱 전략 개선

### Phase 12: 테스트 및 QA (우선순위: 중간)
- [ ] 각 브라우저 호환성 테스트
- [ ] 모바일 전체 화면 테스트
- [ ] 성능 측정 및 최적화
- [ ] 버그 리포트 및 수정

### Phase 13: 배포 준비 (우선순위: 낮음)
- [ ] 프로덕션 환경 설정
- [ ] CI/CD 파이프라인 개선
- [ ] 모니터링 및 로깅 설정
- [ ] 에러 추적 (Sentry 등)

---

## 📊 진행률

| Phase | 상태 | 진행률 |
|-------|------|--------|
| Phase 1 (기초 구조) | ✅ 완료 | 100% |
| Phase 2 (어드민 대시보드) | ✅ 완료 | 100% |
| Phase 3 (배포) | ✅ 완료 | 100% |
| Phase 4 (버그 수정) | ✅ 완료 | 100% |
| Phase 5 (콘텐츠) | 🔄 진행 중 | 25% (3/12) |
| Phase 6 (화면프롬프트 & 이미지) | ⏳ 예정 | 0% (프롬프트 작성 우선) |
| Phase 7 (선택지 분기) | ⏳ 예정 | 0% |
| Phase 8 (진행도 관리) | ⏳ 예정 | 0% |
| Phase 9 (사용자 인증) | ⏳ 예정 | 0% |
| Phase 10 (고급 기능) | ⏳ 예정 | 0% |
| Phase 11 (성능 최적화) | ⏳ 예정 | 0% |
| Phase 12 (QA) | ⏳ 예정 | 0% |
| Phase 13 (배포 준비) | ⏳ 예정 | 0% |

**전체 진행률: ~17%**

---

## 🎯 단기 목표 (다음 1주)
1. **화면 프롬프트 제작** (우선순위: 1순위)
   - Figma에서 Chapter 1~3 화면 설계
   - AI 이미지 생성용 프롬프트 작성 (배경 12개, 캐릭터 5개)
2. Chapter 4~6 콘텐츠 작성
3. 배경/캐릭터 이미지 최소 3개 생성 및 Supabase 업로드

## 🎯 중기 목표 (다음 1개월)
1. 전체 12개 챕터 완료
2. 모든 이미지 에셋 업로드
3. 멀티엔딩 시스템 구현 시작

## 🎯 장기 목표 (2~3개월)
1. 완전히 기능하는 게임 출시
2. 사용자 인증 및 진행도 저장 완료
3. 기본 랭킹 시스템 구현

---

## 🎨 화면 프롬프트 제작 가이드

### 배경 이미지 프롬프트 템플릿
```
[시간/날씨] [장소] [주요 요소] [분위기] [색감] 
```

### 예시 프롬프트

**Chapter 1: 갈릴리의 부름**
```
Morning light over the Sea of Galilee, ancient fishing boats, 
fishermen in period clothing, golden sunrise, warm Mediterranean 
atmosphere, beautiful water reflections, biblical era background, 
cinematic lighting, high quality illustration
```

**Chapter 2: 광야의 시험**
```
Vast wilderness desert landscape, sand dunes under dramatic sky, 
rocky outcrops, barren trees, spiritual and mystical atmosphere, 
golden and purple lighting, biblical era, cinematic, high resolution
```

**Chapter 3: 산상수훈**
```
Mountain hillside gathering, large crowd of people sitting, 
looking towards the center, green rolling hills, Mediterranean 
landscape, golden sunlight, peaceful yet powerful atmosphere, 
biblical era, crowd scene, detailed illustration
```

**캐릭터 프롬프트 (예수님)**
```
Portrait of Jesus Christ, compassionate expression, flowing white 
robes, biblical era clothing, warm golden lighting, peaceful and 
serene face, gentle eyes, historical accuracy, gentle halo effect, 
high quality portrait, cinematic lighting
```

**캐릭터 프롬프트 (베드로)**
```
Portrait of Peter the fisherman, strong weathered face, fisherman's 
clothing of biblical era, confident expression, rugged appearance, 
middle-aged man, warm lighting, historical accuracy, character 
portrait, detailed illustration
```

### 프롬프트 작성 팁
1. **구체성**: 시간, 날씨, 조명, 색감을 명시
2. **분위기**: 감정적 톤 (peaceful, dramatic, joyful 등)
3. **품질**: "high quality", "cinematic", "detailed" 등 포함
4. **역사성**: "biblical era", "historical accuracy" 명시
5. **스타일**: 원하는 그림 스타일 지정 (illustration, photorealistic 등)

---

## 📝 개발 팁

### 어드민 패널 접근
```
localhost:5173/admin
Password: admin123
```

### 스토리 데이터 구조
- chapters: 챕터 정보
- scenes: 각 챕터의 장면 (장면 순서로 정렬)
- choices: 각 장면의 선택지 (선택지 순서로 정렬)

### API 함수
- `getStoryData(chapterNum)` - 특정 챕터의 전체 데이터 조회
- `createScene()` - 장면 생성
- `updateScene()` - 장면 수정
- `createChoice()` - 선택지 생성

---

## 🔗 중요 링크
- **배포 URL**: https://bible-quest-nine.vercel.app
- **Supabase 대시보드**: https://supabase.com/dashboard
- **GitHub**: https://github.com/qtw9723/Bible-Quest
- **Figma**: [디자인 파일]

---

*마지막 업데이트: 2026-05-28*
