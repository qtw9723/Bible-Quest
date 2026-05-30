-- 팀 테이블
CREATE TABLE IF NOT EXISTS public.teams (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);
ALTER TABLE public.teams DISABLE ROW LEVEL SECURITY;

-- player_sessions에 팀/이름 컬럼 추가
ALTER TABLE public.player_sessions
  ADD COLUMN IF NOT EXISTS team_id UUID REFERENCES public.teams(id),
  ADD COLUMN IF NOT EXISTS player_name TEXT;

-- 기존 nickname → player_name 마이그레이션
UPDATE public.player_sessions SET player_name = nickname WHERE player_name IS NULL;

CREATE INDEX IF NOT EXISTS idx_ps_team ON public.player_sessions(team_id);
