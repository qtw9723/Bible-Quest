-- Chapter 1 장면별 이미지 배치
DO $$
DECLARE
  bg    TEXT := 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg';
  jesus TEXT := 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg';
  peter TEXT := 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066640469-ac2dbd22-e1e5-4a6e-942c-be05036b6436.jpg';
BEGIN
  -- S1: 도입 — 배경 + 베드로 (당신이 함께 일하는 사람)
  UPDATE public.scenes SET background = bg, character = peter WHERE id = 3;
  -- S2: 베드로가 예수님 소개 — 배경 + 베드로
  UPDATE public.scenes SET background = bg, character = peter WHERE id = 4;
  -- S3: 예수님이 첫 부름 — 배경 + 예수님
  UPDATE public.scenes SET background = bg, character = jesus WHERE id = 5;
  -- S4: 가까이서 눈맞춤 — 배경 + 예수님
  UPDATE public.scenes SET background = bg, character = jesus WHERE id = 6;
  -- S5: 멀리서 베드로 지켜봄 — 배경 + 베드로
  UPDATE public.scenes SET background = bg, character = peter WHERE id = 7;
  -- S6: 베드로 안드레 뒷모습 — 배경 + 베드로
  UPDATE public.scenes SET background = bg, character = peter WHERE id = 8;
  -- S7: 야고보 요한 부름, 예수님 — 배경 + 예수님
  UPDATE public.scenes SET background = bg, character = jesus WHERE id = 9;
  -- S8: 따라가고 싶다 (감정 독백) — 배경만
  UPDATE public.scenes SET background = bg, character = NULL WHERE id = 10;
  -- S9: 부럽고 두렵다 (감정 독백) — 배경만
  UPDATE public.scenes SET background = bg, character = NULL WHERE id = 11;
  -- S10: 엔딩 — 배경만
  UPDATE public.scenes SET background = bg, character = NULL WHERE id = 12;
END $$;
