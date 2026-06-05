-- =====================================================================
-- 물 위를 걸으심 (Chapter 6) — 확장판  [자동 생성: _apply.mjs]
-- 컨셉: 플레이어는 '배에서 노를 돕는 어린 일꾼' — 이름 없는 관찰자. 베드로가 되지 않고
--       곁에서 지켜본다. 선택은 성경의 결과를 바꾸지 않고 나의 마음만 바꾼다. 분기는 고정점에서 합류.
-- 본문: 마태복음 14:22-33 (물 위를 걸으심, 베드로의 가라앉음)
-- 구조: 5막 · 30씬 · 분기 6곳 · 엔딩 3개   BGM: morning→throne→snowfield
-- =====================================================================

DO $$
DECLARE chap INT;
BEGIN
  SELECT id INTO chap FROM public.chapters WHERE chapter_num = 6;
  IF chap IS NULL THEN RAISE EXCEPTION 'chapter_num=6 챕터를 찾을 수 없습니다.'; END IF;

  DELETE FROM public.choices WHERE scene_id IN (SELECT id FROM public.scenes WHERE chapter_id = chap);
  DELETE FROM public.scenes WHERE chapter_id = chap;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition) VALUES
    (chap, 1, '오천 명을 먹이신 그 놀라운 저녁 직후, 예수님은 제자들을 재촉해 먼저 배에 태워 보내시고는, 무리를 흩으신 뒤 홀로 기도하러 산에 오르셨습니다.

당신은 이 배에서 노를 돕는 어린 일꾼입니다. 어둠이 내린 호수 위, 제자들과 함께 노를 저으며 그분이 오시기만을 기다리고 있었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066640469-ac2dbd22-e1e5-4a6e-942c-be05036b6436.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 2, '밤이 깊어 갈수록 호수의 바람이 심상치 않게 거세졌습니다. 그분은 아직 오실 기미가 없고, 뭍은 점점 멀어져만 갑니다.

노를 젓는 팔이 천근만근입니다. 이 깊은 밤, 당신은 어떻게 하고 있습니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066640469-ac2dbd22-e1e5-4a6e-942c-be05036b6436.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 3, '당신은 입을 꾹 다물고 노에만 집중합니다. 손바닥이 쓸려 화끈거려도, 지금은 한 뼘이라도 더 나아가는 것이 살길이었습니다.

어부들의 거친 숨소리와 노가 물을 가르는 소리만이 어둠 속에 가득합니다. 당신은 그저 이 밤이 무사히 지나가기만을 바랐습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066640469-ac2dbd22-e1e5-4a6e-942c-be05036b6436.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 4, '당신은 노를 저으면서도 자꾸만 고개를 돌려 어두운 산자락을 살핍니다. "왜 아직 안 오시지? 정말 우리만 두고 가신 건 아니겠지."

홀로 기도하러 가신 그분의 모습이 자꾸 떠올랐습니다. 어쩐지, 그분이 함께 계시지 않은 이 밤이 유난히 더 캄캄하게 느껴졌습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066640469-ac2dbd22-e1e5-4a6e-942c-be05036b6436.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 5, '바람이 휘몰아칠 때마다 배가 출렁이고, 당신의 가슴도 함께 철렁였습니다. "이러다 또 풍랑이 오면 어쩌지."

노련한 어부들조차 이맛살을 찌푸리는 것을 보며, 당신의 불안은 점점 커졌습니다. 칠흑 같은 호수 한가운데, 작은 배 한 척만이 위태롭게 떠 있었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066640469-ac2dbd22-e1e5-4a6e-942c-be05036b6436.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 6, '밤 사경, 그러니까 새벽 세 시에서 여섯 시 사이쯤 되었을 때였습니다. 맞바람이 거세게 불어 큰 파도가 연신 뱃전을 때렸고, 배는 아무리 저어도 좀처럼 나아가지 못했습니다.

바로 그때, 누군가가 시커먼 물결 위를 ''걸어서'' 배 쪽으로 다가오는 것이 보였습니다. 제자들이 혼비백산하여 소리쳤습니다. "유령이다!"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076018986-bbf951a6-bee9-41df-ada4-904328b9d063.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066640469-ac2dbd22-e1e5-4a6e-942c-be05036b6436.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 7, '사람이 물 위를 걷다니. 그것도 이 무서운 파도 위를. 배 안은 순식간에 공포의 비명으로 가득 찼습니다.

그 형체가 점점 가까워지는 가운데, 당신은 어떻게 합니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076018986-bbf951a6-bee9-41df-ada4-904328b9d063.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066640469-ac2dbd22-e1e5-4a6e-942c-be05036b6436.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 8, '당신은 머리카락이 쭈뼛 곤두섰습니다. "죽은 자가 우리를 데리러 온 거야!" 어린 마음에 온갖 무서운 이야기가 한꺼번에 떠올랐습니다.

당신은 두 손으로 얼굴을 가린 채, 제발 저 형체가 사라지기만을 빌었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076018986-bbf951a6-bee9-41df-ada4-904328b9d063.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 9, '당신은 두려움 속에서도 두 눈을 부릅뜨고 그 형체를 응시했습니다. "유령이 저렇게 또렷할 리가… 영락없는 사람의 모습인데."

공포에 떠는 와중에도, 당신의 마음 한구석에서는 자꾸만 다른 생각이 고개를 들었습니다. 혹시, 혹시나 하는 생각이.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076018986-bbf951a6-bee9-41df-ada4-904328b9d063.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 10, '당신은 더 볼 엄두가 나지 않아 노를 내던지고 젖은 뱃바닥에 납작 엎드렸습니다. 심장이 미친 듯이 뛰었습니다.

파도 소리와 사람들의 비명 사이로, 점점 가까워지는 발소리 같은 것이 들리는 듯했습니다. 당신은 숨조차 제대로 쉴 수 없었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076018986-bbf951a6-bee9-41df-ada4-904328b9d063.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 11, '그때, 그 형체에서 익숙하고 잔잔한 목소리가 들려왔습니다. "안심하라, 나니 두려워하지 말라."

예수님이셨습니다! 공포로 얼어붙었던 배 안에 술렁임이 일었습니다. 베드로가 떨리는 목소리로 외쳤습니다. "주여, 만일 주시거든 나를 명하사 물 위로 걸어오라 하소서."', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076018986-bbf951a6-bee9-41df-ada4-904328b9d063.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 12, '당신은 귀를 의심했습니다. 베드로가, 자기도 물 위를 걷게 해 달라고? 이 미친 듯한 파도 위를?

그 담대한, 아니 무모해 보이는 요청을 들으며 당신은 무슨 생각이 듭니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076018986-bbf951a6-bee9-41df-ada4-904328b9d063.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066640469-ac2dbd22-e1e5-4a6e-942c-be05036b6436.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 13, '당신은 베드로가 제정신이 아니라고 생각했습니다. "유령인지 뭔지도 모르는데, 저 파도 속으로 뛰어들겠다고?"

조마조마한 마음으로 베드로를 말리고 싶었지만, 그의 눈은 이미 어둠 속 그분께 단단히 고정되어 있었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076018986-bbf951a6-bee9-41df-ada4-904328b9d063.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 14, '당신의 심장이 이상하게 두근거렸습니다. 두렵기는커녕, 베드로의 그 무모한 용기가 묘하게 가슴을 뛰게 했습니다.

"정말 가능할까? 정말 사람이 물 위를…?" 당신은 자기도 모르게 뱃전으로 바싹 다가가, 베드로의 다음 행동을 숨죽여 지켜보았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076018986-bbf951a6-bee9-41df-ada4-904328b9d063.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 15, '당신은 고개를 숙였습니다. 같은 공포 속에 있으면서도, 베드로는 그분을 향해 손을 내밀고 당신은 그저 떨고만 있었습니다.

"나는 왜 저런 마음을 못 낼까." 부끄러움과 함께, 베드로가 한없이 커 보였습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076018986-bbf951a6-bee9-41df-ada4-904328b9d063.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 16, '예수님의 대답은 단 한마디였습니다. "오라."

놀랍게도 베드로가 정말 배에서 한 발을 내려놓았습니다. 그리고 두 발로, 출렁이는 물 위를 딛고 서서 — 예수님을 향해 한 걸음, 또 한 걸음 걸어 나아갔습니다! 당신은 입을 다물지 못했습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076018986-bbf951a6-bee9-41df-ada4-904328b9d063.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066640469-ac2dbd22-e1e5-4a6e-942c-be05036b6436.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 17, '그런데 베드로가 사나운 바람을 보는 순간, 갑자기 무서움에 사로잡혀 물속으로 빠져들기 시작했습니다. "주여, 나를 구원하소서!"

예수님이 즉시 손을 내밀어 그를 붙드셨습니다. "믿음이 작은 자여, 왜 의심하였느냐?" 그 손은, 한 치의 망설임도 없었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076018986-bbf951a6-bee9-41df-ada4-904328b9d063.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 18, '빠져드는 베드로를 그 즉시 붙들어 올리시는 그분의 손. 당신은 그 광경에서 눈을 뗄 수 없었습니다.

당신의 마음에는 무엇이 차오릅니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076018986-bbf951a6-bee9-41df-ada4-904328b9d063.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 19, '당신은 자기도 모르게 참았던 숨을 길게 내쉬었습니다. 베드로가 그대로 물속으로 사라질까 봐, 당신의 심장도 함께 가라앉던 참이었습니다.

그분의 손에 붙들려 올라오는 베드로를 보며, 당신은 안도의 눈물이 핑 도는 것을 느꼈습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076018986-bbf951a6-bee9-41df-ada4-904328b9d063.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 20, '베드로를 향한 그 말씀이, 이상하게도 당신의 가슴을 찔렀습니다. "의심하였느냐." 당신이라고 달랐을까.

물 위에 발을 디딜 용기는커녕, 뱃바닥에 엎드려 떨기만 했던 당신이었습니다. 베드로의 흔들림은, 곧 당신 자신의 흔들림이기도 했습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076018986-bbf951a6-bee9-41df-ada4-904328b9d063.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 21, '당신의 코끝이 찡해졌습니다. 베드로가 미처 다 부르짖기도 전에, 그분의 손은 이미 그를 향해 뻗어 있었습니다.

빠져드는 자를 책망하기보다 먼저 붙드는 손. 당신은 그 즉각적인 사랑 앞에서, 가슴 깊은 곳이 따뜻하게 저려 오는 것을 느꼈습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076018986-bbf951a6-bee9-41df-ada4-904328b9d063.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 22, '예수님과 베드로가 배에 오르자, 그토록 사납던 바람이 거짓말처럼 뚝 그쳤습니다.

배 안의 모두가, 그리고 당신도, 그분 앞에 엎드려 절하며 고백했습니다. "진실로 하나님의 아들이로소이다." 그 누구도 더는 의심할 수 없었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 23, '"하나님의 아들." 그 고백이 잔잔해진 호수 위로 퍼져 나갔습니다. 밤새 노만 젓던 당신의 가슴에도 그 말이 깊이 내려앉았습니다.

당신은 이 고백 앞에서, 어떻게 합니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 24, '당신은 자연스레 무릎을 꿇었습니다. 누가 시킨 것이 아니라, 방금 본 것이 당신을 그렇게 만들었습니다.

유령인 줄 알았던 분이, 물과 바람을 다스리는 분이, 빠지는 자를 붙드는 분이. 당신은 고개를 숙인 채 그 거룩함 앞에 오래 머물렀습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 25, '''하나님의 아들''이라는 말이, 당신의 가슴속에서 종소리처럼 울렸습니다. 막연히 ''대단한 선생''이라 여겼던 분이었는데.

오늘 밤 두 눈으로 본 모든 일이, 그 한마디 고백으로 비로소 설명되는 듯했습니다. 당신은 그 말을 가슴에 꼭꼭 새겼습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 26, '당신은 부끄러움에 고개를 들 수 없었습니다. 밤새 그분을 의심하고, 두려움에 떨며 뱃바닥에 엎드려 있던 자신이 떠올랐으니까.

"그분은 늘 우리를 향해 오고 계셨는데." 당신은 다짐했습니다. 다시 어두운 밤이 와도, 이제는 그 손길을 신뢰하기로.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 27, '어느새 동녘 하늘이 희붐하게 밝아 오고, 배는 무사히 건너편 게네사렛 땅에 닿았습니다.

물 위를 걷던 그 밤을, 당신은 이제 어떻게 품고 살아가시겠습니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 28, '당신은 알게 되었습니다. 인생이라는 캄캄한 호수 위, 맞바람이 부는 밤은 누구에게나 찾아온다는 것을. 그리고 바로 그때, 그분이 물 위를 걸어 다가오신다는 것을.

다시 두려움에 빠져들 때면, 당신은 오늘을 기억할 것입니다. 부르짖는 순간 곧바로 뻗어 오던 그 손과, 잔잔한 음성을. "나니, 두려워하지 말라."

📖 마태복음 14:31
"예수께서 즉시 손을 내밀어 그를 붙잡으시며 이르시되 믿음이 작은 자여 왜 의심하였느냐"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 29, '날이 밝아도, 당신은 그분 곁을 떠나고 싶지 않았습니다. 물과 바람을 다스리고, 빠지는 자를 붙드는 분. 알면 알수록 더 알고 싶어지는 분.

당신은 작은 일꾼으로나마 계속 그분의 배에 남기로 합니다. 이름 없는 한 사람으로, 그분이 가시는 길을 끝까지 따라가 보기 위하여.

📖 마태복음 14:31
"예수께서 즉시 손을 내밀어 그를 붙잡으시며 이르시되 믿음이 작은 자여 왜 의심하였느냐"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 30, '당신은 다시 노를 젓는 평범한 일꾼의 일상으로 돌아갑니다. 그러나 어제의 당신과 오늘의 당신은 같지 않았습니다.

바람 부는 밤 호수를 볼 때마다, 당신은 그 새벽을 떠올릴 것입니다. 사람이 물 위를 걷고, 빠지는 자를 붙들던 그 손을. 그것은 잊히지 않을 씨앗이 되어, 당신 안에서 조용히 자라기 시작했습니다.

📖 마태복음 14:31
"예수께서 즉시 손을 내밀어 그를 붙잡으시며 이르시되 믿음이 작은 자여 왜 의심하였느냐"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade');

  INSERT INTO public.choices (scene_id, label, next_scene_id, choice_order) VALUES
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=1), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '지친 팔을 다잡으며 묵묵히 노를 젓는다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=3), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '자꾸만 산 쪽을 돌아보며 그분을 기다린다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=4), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '점점 거세지는 바람에 불안한 마음을 감추지 못한다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=3), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=4), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), '정말 유령이라 믿고 공포에 사로잡혀 떤다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), '유령일 리 없다며, 눈을 비비고 다시 본다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), '노를 놓아 버리고 뱃바닥에 납작 엎드린다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), '''제정신인가? 물 위를 걷겠다니!'' 아연실색한다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), '말도 안 되지만, 베드로의 그 용기에 가슴이 두근거린다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), '''나라면 절대 입도 못 뗄 텐데…'' 부끄러워진다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), '''아, 다행이다'' 안도하며 가슴을 쓸어내린다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), '''나였어도 똑같이 의심했겠지'' 가슴이 뜨끔하다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), '부르짖자마자 곧바로 내미시는 그 손길에 코끝이 찡해진다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), '사람들과 함께 무릎을 꿇고 그분께 절한다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=24), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), '''하나님의 아들''이라는 그 말이 가슴 깊이 울린다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), '밤새 의심하고 떨기만 한 내가 부끄럽다 — 이제 그분을 신뢰하리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=24), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '의심과 두려움이 밀려올 때마다, ''나니 두려워 말라''를 기억하리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=28), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '이분이 정말 누구신지, 끝까지 따르며 알아 가리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=29), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '사람이 물 위를 걷던 그 밤을, 평생 가슴에 새겨 두리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=30), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=28), '챕터 완료', NULL, 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=29), '챕터 완료', NULL, 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=30), '챕터 완료', NULL, 1);

END $$;
