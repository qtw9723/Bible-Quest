-- =====================================================================
-- 오병이어의 기적 (Chapter 5) — 확장판  [자동 생성: _apply.mjs]
-- 컨셉: 플레이어는 '도시락을 가진 이름 없는 소년'. 선택은 성경의 결과를 바꾸지 않고
--       나의 마음/행동만 바꾼다(작은 것을 드림→기적). 분기는 고정점에서 합류.
-- 본문: 요한복음 6:1-13 (오병이어)
-- 구조: 5막 · 29씬 · 분기 6곳 · 엔딩 3개   BGM: morning→throne→snowfield
-- =====================================================================

DO $$
DECLARE chap INT;
BEGIN
  SELECT id INTO chap FROM public.chapters WHERE chapter_num = 5;
  IF chap IS NULL THEN RAISE EXCEPTION 'chapter_num=5 챕터를 찾을 수 없습니다.'; END IF;

  DELETE FROM public.choices WHERE scene_id IN (SELECT id FROM public.scenes WHERE chapter_id = chap);
  DELETE FROM public.scenes WHERE chapter_id = chap;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition) VALUES
    (chap, 1, '해가 뉘엿뉘엿 기우는 저녁, 벳새다 외딴 들판에 오천 명이 넘는 사람들이 구름처럼 모여 있었습니다. 멀리서 온 이 선생의 말씀을 한마디라도 더 들으려는 사람들이었습니다.

당신은 어머니와 함께 온 열두 살 소년입니다. 새벽같이 길을 나서느라 아침부터 아무것도 먹지 못해, 뱃속에서 연신 꼬르륵 소리가 났습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076342371-08c2c507-7b63-4763-8159-b9e77ec900fe.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 2, '사람들은 배고픔도 잊은 듯 그분의 말씀에 푹 빠져 있었습니다. 병자들이 나아 일어서고, 그분의 한마디 한마디에 웃고 우는 사람들.

그러나 당신의 머릿속은 온통 허기로 가득합니다. 지금 당신의 마음은 무엇에 가 있습니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 3, '당신은 무릎 위 작은 보따리를 슬며시 끌어안습니다. 그 안엔 어머니가 새벽에 싸 주신 보리떡 다섯 개와 절인 물고기 두 마리가 들어 있었습니다.

"조금만 더 참았다가… 사람들 눈에 안 띄게 먹어야지." 이 많은 사람 틈에서 혼자 먹기가 미안해, 당신은 침만 꼴깍 삼켰습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076342371-08c2c507-7b63-4763-8159-b9e77ec900fe.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 4, '허기에도 불구하고, 당신의 시선은 자꾸만 그분께로 향합니다. 무엇이 저토록 사람들을 붙들어 두는 걸까.

그분의 목소리는 크지 않았지만, 신기하게도 그 너른 들판 끝까지 또렷이 닿는 듯했습니다. 당신은 어느새 배고픔도 잠시 잊고 그 말씀에 귀를 기울였습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 5, '당신은 고개를 들어 주위를 둘러봅니다. 끝이 보이지 않는 사람의 물결. 다들 당신처럼 먼 길을 걸어와 지치고 굶주린 얼굴들이었습니다.

"이 많은 사람이 다 저녁은 어떻게 하려나." 어린 마음에도 문득 그런 걱정이 스쳤습니다. 해는 이미 산 너머로 기울고 있었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076342371-08c2c507-7b63-4763-8159-b9e77ec900fe.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 6, '날이 저물자 제자들이 예수님께 다가와 말했습니다. "여기는 빈 들이요 때도 이미 저물었으니, 무리를 보내어 마을에서 먹을 것을 사 먹게 하소서."

그러나 예수님은 뜻밖의 말씀을 하셨습니다. "너희가 먹을 것을 주라." 빌립이 난감한 듯 답했습니다. "이백 데나리온의 떡이 있어도 각 사람이 조금씩 받기에도 부족하옵니다."', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 7, '그때 안드레가 무리 사이를 두리번거리다, 보따리를 안고 있는 당신을 발견하고는 예수님께 데려갔습니다.

"여기 한 아이가 있어 보리떡 다섯 개와 물고기 두 마리를 가졌나이다. 그러나 그것이 이 많은 사람에게 얼마나 되겠삽나이까?" 순간, 수많은 사람들의 시선이 일제히 당신에게로 쏠렸습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076342371-08c2c507-7b63-4763-8159-b9e77ec900fe.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 8, '당신의 작은 보따리가, 갑자기 오천 명 앞에 펼쳐진 셈이 되었습니다. 심장이 쿵쿵 뛰었습니다.

이 보잘것없는 도시락을 두고, 당신은 어떻게 하시겠습니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076342371-08c2c507-7b63-4763-8159-b9e77ec900fe.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 9, '당신은 얼굴이 화끈 달아올랐습니다. "이 많은 사람 앞에서, 고작 떡 다섯 개라니… 비웃음거리가 되면 어쩌지."

움츠러든 손으로 보따리를 만지작거리는데, 어느새 안드레의 손에 이끌려 그것은 예수님 앞에 놓여 있었습니다. 부끄러움과는 별개로, 일은 그렇게 시작되고 있었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076342371-08c2c507-7b63-4763-8159-b9e77ec900fe.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 10, '당신은 잠시 망설였습니다. 새벽부터 굶은 당신의 하루치 양식이자, 어머니의 정성이 담긴 전부였으니까.

"이걸 다 드리면 나랑 어머니는…?" 그러나 그 작은 아까움보다, 그분께 무언가 보태고 싶은 마음이 더 컸습니다. 당신은 두 손으로 보따리를 내밀었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076342371-08c2c507-7b63-4763-8159-b9e77ec900fe.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 11, '당신은 망설임 없이 보따리를 풀어 두 손으로 받쳐 들었습니다. "얼마 안 되지만… 이거라도 쓰세요."

이 많은 사람에게 떡 다섯 개가 무슨 소용이랴 싶었지만, 이상하게도 그분께 드리는 순간만큼은 부끄럽지 않았습니다. 오히려 마음 한구석이 환해지는 기분이었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076342371-08c2c507-7b63-4763-8159-b9e77ec900fe.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 12, '예수님은 당신의 작은 도시락을 두 손으로 받으시고는, 당신을 가만히 바라보며 따뜻하게 미소 지으셨습니다. 그 눈빛에 당신의 떨림이 스르르 가라앉았습니다.

그러고는 제자들에게 명하셨습니다. "사람들을 떼를 지어 풀밭에 앉히라." 오천 명이 오십 명씩, 백 명씩 무리지어 푸른 풀밭에 앉았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 13, '당신은 두근거리는 가슴으로 그 광경을 지켜봅니다. 당신의 작은 보따리가 그분의 손에 들려 있는 모습이, 어쩐지 비현실적으로 느껴졌습니다.

그 순간, 당신의 마음은 어떻습니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 14, '당신은 입술을 깨물며 그분의 손을 바라봅니다. "괜히 드렸나. 저 많은 사람 앞에서 떡 다섯 개라니, 망신만 당하는 거 아닐까."

그러면서도 당신은 눈을 뗄 수 없었습니다. 마음 한구석에서는, 무언가 일어나길 간절히 바라고 있었으니까.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 15, '이상하게도, 당신은 더 이상 불안하지 않았습니다. 당신의 작은 것을 받아 든 그분의 눈빛이, 마치 "잘했다"고 말해 주는 것 같았으니까.

무슨 일이 일어날지는 알 수 없었지만, 적어도 당신의 도시락이 허투루 쓰이지는 않으리라는 믿음이 생겼습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 16, '예수님이 떡 다섯 개와 물고기 두 마리를 들고 하늘을 우러러 감사 기도를 드리셨습니다. 그러고는 떡을 떼어 제자들에게 나누어 주기 시작하셨습니다.

그런데 이상한 일이 벌어졌습니다. 떼고 또 떼어도 그분의 손에서 떡이 끊이지 않았습니다. 제자들이 광주리 가득 떡을 받아 무리에게 돌리고, 다시 돌아오면 또 가득 차 있었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 17, '당신은 두 눈을 의심했습니다. 분명 당신이 드린 건 떡 다섯 개가 전부였는데, 그것이 끝없이 사람들에게 돌아가고 있었습니다.

이 믿을 수 없는 광경 앞에서, 당신은 어떤 마음이 듭니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 18, '당신은 자기도 모르게 고개를 절레절레 흔듭니다. "이게 무슨 일이지? 분명 떡은 다섯 개뿐이었는데."

아무리 셈을 해 보아도 도무지 앞뒤가 맞지 않았습니다. 그러나 당신의 눈앞에서, 그 말도 안 되는 일은 지금도 계속되고 있었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 19, '당신의 팔뚝에 소름이 쫙 돋았습니다. 이건 손재주나 속임수로 될 일이 아니었습니다.

오천 명을, 당신의 떡 다섯 개로 먹이고 있다니. 당신은 자신이 무언가 거룩하고 두려운 일의 한복판에 서 있음을 어렴풋이 느꼈습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 20, '당신은 입을 헤벌린 채, 사람에서 사람으로 끝없이 건네지는 떡을 멍하니 바라볼 뿐이었습니다.

무슨 말을 해야 할지, 무슨 생각을 해야 할지조차 알 수 없었습니다. 그저 그 광경이 당신의 작은 가슴에 다 담기지 않을 만큼 벅찼습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 21, '마침내 오천 명이 넘는 모든 사람이 배불리 먹었습니다. 당신도 어머니와 함께, 따뜻한 보리떡을 실컷 먹었습니다. 그것은 바로 당신이 드렸던 그 떡이었습니다.

제자들이 남은 조각을 거두니, 무려 열두 광주리에 가득 찼습니다. 드린 것보다 훨씬 더 많은 것이 남은 것입니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 22, '당신은 배부른 채로, 무릎 위에 놓인 빈 보따리를 내려다봅니다. 텅 비었는데도, 마음은 그 어느 때보다 가득했습니다.

내 작은 도시락이 수천 명을 먹였다는 사실 앞에서, 당신의 마음에는 무엇이 차오릅니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 23, '당신은 빈 보따리를 만지작거리며 몇 번이고 곱씹어 봅니다. 분명 별것 아니었는데. 정말 별것 아니었는데.

그 별것 아닌 것이 수천 명의 저녁이 되었다는 사실이, 당신의 어린 머리로는 다 헤아릴 수 없을 만큼 크게 느껴졌습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 24, '당신의 가슴이 따뜻하게 부풀어 올랐습니다. 만약 부끄러워서, 아까워서 그 도시락을 끝내 움켜쥐고 있었다면.

오늘의 이 기적도, 이 벅찬 기쁨도 없었을 것입니다. "드리길 정말 잘했어." 당신은 빈 보따리를 소중하게 가슴에 안았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 25, '당신은 한 가지를 분명히 깨달았습니다. 당신의 손에 있을 때 그것은 그저 한 끼 도시락이었습니다.

그러나 그분의 손에 건네진 순간, 그것은 전혀 다른 것이 되었습니다. 어쩌면 중요한 것은 내가 가진 것의 크기가 아니라, 그것을 그분께 드리느냐였는지도 모릅니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 26, '사람들은 흥분하여 그분을 억지로 왕으로 삼으려 했고, 예수님은 조용히 그 자리를 떠나 홀로 산으로 가셨습니다.

당신은 텅 빈 보따리를 손에 쥔 채, 오늘 일을 어떻게 품고 살아갈지 생각합니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 27, '집으로 돌아가는 길, 당신은 다짐합니다. 가진 것이 보잘것없다고 움켜쥐고만 살지는 않으리라.

떡 다섯 개가 오천 명을 먹였듯, 당신의 작은 것도 그분의 손에 드려지면 무슨 일이든 일어날 수 있음을 보았으니까. 당신은 텅 빈 보따리를, 그 어떤 보물보다 소중히 여기게 되었습니다.

📖 요한복음 6:11
"예수께서 떡을 가져 축사하신 후에 앉아 있는 자들에게 나눠 주시니라"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 28, '당신은 멀어지는 그분의 뒷모습에서 눈을 떼지 못합니다. 떡 다섯 개로 오천 명을 먹인 분. 도무지 알 수 없는, 그러나 한없이 따뜻한 분.

어머니의 손을 잡은 채, 당신은 마음먹습니다. 언젠가 다시, 저분을 더 가까이에서 따르리라. 이름 없는 한 소년의 마음에, 작은 불씨 하나가 켜졌습니다.

📖 요한복음 6:11
"예수께서 떡을 가져 축사하신 후에 앉아 있는 자들에게 나눠 주시니라"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 29, '당신은 다시 평범한 소년의 일상으로 돌아갑니다. 어머니의 심부름을 하고, 친구들과 뛰놀고, 또 도시락을 싸는 날들.

그러나 보리떡을 볼 때마다, 당신은 그 저녁을 떠올릴 것입니다. 당신의 작은 것이 수천의 배를 채우던 그 기적을. 그것은 잊히지 않을 씨앗이 되어, 당신 안에서 조용히 자라기 시작했습니다.

📖 요한복음 6:11
"예수께서 떡을 가져 축사하신 후에 앉아 있는 자들에게 나눠 주시니라"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade');

  INSERT INTO public.choices (scene_id, label, next_scene_id, choice_order) VALUES
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=1), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '어머니가 싸 주신 보리떡 다섯 개와 물고기 두 마리가 든 보따리를 만지작거린다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=3), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '배는 고파도, 말씀하시는 그분께 자꾸만 눈이 간다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=4), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '주위를 둘러보니, 다들 나처럼 지치고 굶주려 있다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=3), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=4), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), '이 적은 걸 내놓기가 부끄러워 손이 움츠러든다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), '어머니가 정성껏 싸 주신 건데… 다 드리기엔 아깝다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), '보잘것없지만, 그분께라면 기꺼이 드리고 싶다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), '''저 적은 걸로 대체 뭘 하시려고…'' 후회 반 기대 반이다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), '그분의 따뜻한 눈빛에, 어쩐지 마음이 놓인다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), '''말도 안 돼…'' 도무지 믿기지가 않는다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), '온몸에 소름이 돋는다 — 이건 사람의 일이 아니다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), '너무 놀라 입을 다물지 못한 채 멍하니 바라본다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), '이 작은 것이 그렇게 큰일을 했다니, 아직도 믿기지 않는다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), '드리길 정말 잘했다 — 가슴이 벅차오른다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=24), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), '내 손엔 보잘것없던 것이, 그분 손에선 다른 것이 되었구나', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=24), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), '나의 작은 것이라도, 앞으로 늘 그분께 기꺼이 드리며 살리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), '이런 분이라면 더 알고 싶다 — 그분을 따라가 보리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=28), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), '오늘의 이 저녁을, 평생 잊지 않고 가슴에 새기리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=29), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '챕터 완료', NULL, 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=28), '챕터 완료', NULL, 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=29), '챕터 완료', NULL, 1);

END $$;
