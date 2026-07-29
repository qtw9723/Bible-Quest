-- =====================================================================
-- player_sessions 유니크 제약 교정 (027 버그 수정)
-- =====================================================================
-- 문제:
--   013_player_progress.sql 이 테이블 생성 시 UNIQUE(nickname, chapter_num) 을
--   인라인으로 만들었고, PostgreSQL 이 자동 명명한 제약 이름은
--     player_sessions_nickname_chapter_num_key
--   이다 (nickname 기준).
--
--   그런데 027_player_sessions_ending_index.sql 은 실제로 존재한 적 없는
--     player_sessions_player_name_chapter_num_key   (player_name 기준)
--   을 DROP IF EXISTS 로 지우려 했다. 이름이 달라 아무 것도 지워지지 않고,
--   옛 UNIQUE(nickname, chapter_num) 제약이 그대로 살아남았다.
--
--   recordChapterComplete() 는 nickname 과 player_name 에 같은 값을 넣기 때문에,
--   같은 챕터를 다른 엔딩(ending_index)으로 완료하면 새 제약
--     (player_name, chapter_num, ending_index)
--   상으로는 허용되지만, 살아있는 옛 (nickname, chapter_num) 제약을 위반한다.
--   → 두 번째 엔딩부터 DB 저장이 막혀 엔딩 수집이 동작하지 않는다.
--
-- 해결:
--   실제로 존재하는 옛 제약(nickname 기준)을 이름으로 정확히 제거하고,
--   엔딩별 기록을 위한 (player_name, chapter_num, ending_index) 제약이
--   반드시 존재하도록 보장한다. 모두 IF EXISTS / 조건부라 반복 실행해도 안전하다.
--
-- 실행: Supabase Dashboard → SQL Editor 에서 본 파일 전체 실행
-- =====================================================================

-- 1) 살아남아 있던 옛 제약(nickname, chapter_num) 을 정확한 이름으로 제거
ALTER TABLE public.player_sessions
  DROP CONSTRAINT IF EXISTS player_sessions_nickname_chapter_num_key;

-- 2) 혹시 027 에서 잘못된 이름으로 걸려 있을 수 있는 경우도 방어적으로 제거
ALTER TABLE public.player_sessions
  DROP CONSTRAINT IF EXISTS player_sessions_player_name_chapter_num_key;

-- 3) 엔딩별 기록용 제약이 없으면 추가 (027 이 부분적으로만 적용된 DB 대비)
--    NULLS NOT DISTINCT: 엔딩 미기록(NULL) 데이터도 동일하게 취급해 중복 방지
--    (PostgreSQL 15+ 기능, Supabase 는 PostgreSQL 15 사용)
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_constraint
    WHERE conrelid = 'public.player_sessions'::regclass
      AND conname  = 'player_sessions_player_name_chapter_ending_key'
  ) THEN
    ALTER TABLE public.player_sessions
      ADD CONSTRAINT player_sessions_player_name_chapter_ending_key
      UNIQUE NULLS NOT DISTINCT (player_name, chapter_num, ending_index);
  END IF;
END $$;
