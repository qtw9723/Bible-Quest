-- 이미지 에셋 메타데이터 테이블
CREATE TABLE IF NOT EXISTS public.image_assets (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT NOT NULL CHECK (category IN ('backgrounds', 'characters', 'ui')),
  file_path TEXT NOT NULL UNIQUE,
  public_url TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.image_assets DISABLE ROW LEVEL SECURITY;
