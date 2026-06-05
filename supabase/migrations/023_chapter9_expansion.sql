-- =====================================================================
-- 나사로를 살리심 (Chapter 9) — 확장판  [자동 생성: _apply.mjs]
-- 컨셉: 플레이어는 '나사로 가족의 오랜 벗인 마을 사람' — 이름 없는 관찰자.
--       선택은 성경의 결과를 바꾸지 않고 나의 마음만 바꾼다. 분기는 고정점에서 합류.
-- 본문: 요한복음 11:1-44 (나사로를 살리심, 예수께서 우심)
-- 구조: 6막 · 30씬 · 분기 6곳 · 엔딩 3개   BGM: snow→throne→snow
-- =====================================================================

DO $$
DECLARE chap INT;
BEGIN
  SELECT id INTO chap FROM public.chapters WHERE chapter_num = 9;
  IF chap IS NULL THEN RAISE EXCEPTION 'chapter_num=9 챕터를 찾을 수 없습니다.'; END IF;

  DELETE FROM public.choices WHERE scene_id IN (SELECT id FROM public.scenes WHERE chapter_id = chap);
  DELETE FROM public.scenes WHERE chapter_id = chap;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition) VALUES
    (chap, 1, '예루살렘에서 가까운 베다니 마을. 마리아와 마르다 자매가 급히 예수님께 사람을 보내 전했습니다. "주여, 보시옵소서. 주께서 사랑하시는 자가 병들었나이다."

당신은 이 마을 사람으로, 나사로의 가족과 오랜 세월 정을 나눠 온 벗입니다. 침상에 누운 나사로의 거친 숨소리에, 당신의 마음도 타들어 갔습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076504415-6b0f0f7f-421c-4c5d-bcc1-b61880e50f4a.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 2, '나사로의 병세는 시간이 갈수록 깊어만 갔습니다. 자매들은 문밖을 내다보며 예수님이 오시기만을 애타게 기다렸습니다.

그러나 그분은 좀처럼 오실 기미가 없었습니다. 친구의 병상 곁에서, 당신은 어떻게 하고 있습니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076504415-6b0f0f7f-421c-4c5d-bcc1-b61880e50f4a.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 3, '당신은 밤을 새워 가며 나사로의 이마를 닦고 물을 떠 먹였습니다. 그러면서도 자꾸만 마을 어귀로 눈이 갔습니다.

"조금만, 조금만 더 버티게. 그분이 곧 오실 거야." 당신은 그 한 가지 희망에 매달려, 친구의 손을 꼭 붙들었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 4, '당신은 도무지 영문을 알 수 없었습니다. 멀리 있는 병자도 말씀 한마디로 고치신다는 분이, 그토록 사랑하는 친구가 죽어 가는데 어찌 오지 않으시는지.

"전갈은 분명히 받으셨을 텐데…" 기다림이 길어질수록, 당신의 마음속엔 작은 서운함이 자라났습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 5, '당신은 흐느끼는 자매들의 등을 쓸어내리며 위로했습니다. "마르다, 마리아, 너무 걱정 말아요. 그분이 분명 오실 거예요."

그러나 그렇게 말하는 당신의 목소리도 떨리고 있었습니다. 다 함께, 한 가닥 희망에 매달려 그 긴 시간을 견뎠습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 6, '그러나 끝내, 나사로는 숨을 거두고 말았습니다. 그토록 기다린 그분은 오지 않으셨고, 사람들은 그의 시신을 베로 싸 무덤에 안장했습니다.

무덤 입구는 큰 돌로 막혔습니다. 온 마을이 슬픔에 잠겼고, 자매들의 통곡 소리가 며칠 밤낮으로 그치지 않았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 7, '나사로가 무덤에 묻힌 지 나흘이 지나도록, 예수님은 여전히 오지 않으셨습니다. 이제는 다 끝난 일이었습니다.

그분을 향한 당신의 마음은, 어떻습니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 8, '당신의 가슴엔 원망이 차올랐습니다. "사랑하는 자가 병들었다"는 전갈을 받고도, 그분은 끝내 오지 않으셨습니다.

"그렇게 아끼시던 친구인데… 어떻게 이러실 수가." 슬픔보다 서운함이, 서운함보다 원망이 당신의 마음을 짓눌렀습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 9, '당신은 깊은 실망에 잠겼습니다. 어쩌면 그분에게 너무 큰 기대를 걸었던 것인지도 모릅니다.

"역시 죽음 앞에서는, 그분도 별수 없으신 건가." 마음 한구석에서 피어오르던 믿음의 불씨가, 차갑게 사그라드는 것 같았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 10, '당신은 머리로는 이해할 수 없었지만, 마음으로는 끝까지 믿어 보기로 했습니다. 그분이 까닭 없이 늦으실 분은 아니라고.

"비록 너무 늦었지만… 분명 무슨 뜻이 있으실 거야." 무너지는 슬픔 속에서도, 당신은 그 마지막 신뢰의 끈을 놓지 않았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 11, '바로 그때, 예수님이 마을에 들어오신다는 소식이 들렸습니다. 마르다가 한달음에 달려 나가 그분 앞에 엎드렸습니다. "주께서 여기 계셨더라면, 내 오라버니가 죽지 아니하였겠나이다."

예수님이 말씀하셨습니다. "네 오라비가 다시 살아나리라. 나는 부활이요 생명이니, 나를 믿는 자는 죽어도 살겠고, 살아서 나를 믿는 자는 영원히 죽지 아니하리라."', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 12, '차디찬 무덤을 눈앞에 두고, 그분은 "나는 부활이요 생명"이라 선언하셨습니다. 죽음이 모든 것을 끝낸 그 자리에서.

그 말씀 앞에서, 당신의 마음은 어떠합니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 13, '당신은 고개를 떨구었습니다. 부활이요 생명이라니. 나흘이나 무덤에 누워 이미 썩어 가는 친구를 두고 하시는 말씀이라기엔, 너무 아득했습니다.

"말씀은 위로가 되지만… 죽은 사람이 어떻게." 당신의 머리로는 그 선언을 도무지 받아들일 수 없었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 14, '그 말씀을 듣는 순간, 당신의 등줄기에 서늘한 떨림이 지나갔습니다. 슬픔에 잠겨 건네는 빈말이 아니었습니다.

마치 죽음 그 자체를 정면으로 마주하고 선언하는 듯한, 두려우리만치 단호한 음성. 당신은 그 말씀의 무게에 숨을 죽였습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 15, '당신은 그 말씀에 한 가닥 희망을 붙들었습니다. 비록 믿기 어려운 말이었지만, 만에 하나, 정말 만에 하나라도.

"정말 그럴 수만 있다면…" 당신은 차마 입 밖에 내지 못한 그 바람을, 가슴 깊이 끌어안았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 16, '잠시 후 마리아도 달려 나와 그분 발 앞에 엎드려 울었습니다. 함께 온 마을 사람들도 따라 울었습니다.

그 모습을 보시고, 예수님은 심령에 비통히 여기시며 괴로워하셨습니다. 그러고는 — 눈물을 흘리셨습니다. 전능하신 그분이, 친구의 무덤 앞에서 소리 없이 울고 계셨습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 17, '당신은 그 눈물을 보며 멈칫했습니다. 곧 무슨 일이라도 하실 수 있는 분이, 어찌하여 우리와 함께 우시는 걸까.

그분의 눈물을 보는 당신의 마음에는, 무엇이 일어납니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 18, '당신은 의아했습니다. 곧 놀라운 일을 행하실 분이라면, 슬퍼할 이유가 없지 않은가.

그러나 그분의 눈물은 연기가 아니었습니다. 진심으로 비통해하는 그 모습 앞에서, 당신은 능력보다 먼저 그 마음을 헤아리게 되었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 19, '당신의 가슴이 미어졌습니다. 그분은 슬픔을 멀리서 내려다보지 않으셨습니다. 우리 한가운데로 들어와, 우리와 똑같이 우셨습니다.

"이분은 우리의 아픔을 함께 지시는 분이구나." 그 눈물 한 방울이, 어떤 위로의 말보다 당신의 마음을 깊이 어루만졌습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 20, '그분의 눈물을 보는 순간, 당신의 가슴 깊은 곳이 뜨겁게 풀어졌습니다. 아무도 온전히 알아주지 못하던 당신의 슬픔까지, 그분이 함께 울어 주는 것 같았습니다.

"내 눈물을 아시는 분이 여기 계시는구나." 당신은 그분 곁에서, 마음 놓고 함께 울었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 21, '예수님이 무덤 앞에 서시더니 말씀하셨습니다. "돌을 옮겨 놓으라." 마르다가 놀라 만류했습니다. "주여, 죽은 지 나흘이 되었으니 벌써 냄새가 나나이다."

예수님이 말씀하셨습니다. "내 말이, 네가 믿으면 하나님의 영광을 보리라 하지 아니하였느냐?" 사람들이 머뭇거리며 무덤의 큰 돌을 옮겼습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 22, '예수님이 눈을 들어 하늘을 향해 기도하신 후, 큰 소리로 외치셨습니다.

"나사로야, 나오라!" 그 순간 — 나흘 전 죽어 무덤에 묻혔던 나사로가, 수족이 베로 동인 채 무덤에서 걸어 나왔습니다. 사람들 사이에서 비명 같은 탄성이 터져 나왔습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 23, '죽은 사람이, 무덤에서, 제 발로 걸어 나오고 있었습니다. 당신은 두 눈으로 그것을 보면서도 도무지 믿을 수가 없었습니다.

당신의 몸은 어떻게 반응합니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 24, '당신은 다리에 힘이 풀려 그 자리에 주저앉고 말았습니다. 방금 본 것이 도무지 현실 같지 않았습니다.

나흘이나 무덤에 있던 사람이, 살아서 걸어 나오다니. 당신은 떨리는 손으로 땅을 짚은 채, 그저 그 광경을 바라볼 수밖에 없었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 25, '당신의 팔뚝에 소름이 쫙 돋았습니다. 풍랑도, 병도 아니었습니다. 죽음 — 그 누구도 거스를 수 없는 마지막 한계마저, 그분의 음성 한마디에 순순히 물러섰습니다.

"이분은… 대체 누구신가." 당신은 거룩한 두려움에 사로잡혀, 차마 숨도 크게 쉴 수 없었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 26, '당신의 눈에서 기쁨의 눈물이 왈칵 쏟아졌습니다. 다시는 볼 수 없을 줄 알았던 친구가, 살아서 당신 앞에 서 있었습니다.

"나사로! 나사로가 살아났어!" 슬픔으로 가득했던 무덤가가, 순식간에 믿을 수 없는 환희로 뒤바뀌었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 27, '예수님이 말씀하셨습니다. "풀어 놓아 다니게 하라." 베가 풀리고, 자매들이 울며 살아난 나사로를 끌어안았습니다.

죽음 앞에서 함께 우시고, 또 그 죽음을 이기신 그분을. 당신은 오늘을 어떻게 품고 살아가시겠습니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 28, '당신은 알게 되었습니다. 인생에는 끝내 막을 수 없는 죽음과 이별이 있다는 것을. 그러나 그 무덤 앞에서조차, "나오라" 부르시는 분이 계시다는 것을.

당신의 삶에 캄캄한 무덤 같은 날이 와도, 이제 당신은 기억할 것입니다. 죽음마저 그분의 음성에 순종했음을. 그분은 부활이요, 생명이시니까요.

📖 요한복음 11:25
"나는 부활이요 생명이니 나를 믿는 자는 죽어도 살겠고"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 29, '당신은 이분이 더없이 궁금해졌습니다. 죽음 앞에서 함께 눈물 흘리시고, 또 그 죽음을 한마디로 물리치신 분.

나사로의 손을 마주 잡고 기뻐하면서도, 당신의 마음은 이미 그분을 향하고 있었습니다. 이름 없는 한 사람으로, 이 놀라운 분을 끝까지 따라가 보기로.

📖 요한복음 11:25
"나는 부활이요 생명이니 나를 믿는 자는 죽어도 살겠고"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 30, '당신은 다시 베다니의 평범한 일상으로 돌아갑니다. 그러나 어제의 당신과 오늘의 당신은 같지 않았습니다.

무덤가를 지날 때마다, 당신은 그날을 떠올릴 것입니다. 친구의 죽음 앞에서 함께 우시던 그 눈물과, "나사로야 나오라" 부르시던 그 음성을. 그것은 잊히지 않을 씨앗이 되어, 당신 안에서 조용히 자라기 시작했습니다.

📖 요한복음 11:25
"나는 부활이요 생명이니 나를 믿는 자는 죽어도 살겠고"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade');

  INSERT INTO public.choices (scene_id, label, next_scene_id, choice_order) VALUES
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=1), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '곁에서 정성껏 간호하며, 그분이 오시기를 애타게 기다린다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=3), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '''그분이라면 단번에 고치실 텐데, 왜 아직 안 오시나'' 의아해한다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=4), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '무너지는 자매들을 다독이며, 함께 마음을 졸인다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=3), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=4), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), '원망스럽다 — 사랑하신다면서, 어떻게 끝내 오지 않으셨나', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), '실망스럽다 — 그분께 걸었던 기대가, 다 헛된 것이었나', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), '이해할 수 없어도, 무슨 뜻이 있으시겠지 끝까지 믿어 본다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), '죽음 앞에서 그런 말씀을 하시다니, 솔직히 믿기 어렵다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), '그 흔들림 없는 선언에, 가슴이 서늘하게 떨려 온다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), '정말 그렇다면… 한 가닥 희망이라도 붙들고 싶다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), '의외다 — 살리실 능력이 있으면서, 왜 굳이 우시는 걸까', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), '가슴이 미어진다 — 우리의 슬픔을 외면치 않고 함께 우시는구나', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), '그 눈물에, 외롭던 내 슬픔까지 위로받는 것 같다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), '다리가 풀려 그 자리에 털썩 주저앉는다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=24), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), '온몸에 소름이 돋는다 — 죽음마저 그분의 음성에 순종하다니', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), '기쁨의 눈물이 터진다 — 친구가, 나사로가 살아 돌아왔다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=24), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '내 삶의 무덤 앞에서도, 나를 부르시는 그분의 음성을 믿으리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=28), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '죽음마저 이기시는 이분이 누구신지, 끝까지 따르며 알아 가리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=29), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '함께 울어 주시고 다시 살리신 그분을, 평생 잊지 않으리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=30), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=28), '챕터 완료', NULL, 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=29), '챕터 완료', NULL, 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=30), '챕터 완료', NULL, 1);

END $$;
