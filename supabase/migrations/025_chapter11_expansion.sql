-- =====================================================================
-- 겟세마네 기도 (Chapter 11) — 확장판  [자동 생성: _apply.mjs]
-- 컨셉: 플레이어는 '겟세마네 동산의 불침번 경비원' — 이름 없는 관찰자.
--       선택은 성경의 결과를 바꾸지 않고 나의 마음만 바꾼다. 분기는 고정점에서 합류.
-- 본문: 마태복음 26:36-46 / 누가복음 22:39-46 (겟세마네 기도)
-- 구조: 5막 · 30씬 · 분기 6곳 · 엔딩 3개   BGM: snow→throne→snow
-- =====================================================================

DO $$
DECLARE chap INT;
BEGIN
  SELECT id INTO chap FROM public.chapters WHERE chapter_num = 11;
  IF chap IS NULL THEN RAISE EXCEPTION 'chapter_num=11 챕터를 찾을 수 없습니다.'; END IF;

  DELETE FROM public.choices WHERE scene_id IN (SELECT id FROM public.scenes WHERE chapter_id = chap);
  DELETE FROM public.scenes WHERE chapter_id = chap;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition) VALUES
    (chap, 1, '최후의 만찬을 마친 깊은 밤, 예수님은 제자들과 함께 감람산 기슭의 겟세마네라는 동산에 이르셨습니다.

당신은 그 올리브 동산에서 밤을 지키는 불침번 경비입니다. 인적 없는 한밤중, 올리브 나무 사이로 한 무리의 그림자가 조용히 들어서는 것을 보았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 2, '이 야심한 시각에 동산을 찾은 일행. 경비인 당신은 그들을 어떻게 지켜봅니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 3, '당신은 일단 경계심을 품고 멀찍이서 그들을 살핍니다. 한밤중에 동산을 찾는 무리란, 좋은 일로 오는 경우가 드물었으니까요.

그러나 그들에게선 어떤 험한 기색도 느껴지지 않았습니다. 오히려 무겁고 가라앉은 분위기가, 마치 장례 행렬 같았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 4, '어둠 속에서도, 당신은 그 무리의 중심에 선 분을 이내 알아보았습니다. 낮에 성전 뜰에서 사람들을 가르치던, 바로 그 나사렛 선생이었습니다.

"저 유명한 분이, 이 밤중에 어인 일로." 당신은 호기심 반 긴장 반으로 그들을 지켜보았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 5, '당신은 의아했습니다. 잠자리에 들 시간에, 굳이 이 외진 동산까지 기도하러 오다니.

무언가 마음에 큰 짐을 진 사람만이 이런 한밤중에 홀로 기도를 찾는 법이었습니다. 당신은 그 무거운 발걸음에서, 예사롭지 않은 기운을 느꼈습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 6, '예수님은 제자들 대부분을 입구에 두시고, 세 사람만 따로 데리고 동산 깊숙이 들어가셨습니다. 그러고는 떨리는 목소리로 말씀하셨습니다.

"내 마음이 심히 고민하여 죽게 되었으니, 너희는 여기 머물러 나와 함께 깨어 있으라." 그 음성은, 낮에 듣던 그 당당한 목소리가 아니었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 7, '늘 의연하던 그분이, 저토록 괴로워하며 떨고 계셨습니다. 그 모습을 지켜보는 당신의 마음에는 무엇이 일어납니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 8, '당신은 의외였습니다. 풍문으로 듣던 그 담대한 분이, 죽을 것처럼 괴로워하다니. 두려움에 떠는 그 모습이, 너무도 인간적이었습니다.

"저런 분도, 이토록 무서워하실 때가 있구나." 당신은 그 낯선 모습에 도리어 마음이 술렁였습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 9, '당신의 가슴이 철렁 내려앉았습니다. "심히 고민하여 죽게 되었다"니. 대체 무슨 일이 닥치기에, 저분이 저토록 무너지신단 말인가.

알 수 없는 불안이 동산의 어둠과 함께 당신을 에워쌌습니다. 무언가 두려운 밤이 시작되고 있었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 10, '"나와 함께 깨어 있으라." 그 부탁이, 경비로 밤을 지키던 당신의 가슴에 사무쳤습니다.

그 큰 분이, 곁에 누군가 깨어 있어 주기를 — 그렇게 간절히 바라고 계셨습니다. 고독한 그 한마디에, 당신은 까닭 모를 안쓰러움을 느꼈습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 11, '예수님은 세 제자에게서 조금 더 나아가, 얼굴을 땅에 대고 엎드려 기도하셨습니다.

"아버지여, 만일 할 만하시거든 이 잔을 내게서 옮기시옵소서. 그러나 내 원대로 마시옵고, 아버지의 원대로 하옵소서." 그 기도는, 온 존재를 쥐어짜는 듯한 신음에 가까웠습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 12, '기도가 깊어질수록 그분의 고뇌는 극에 달했습니다. 너무도 힘쓰고 애쓰신 나머지, 땀이 마치 핏방울같이 되어 땅에 떨어졌습니다.

그때, 하늘로부터 한 천사가 나타나 그분께 힘을 더하는 듯했습니다. 당신은 난생처음 보는 그 처절한 기도에, 숨소리조차 낼 수 없었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 13, '피땀을 흘리며 땅에 엎드려 기도하는 그분을 지켜보며, 당신의 마음에는 무엇이 일어납니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 14, '당신은 두려웠습니다. 대체 무엇이, 저 한 사람을 저토록 짓누르고 있단 말인가. 핏방울 같은 땀이 떨어지는 그 고통의 무게가, 당신은 감히 짐작조차 되지 않았습니다.

동산의 어둠보다 더 깊은 어둠이, 그분을 에워싸고 있는 것만 같았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 15, '그 기도의 고통이, 멀리서 지켜보는 당신의 가슴까지 짓눌렀습니다. 마치 그분이 짊어진 무언가의 무게가, 동산 전체에 내려앉은 듯했습니다.

당신은 자기도 모르게 두 손을 모은 채, 그 고통이 어서 지나가기만을 함께 빌었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 16, '당신은 "내 원대로 마시옵고, 아버지의 원대로 하옵소서"라는 그 한마디에 멈칫했습니다.

저토록 피하고 싶은 잔을 앞에 두고도, 끝내 자신의 뜻이 아니라 아버지의 뜻을 구하시다니. 그 기도는, 당신이 평생 드려 온 그 어떤 기도와도 달랐습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 17, '한참 만에 기도를 마치고 제자들에게 돌아오신 예수님은, 그들이 모두 잠들어 있는 것을 보셨습니다. "너희가 나와 함께 한 시간도 깨어 있을 수 없더냐?"

그렇게 세 번을 기도하시고 세 번을 돌아오셨지만, 지친 제자들은 번번이 잠에 빠져 있었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 18, '함께 깨어 있어 달라 그토록 부탁하셨건만, 제자들은 잠들어 버렸습니다. 정작 밤을 지키는 당신만이 그 모든 광경을 깨어 지켜보고 있었습니다.

잠든 제자들을 보며, 당신은 무엇을 느낍니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 19, '당신은 답답함이 일었습니다. "스승이 저렇게 죽을 듯이 괴로워하는데, 어떻게 이 밤에 잠이 온단 말인가."

곁을 지켜 달라는 그 간절한 부탁마저 잊은 채 곯아떨어진 제자들이, 당신은 못내 야속하게 느껴졌습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 20, '그러면서도 당신은 그들이 안쓰러웠습니다. 그들 역시 만찬에서 들은 무거운 말들에 마음이 짓눌렸을 테고, 슬픔에 지쳐 쓰러진 것이었으니까요.

"슬픔이 깊으면, 사람은 잠으로 도망치기도 하는 법이지." 당신은 그들을 차마 탓할 수만은 없었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 21, '잠든 제자들을 보며, 당신의 마음 한구석에서 작은 충동이 일었습니다. "그렇다면 나라도, 깨어 그분 곁을 지켜 드리고 싶다."

비록 한낱 동산 경비일 뿐이지만, 저 고독한 기도의 밤에 깨어 있는 한 사람이 되어 드리고 싶었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 22, '마침내 세 번째 기도를 마치고, 예수님이 자리에서 일어나셨습니다. 그 얼굴에는 더 이상 아까의 고뇌가 보이지 않았습니다. 대신 깊고 단단한 평안이 깃들어 있었습니다.

"때가 왔도다. 인자가 죄인들의 손에 넘겨지느니라. 일어나라, 함께 가자." 그 순간, 동산 저편에서 횃불을 든 무리가 다가오는 것이 보였습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 23, '피할 수도 있었던 그 잔을, 끝내 두 손으로 받아 들고 일어서는 그분을 보며, 당신의 마음에는 무엇이 차오릅니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 24, '당신은 그 순종이 두렵도록 위대하게 느껴졌습니다. 그토록 피하고 싶어 피땀을 흘리며 기도했으면서도, 그분은 결국 아버지의 뜻을 향해 스스로 걸어 나가셨습니다.

두려움을 이긴 것이 아니라, 두려움을 끌어안은 채 순종한 것. 당신은 그 앞에서 감히 고개를 들 수 없었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 25, '당신은 가슴이 미어졌습니다. 어둠을 틈타 얼마든지 달아날 수 있었는데, 그분은 도리어 횃불을 향해 걸어 나가셨습니다.

누군가를 위해 스스로 그 잔을 드는 사랑. 당신은 그 사랑이 향하는 곳이 어디인지 다 알 수 없었지만, 그 무게만은 가슴 깊이 느껴졌습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 26, '당신은 부끄러워졌습니다. 당신은 살면서 작은 잔 하나도 피하려 그토록 발버둥 쳤는데.

이분은 가장 쓴 잔을 앞에 두고, 떨면서도 끝내 "아버지의 원대로" 하며 일어서셨습니다. 그 모습 앞에서, 당신의 작은 회피들이 한없이 초라하게 느껴졌습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 27, '횃불을 든 무리가 동산으로 들이닥쳤지만, 그분은 피하지 않으셨습니다. 도리어 그들을 향해 담담히 걸어 나가셨습니다.

그 모습을 끝까지 지켜본 당신은, 오늘 이 밤을 어떻게 품고 살아가시겠습니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 28, '당신은 알게 되었습니다. 살다 보면 누구에게나 피하고 싶은 쓴 잔이 찾아온다는 것을. 그리고 그때, 무릎 꿇고 드릴 단 하나의 기도가 있다는 것을.

"내 원대로 마시옵고, 아버지의 원대로 하옵소서." 당신의 잔이 아무리 써도, 이제 당신은 이 기도를 기억할 것입니다. 두려움을 끌어안은 채 한 걸음 내딛는 그 순종을.

📖 마태복음 26:39
"그러나 나의 원대로 마시옵고 아버지의 원대로 하옵소서"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 29, '횃불에 둘러싸여 끌려가시는 그분의 뒷모습에서, 당신은 끝내 눈을 떼지 못했습니다. 도망칠 수 있었음에도, 스스로 그 길을 택하신 분.

당신은 마음먹습니다. 이 밤이 어디로 이어지든, 이분의 끝을 끝까지 지켜보리라. 이름 없는 한 사람으로, 그 사랑의 끝을 두 눈에 담기 위하여.

📖 마태복음 26:39
"그러나 나의 원대로 마시옵고 아버지의 원대로 하옵소서"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 30, '동산에 다시 정적이 내려앉고, 당신은 텅 빈 올리브 나무 아래에 홀로 섰습니다. 그러나 어제의 당신과 오늘의 당신은 같지 않았습니다.

깊은 밤 홀로 기도할 때마다, 당신은 이 동산을 떠올릴 것입니다. 핏방울 같은 땀과, "아버지의 원대로"라는 그 한마디를. 그것은 잊히지 않을 씨앗이 되어, 당신 안에서 조용히 자라기 시작했습니다.

📖 마태복음 26:39
"그러나 나의 원대로 마시옵고 아버지의 원대로 하옵소서"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade');

  INSERT INTO public.choices (scene_id, label, next_scene_id, choice_order) VALUES
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=1), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '경계심을 품고 멀찍이서 그들을 살핀다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=3), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '낮에 성전에서 본 그 나사렛 선생임을 알아본다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=4), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '이 야심한 시각에 기도하러 온 것이 의아하다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=3), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=4), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), '의외다 — 담대하던 분이 죽음을 두려워하는 인간의 모습이라니', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), '가슴이 철렁한다 — 대체 무슨 일이 닥치기에 저토록 무너지시나', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), '함께 깨어 있어 달라는 그 고독한 부탁이 사무친다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), '두렵다 — 무엇이 저 한 사람을 저토록 짓누르는가', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), '그 기도의 고통이 지켜보는 내 가슴까지 짓누른다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), '''내 원대로 마시옵고 아버지의 원대로''라는 그 한마디에 멈칫한다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), '답답하다 — 스승이 저러는데 어떻게 이 밤에 잠이 오나', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), '안쓰럽다 — 그들도 슬픔에 지쳐 쓰러진 것이겠지', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), '나라도 깨어 그분 곁을 지켜 드리고 싶어진다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), '그 순종이 두렵도록 위대하게 느껴진다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=24), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), '도망칠 수 있었는데 스스로 잔을 드는 그 사랑에 가슴이 미어진다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), '나는 작은 잔도 피하려 발버둥 쳤는데, 부끄럽다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=24), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '내게도 피하고픈 잔이 올 때, ''아버지의 원대로''를 기도하리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=28), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '이렇게까지 하시는 이분을 끝까지 따르리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=29), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '나를 위해 그 잔을 드신 이 밤을, 평생 잊지 않으리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=30), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=28), '챕터 완료', NULL, 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=29), '챕터 완료', NULL, 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=30), '챕터 완료', NULL, 1);

END $$;
