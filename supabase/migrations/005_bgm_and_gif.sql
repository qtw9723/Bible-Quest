-- image_assets: UI 카테고리 → BGM으로 교체
ALTER TABLE public.image_assets
  DROP CONSTRAINT IF EXISTS image_assets_category_check;

ALTER TABLE public.image_assets
  ADD CONSTRAINT image_assets_category_check
  CHECK (category IN ('backgrounds', 'characters', 'bgm'));

-- scenes: BGM 필드 추가
ALTER TABLE public.scenes
  ADD COLUMN IF NOT EXISTS bgm_url TEXT DEFAULT NULL,
  ADD COLUMN IF NOT EXISTS bgm_transition TEXT DEFAULT 'fade'
    CHECK (bgm_transition IN ('fade', 'cut'));
