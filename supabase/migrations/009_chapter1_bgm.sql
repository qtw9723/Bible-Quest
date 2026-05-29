-- Chapter 1 장면별 BGM 배치
DO $$
DECLARE
  morning  TEXT := 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780068239921-Morning_Over_Galilee.mp3';
  throne   TEXT := 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780070087125-Throne_of_Dawn.mp3';
  snowfield TEXT := 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3';
BEGIN
  -- S1 도입 (잔잔한 호수 아침) → Morning Over Galilee, 페이드인
  UPDATE public.scenes SET bgm_url = morning,   bgm_transition = 'fade' WHERE id = 3;
  -- S2 베드로 속삭임 (호수 분위기 유지) → Morning Over Galilee, 씬 전환 시 같은 음원이므로 끊기지 않음
  UPDATE public.scenes SET bgm_url = morning,   bgm_transition = 'fade' WHERE id = 4;

  -- S3 예수님 첫 부름 (긴장+신성함 시작) → Throne of Dawn, 페이드 전환
  UPDATE public.scenes SET bgm_url = throne,    bgm_transition = 'fade' WHERE id = 5;
  -- S4 가까이서 눈맞춤 → Throne of Dawn 유지
  UPDATE public.scenes SET bgm_url = throne,    bgm_transition = 'fade' WHERE id = 6;
  -- S5 멀리서 지켜봄 → Throne of Dawn 유지
  UPDATE public.scenes SET bgm_url = throne,    bgm_transition = 'fade' WHERE id = 7;
  -- S6 베드로 안드레 따라감 → Throne of Dawn 유지
  UPDATE public.scenes SET bgm_url = throne,    bgm_transition = 'fade' WHERE id = 8;
  -- S7 야고보 요한 부름 → Throne of Dawn 유지
  UPDATE public.scenes SET bgm_url = throne,    bgm_transition = 'fade' WHERE id = 9;

  -- S8 따라가고 싶다 (감정 독백) → Falling Snowfield, 페이드 전환
  UPDATE public.scenes SET bgm_url = snowfield, bgm_transition = 'fade' WHERE id = 10;
  -- S9 부럽고 두렵다 (감정 독백) → Falling Snowfield 유지
  UPDATE public.scenes SET bgm_url = snowfield, bgm_transition = 'fade' WHERE id = 11;
  -- S10 엔딩 → Falling Snowfield 유지
  UPDATE public.scenes SET bgm_url = snowfield, bgm_transition = 'fade' WHERE id = 12;
END $$;
