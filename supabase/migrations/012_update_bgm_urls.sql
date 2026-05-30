-- 기존 Morning Over Galilee → 새 메인 테마로 교체
UPDATE scenes
SET bgm_url = 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3'
WHERE bgm_url = 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780068239921-Morning_Over_Galilee.mp3';

-- 기존 Throne of Dawn → 새 부름의 순간으로 교체
UPDATE scenes
SET bgm_url = 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3'
WHERE bgm_url = 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780070087125-Throne_of_Dawn.mp3';
