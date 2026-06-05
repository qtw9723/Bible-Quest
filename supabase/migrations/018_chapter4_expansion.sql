-- =====================================================================
-- 풍랑을 잠재우심 (Chapter 4) — 확장판  [자동 생성: _apply.mjs]
-- 컨셉: 플레이어는 '예수님의 배에 함께 탄 어린 일꾼' — 이름 없는 관찰자.
--       선택은 성경의 결과를 바꾸지 않고 나의 위치/마음/행동만 바꾼다. 분기는 고정점에서 합류.
-- 본문: 마가복음 4:35-41 (광풍을 잠잠케 하심)
-- 구조: 5막 · 28씬 · 분기 6곳 · 엔딩 3개   BGM: morning→throne→snowfield
-- =====================================================================

DO $$
DECLARE chap INT;
BEGIN
  SELECT id INTO chap FROM public.chapters WHERE chapter_num = 4;
  IF chap IS NULL THEN RAISE EXCEPTION 'chapter_num=4 챕터를 찾을 수 없습니다.'; END IF;

  DELETE FROM public.choices WHERE scene_id IN (SELECT id FROM public.scenes WHERE chapter_id = chap);
  DELETE FROM public.scenes WHERE chapter_id = chap;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition) VALUES
    (chap, 1, '해가 갈릴리 호수 너머로 붉게 잠기던 저녁, 예수님이 제자들에게 말씀하셨습니다. "우리가 호수 저편으로 건너가자."

당신은 이 배에서 잔심부름을 하는 어린 일꾼입니다. 노 젓는 어부들 틈에서 짐을 나르고 물을 푸는 것이 당신의 몫이지요. 호수는 더없이 잔잔해 보였습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066640469-ac2dbd22-e1e5-4a6e-942c-be05036b6436.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 2, '여러 척의 배가 함께 어스름 속으로 미끄러져 나아갔습니다. 하루 종일 무리를 가르치느라 지치셨는지, 예수님은 배 고물에서 베개를 베고 어느새 깊이 잠드셨습니다.

노를 젓는 어부들의 숨소리와 물결 소리만이 가득합니다. 당신은 무엇을 합니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 3, '당신은 어부들 사이를 오가며 물자루를 나르고 밧줄을 정리합니다. 베드로의 굵은 팔뚝이 노를 당길 때마다 배가 묵직하게 앞으로 나아갑니다.

"오늘은 바람도 잔잔하니 금방 닿겠구나." 누군가 안도하듯 중얼거렸습니다. 당신도 그 말에 마음을 놓았습니다. 적어도, 그때까지는.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066640469-ac2dbd22-e1e5-4a6e-942c-be05036b6436.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 4, '당신은 고물 한쪽에 웅크려, 잠드신 예수님의 얼굴을 가만히 바라봅니다. 온 갈릴리를 들썩이게 하는 분이, 이렇게 평범한 사람처럼 곤히 잠드시다니.

그 얼굴엔 어떤 근심의 그림자도 없었습니다. 마치 세상의 무엇도 그분의 평안을 깨뜨릴 수 없다는 듯이. 당신은 그 고요함이 까닭 없이 부러웠습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 5, '그런데 호수 한가운데에 이르렀을 때였습니다. 난데없이 거센 광풍이 산골짜기에서 쏟아져 내리더니, 순식간에 물결이 집채만 하게 솟구쳤습니다.

파도가 뱃전을 넘어 배 안으로 쏟아져 들어왔습니다. 배가 기우뚱거리며 거의 잠길 지경이 되자, 노련한 어부들의 얼굴마저 새파랗게 질렸습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075872351-5ae29af8-4945-48da-a34a-7a75dfbbebd7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066640469-ac2dbd22-e1e5-4a6e-942c-be05036b6436.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 6, '발목까지, 이내 무릎까지 물이 차오릅니다. 어둠 속에서 사람들의 고함과 비명이 뒤엉킵니다. 당신의 손이 부들부들 떨립니다.

이 아수라장 속에서, 당신은 무엇을 합니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075872351-5ae29af8-4945-48da-a34a-7a75dfbbebd7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066640469-ac2dbd22-e1e5-4a6e-942c-be05036b6436.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 7, '당신은 함지박을 붙들고 미친 듯이 물을 퍼냅니다. 그러나 퍼내는 속도보다 쏟아져 들어오는 물이 몇 배는 빨랐습니다.

팔이 끊어질 듯 아프고, 짠물이 눈과 입으로 들이쳤습니다. "이러다… 정말 다 죽겠구나." 아무리 발버둥 쳐도 사람의 힘으로는 어찌할 수 없는 밤이었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075872351-5ae29af8-4945-48da-a34a-7a75dfbbebd7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066640469-ac2dbd22-e1e5-4a6e-942c-be05036b6436.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 8, '당신은 돛줄을 두 손으로 감아쥐고 이를 악뭅니다. 배가 한쪽으로 곤두박질칠 때마다, 검은 물속으로 빨려 들어갈 것만 같았습니다.

저 멀리 함께 떠났던 다른 배들의 등불이 어둠 속에서 정신없이 흔들립니다. 그들도, 당신도, 이 거대한 물결 앞에서는 한낱 나뭇잎에 불과했습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075872351-5ae29af8-4945-48da-a34a-7a75dfbbebd7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066640469-ac2dbd22-e1e5-4a6e-942c-be05036b6436.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 9, '물이 차오르는 아수라장 속에서도, 당신의 눈은 자꾸만 고물로 향합니다. 이 난리통에도 예수님은 여전히 베개를 베고 주무시고 계셨습니다.

"어떻게 이 와중에…?" 깨워야 할지, 그래도 될지 알 수 없어 당신은 그저 발만 동동 굴렀습니다. 두려움과 당혹감이 뒤엉켜 목이 메었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075872351-5ae29af8-4945-48da-a34a-7a75dfbbebd7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 10, '마침내 제자들이 더는 견디지 못하고 고물로 달려가 예수님을 흔들어 깨웠습니다. 그들의 목소리엔 원망과 공포가 뒤섞여 있었습니다.

"선생님이여, 우리가 죽게 된 것을 돌아보지 아니하시나이까?" 당신 역시 그 절박한 외침 한가운데에 서 있었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075872351-5ae29af8-4945-48da-a34a-7a75dfbbebd7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 11, '예수님이 천천히 몸을 일으키십니다. 폭풍 속에서도 그분의 움직임만은 이상하리만치 서두름이 없었습니다.

그 모습을 보는 당신의 마음속에는, 어떤 생각이 스칩니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075872351-5ae29af8-4945-48da-a34a-7a75dfbbebd7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 12, '솔직히, 당신의 가슴 한구석에서는 원망이 솟구쳤습니다. "다들 죽어 나가는데 어떻게 그렇게 태평하게 주무실 수가 있나."

그러나 그렇게 원망하면서도 당신은 알고 있었습니다. 지금 이 배 안에서, 마지막 희망이 있다면 그것은 방금 깨어난 저분뿐이라는 것을.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075872351-5ae29af8-4945-48da-a34a-7a75dfbbebd7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 13, '당신은 지푸라기라도 잡는 심정으로 그분을 바라봅니다. "이분이라면… 이 무서운 폭풍도 어떻게든 해주시지 않을까."

무엇을 근거로 그런 마음이 드는지 당신 자신도 알 수 없었습니다. 다만 그 잠든 얼굴의 평안이, 이 절망 속에서 단 하나의 빛처럼 느껴졌습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075872351-5ae29af8-4945-48da-a34a-7a75dfbbebd7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 14, '당신은 아무 말도 할 수 없었습니다. 공포가 목구멍을 틀어막아, 그저 깨어나신 그분의 얼굴만 뚫어지게 바라볼 뿐이었습니다.

이상하게도, 그분과 눈이 마주친 순간 비명조차 멎었습니다. 곧 무슨 일이 일어날 것만 같은, 숨 막히는 예감이 온몸을 휘감았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075872351-5ae29af8-4945-48da-a34a-7a75dfbbebd7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 15, '예수님이 일어나 바람을 꾸짖으시고, 미쳐 날뛰던 바다를 향해 말씀하셨습니다.

"잠잠하라. 고요하라." 단 두 마디였습니다. 그러자 거짓말처럼, 그 사납던 바람이 뚝 그치고 물결이 잔잔해졌습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 16, '순식간의 일이었습니다. 방금 전까지 집채만 한 파도가 배를 삼키려 했는데, 이제 호수는 기름을 부은 듯 매끄럽고 고요했습니다.

사방에 정적만이 가득합니다. 거친 숨을 몰아쉬던 사람들조차 입을 다물었습니다. 당신은 방금 두 눈으로 본 것을, 도무지 믿을 수가 없었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 17, '물결에 비친 별빛이 잔잔하게 흔들립니다. 방금까지의 아수라장이 마치 한바탕 악몽이었던 것처럼.

당신의 몸은, 이 갑작스러운 고요 앞에서 어떻게 반응합니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 18, '팽팽하던 긴장의 끈이 한순간에 끊어지며, 당신은 젖은 뱃바닥에 털썩 주저앉습니다. 다리에 힘이 하나도 들어가지 않았습니다.

살았다는 안도와, 방금 본 것에 대한 경외가 한꺼번에 밀려와 온몸이 떨렸습니다. 당신은 차가운 뱃전을 붙든 채, 한참을 그렇게 숨만 골랐습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 19, '당신의 팔뚝에 오스스 소름이 돋았습니다. 바람과 바다가 — 그 누구도 길들일 수 없는 자연이 — 한 사람의 말 한마디에 순순히 잠잠해지다니.

"대체… 어떻게 이런 일이." 두려움과는 다른, 더 깊고 서늘한 무언가가 당신의 가슴을 가득 채웠습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 20, '예수님이 아직도 사색이 된 제자들을 돌아보며 말씀하셨습니다. "어찌하여 이렇게 무서워하느냐? 너희가 어찌 믿음이 없느냐?"

제자들은 심히 두려워하며 서로 수군거렸습니다. "그가 누구이기에, 바람과 바다도 그에게 순종하는가?" 그 물음이 잔잔한 수면 위로 무겁게 내려앉았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 21, '"어찌 믿음이 없느냐." 그 말씀은 제자들만이 아니라, 구석에서 떨고 있던 당신의 가슴에도 곧장 와 박혔습니다.

잔잔해진 호수를 바라보며, 당신의 마음엔 어떤 생각이 차오릅니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 22, '당신은 깨달았습니다. 정말로 두려워해야 할 것은 풍랑이 아니었음을. 그 풍랑마저 한마디로 잠재우는 분이, 지금 이 작은 배 위에 함께 계시다는 사실이었습니다.

그 거룩한 두려움 앞에서, 당신은 차마 고개를 들 수 없었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 23, '당신은 자신이 부끄러워졌습니다. 그분이 바로 곁에 계셨는데도, 당신은 마치 혼자 버려진 것처럼 떨며 절망했습니다.

"함께 계신 것만으로는 충분하지 않다고 여겼구나." 어쩌면 믿음이란, 풍랑이 없는 것이 아니라 풍랑 속에서도 그분이 함께 계심을 기억하는 것인지도 몰랐습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 24, '제자들이 던진 그 물음이, 이제 당신 자신의 물음이 되었습니다. "그가 누구이기에, 바람과 바다도 순종하는가?"

어부도, 임금도, 그 누구도 자연을 다스릴 수는 없습니다. 그런데 이분은. 당신은 그 답을 알 수 없었지만, 어떻게든 그 답을 찾고 싶어졌습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 25, '마침내 배가 잔잔한 물살을 가르며 호수 저편 기슭에 닿았습니다. 발을 디딘 땅이 그렇게 든든할 수가 없었습니다.

오늘 밤의 풍랑을, 당신은 이제 어떻게 품고 살아가시겠습니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 26, '당신은 알게 되었습니다. 살다 보면 누구에게나 한밤의 풍랑이 닥친다는 것을. 그러나 그 풍랑보다 크신 분이 같은 배에 타고 계시다는 것을.

다시 두려운 밤이 와도, 당신은 오늘을 기억할 것입니다. 그분이 잔잔하게 건네신 그 한마디를. "잠잠하라, 고요하라."

📖 마가복음 4:39
"잠잠하라, 고요하라 하시니 바람이 그치고 아주 잔잔하여지더라"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 27, '기슭에 내린 뒤에도, 당신은 그분에게서 눈을 떼지 못합니다. 도무지 알 수 없는 분, 그러나 곁에 있으면 이상하게 마음이 놓이는 분.

당신은 작은 일꾼으로나마 그분의 배에 계속 남기로 합니다. 이름 없는 한 사람으로, 그분이 누구신지 두 눈으로 끝까지 지켜보기 위하여.

📖 마가복음 4:39
"잠잠하라, 고요하라 하시니 바람이 그치고 아주 잔잔하여지더라"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 28, '당신은 다시 평범한 일꾼의 일상으로 돌아갑니다. 짐을 나르고, 물을 푸고, 그물을 손질하는 날들.

그러나 잔잔한 호수를 볼 때마다, 당신은 그 밤을 떠올릴 것입니다. 죽음 같던 풍랑이 한마디에 잠잠해지던 순간을. 그 기억은 잊히지 않을 씨앗이 되어, 당신 안에서 조용히 자라기 시작했습니다.

📖 마가복음 4:39
"잠잠하라, 고요하라 하시니 바람이 그치고 아주 잔잔하여지더라"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade');

  INSERT INTO public.choices (scene_id, label, next_scene_id, choice_order) VALUES
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=1), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '노 젓는 어부들 곁에서 부지런히 일손을 돕는다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=3), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '곤히 주무시는 그분을 신기한 듯 가만히 바라본다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=4), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=3), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=4), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), '함지박을 붙잡고 필사적으로 물을 퍼낸다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), '돛줄을 움켜쥐고 뒤집히지 않으려 버틴다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), '주무시는 예수님을 차마 깨우지도 못하고 발만 동동 구른다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), '''이 지경이 되도록 주무시다니'' 원망이 솟구친다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), '''그래도 이분이라면 뭐라도 해주시겠지'' 매달리는 심정이 된다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), '두려움에 아무 생각도 못 한 채 그분만 뚫어지게 바라본다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), '긴장이 한꺼번에 풀려 그 자리에 털썩 주저앉는다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), '온몸에 소름이 돋는다 — 바람과 바다가 사람의 말을 듣다니', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), '풍랑보다도, 풍랑을 잠재운 그분이 더 두렵고 놀랍다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), '그분이 함께 계셨는데, 나는 왜 그토록 떨기만 했을까', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), '''그가 누구신가'' — 그 물음이 머릿속을 떠나지 않는다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=24), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=24), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), '내 인생에 풍랑이 닥쳐도, 그분이 ''잠잠하라'' 하실 것을 믿으리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), '이분이 정말 누구신지, 끝까지 이 배에 남아 알아보리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), '오늘 본 이 일을, 평생 가슴에 새겨 두고 잊지 않으리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=28), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), '챕터 완료', NULL, 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '챕터 완료', NULL, 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=28), '챕터 완료', NULL, 1);

END $$;
