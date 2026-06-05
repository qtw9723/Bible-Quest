-- =====================================================================
-- player_sessions 테이블 ending_index 컬럼 추가
-- =====================================================================
-- 목적: 챕터마다 3개의 엔딩 중 어떤 것을 완료했는지 기록.
--       기존에는 (player_name, chapter_num) 조합이 유니크해서
--       같은 챕터를 다른 엔딩으로 다시 완료해도 기록이 1개뿐이었음.
--       → ending_index 컬럼 추가 후 (player_name, chapter_num, ending_index)를
--         유니크 키로 변경해 엔딩별로 별도 기록 가능.
--
-- ending_index 값:
--   0 = 첫 번째 엔딩 (챕터별 고유 결단: 따름·말씀·반석·나눔·믿음 등)
--   1 = 두 번째 엔딩 (따름의 길)
--   2 = 세 번째 엔딩 (씨앗의 길)
--   NULL = 기존 데이터 (엔딩 구분 없이 완료 기록)
--
-- 실행: Supabase Dashboard → SQL Editor 에서 본 파일 전체 실행
-- =====================================================================

-- 1) ending_index 컬럼 추가 (nullable — 기존 데이터 호환)
ALTER TABLE public.player_sessions
  ADD COLUMN IF NOT EXISTS ending_index INTEGER;

-- 2) 기존 (player_name, chapter_num) 유니크 제약 제거
--    이름은 Supabase 자동 생성 규칙: {table}_{col1}_{col2}_key
ALTER TABLE public.player_sessions
  DROP CONSTRAINT IF EXISTS player_sessions_player_name_chapter_num_key;

-- 3) 새 유니크 제약: (player_name, chapter_num, ending_index)
--    NULLS NOT DISTINCT: NULL 값도 동일하게 취급 → 기존 NULL 데이터 중복 방지
--    (PostgreSQL 15+ 기능, Supabase는 PostgreSQL 15 사용)
ALTER TABLE public.player_sessions
  ADD CONSTRAINT player_sessions_player_name_chapter_ending_key
  UNIQUE NULLS NOT DISTINCT (player_name, chapter_num, ending_index);
