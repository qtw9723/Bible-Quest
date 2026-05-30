-- 플레이어 진행도 테이블 (nickname 기반 간단 구조)
CREATE TABLE IF NOT EXISTS public.player_sessions (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  nickname TEXT NOT NULL,
  chapter_num INT NOT NULL,
  completed_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(nickname, chapter_num)
);

ALTER TABLE public.player_sessions DISABLE ROW LEVEL SECURITY;

CREATE INDEX IF NOT EXISTS idx_ps_nickname ON public.player_sessions(nickname);
CREATE INDEX IF NOT EXISTS idx_ps_chapter  ON public.player_sessions(chapter_num);
CREATE INDEX IF NOT EXISTS idx_ps_completed ON public.player_sessions(completed_at DESC);
