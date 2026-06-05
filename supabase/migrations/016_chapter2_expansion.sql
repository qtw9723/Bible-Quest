-- =====================================================================
-- 광야의 시험 (Chapter 2) — 확장판 시나리오  [자동 생성: build_apply_ch2.mjs]
-- =====================================================================
-- 컨셉: 플레이어는 '광야 끝자락의 어린 목동' — 이름 없는 관찰자.
--       선택은 성경의 결과(예수님이 시험을 이기심)를 바꾸지 않으며,
--       오직 '나 자신'의 위치/마음/주변 행동만 바꾼다. 분기는 고정점에서 합류.
-- 본문: 마태복음 4:1-11 (세 가지 시험). 성전/나라 시험은 목동 시점을 위해 신기루로 연출.
-- 구조: 5막 · 26씬 · 분기 6곳 · 엔딩 3개   BGM: morning→throne→snowfield
-- 실행: Supabase SQL Editor 에서 본 파일 전체 실행
-- =====================================================================

DO $$
DECLARE chap INT;
BEGIN
  SELECT id INTO chap FROM public.chapters WHERE chapter_num = 2;
  IF chap IS NULL THEN RAISE EXCEPTION 'chapter_num=2 챕터를 찾을 수 없습니다.'; END IF;

  DELETE FROM public.choices WHERE scene_id IN (SELECT id FROM public.scenes WHERE chapter_id = chap);
  DELETE FROM public.scenes WHERE chapter_id = chap;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition) VALUES
    (chap, 1, '세례를 받으신 직후, 성령이 예수님을 광야로 이끄셨습니다. 인적 없는 돌과 모래의 땅, 뜨거운 낮과 살을 에는 밤만이 거듭되는 곳입니다.

당신은 이 광야 끝자락에서 양 떼를 치는 어린 목동입니다. 저 멀리 바위 그늘에, 홀로 앉아 기도하는 한 사람의 모습이 눈에 들어옵니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 2, '며칠이 지나도 그 사람은 그 자리를 떠나지 않습니다. 물 한 모금, 빵 한 조각 입에 대는 것을 본 적이 없습니다.

햇볕에 그을린 그의 얼굴은 점점 야위어 가는데, 눈빛만은 이상하리만치 깊고 고요합니다. 당신은 그분을 어떻게 지켜볼까요?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 3, '당신은 양 떼를 바위틈에 몰아두고, 조심스레 그분 쪽으로 발을 옮깁니다. 가까이서 본 그분의 입술은 갈라지고, 두 손은 메말라 있었습니다.

그런데도 그 얼굴에는 절망의 그림자가 없었습니다. 마치 보이지 않는 누군가와 깊은 대화를 나누는 듯, 입술이 조용히 움직이고 있었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 4, '당신은 굳이 다가가지 않고, 양 떼를 치는 틈틈이 그분을 눈으로 좇습니다. 해가 뜨고 지는 동안, 그분은 거의 움직이지 않습니다.

이상한 일이었습니다. 저렇게 굶주린 사람이라면 진작 쓰러졌을 텐데, 그분은 무언가에 붙들린 듯 그 자리를 지키고 있었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 5, '당신은 허리춤의 물자루와 거친 보리빵을 만지작거립니다. "저분께 이걸 드리면… 조금이라도 기운을 차리실 텐데."

몇 번이나 일어서려다 다시 주저앉습니다. 어쩐지, 저 고요한 기도를 함부로 깨뜨려서는 안 될 것만 같았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 6, '사십 일째 되던 날. 그분은 극도로 쇠약해져, 이제는 그림자처럼 가벼워 보였습니다.

그때, 어디서 오는지 알 수 없는 속삭임이 메마른 바람을 타고 광야에 번졌습니다. "네가 하나님의 아들이거든, 이 돌들에게 명하여 떡이 되게 하라." 당신의 등줄기가 서늘해집니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 7, '그 말에 당신의 텅 빈 위장이 먼저 반응합니다. 며칠을 양젖과 마른 빵으로 버텨온 당신에게도, 돌이 떡이 된다는 그 한마디는 견디기 힘든 유혹이었습니다.

"나라면… 당장 그렇게 했을 거야." 부끄럽게도, 당신은 그분이 그 말에 넘어가기를 반쯤 바라고 있었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 8, '당신은 고개를 갸웃합니다. 저분이 정말 하나님의 아들이라면, 돌을 떡으로 바꾸는 것쯤 어렵지 않을 텐데.

그런데도 그분은 손가락 하나 까딱하지 않았습니다. 마치 그 쉬운 길이야말로 가장 위험한 함정임을 처음부터 꿰뚫어 보고 있는 듯했습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 9, '이윽고 그분이 갈라진 입술을 열어 나직이, 그러나 분명하게 대답하셨습니다.

"기록되었으되, 사람이 떡으로만 살 것이 아니요, 하나님의 입으로 나오는 모든 말씀으로 살 것이라 하였느니라." 그 한마디에, 바람을 타고 떠돌던 속삭임이 잠시 숨을 죽였습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 10, '그러나 시험은 끝나지 않았습니다. 광야의 뜨거운 공기가 아지랑이처럼 일렁이더니, 지평선 너머로 거룩한 성과 성전 꼭대기가 신기루처럼 솟아올랐습니다.

당신은 눈을 의심했습니다. 그 까마득한 첨탑 위에 그분이 서 계셨고, 속삭임이 다시 들려왔습니다. "뛰어내리라. 기록되었으되, 그가 천사들에게 명하여 너를 받들리라 하였느니라."', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 11, '당신은 몇 번이나 눈을 비빕니다. 분명 그분은 여전히 바위 그늘에 앉아 계신데, 동시에 저 아득한 성전 꼭대기에도 서 계신 것만 같았습니다.

꿈과 생시의 경계가 녹아내리는 듯한 광야. 당신은 비로소 깨달았습니다. 지금 이곳에서, 눈에 보이는 것 너머의 싸움이 벌어지고 있다는 것을.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 12, '당신은 자기도 모르게 숨을 멈춥니다. "천사가 받든다는데… 정말 뛰어내려 그것을 증명하시려는 걸까?"

높은 첨탑과 그 아래 까마득한 땅을 번갈아 보며, 당신의 심장이 두근거립니다. 그 한순간의 정적이, 영원처럼 길게 느껴졌습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 13, '그분은 흔들림 없이 대답하셨습니다.

"또 기록되었으되, 주 너의 하나님을 시험하지 말라 하였느니라." 그 말씀과 함께, 신기루처럼 떠올랐던 성전이 모래바람 속으로 스르르 흩어졌습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 14, '세 번째였습니다. 다시 광야가 일렁이더니, 이번엔 지평선 가득 세상 모든 나라의 영광이 펼쳐졌습니다. 황금빛 궁전들, 끝없는 군대, 번쩍이는 면류관들이 손에 잡힐 듯 눈앞에 흘러갔습니다.

속삭임은 이제 달콤하게 변해 있었습니다. "내게 한 번만 절하면, 이 모든 것을 네게 주리라."', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 15, '당신은 자신도 모르게 그 환영을 향해 한 걸음 다가섭니다. 평생 양 떼와 흙먼지뿐이던 당신에게, 저 영광은 숨이 막히도록 눈부셨습니다.

"저것을… 거저 가질 수 있다면." 그 순간 당신은 깨달았습니다. 이 시험이 그분만의 것이 아니라, 당신의 가장 깊은 곳까지 겨누고 있다는 것을.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 16, '"절 한 번이면 세상을 다 가진다니, 이보다 남는 장사가 어디 있나." 당신은 속으로 셈을 해봅니다.

그러나 셈이 맞아떨어질수록, 마음 한구석이 더 불편해졌습니다. 세상에 그렇게 거저 주어지는 것은 없다는 것을, 가난한 목동인 당신은 누구보다 잘 알고 있었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 17, '눈부신 영광 속에서, 당신은 오히려 소름이 돋았습니다. 너무 달콤한 약속, 너무 쉬운 길.

"절을 받겠다고? 그렇다면 저것은… 거저 주는 것이 아니라, 그분을 통째로 사려는 것이구나." 당신은 그 미끄러운 거짓의 정체를 어렴풋이 알아챘습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 18, '그러자 그분의 음성이, 처음으로 광야를 쩌렁 울리며 단호하게 터져 나왔습니다.

"사탄아, 물러가라! 기록되었으되, 주 너의 하나님께 경배하고 다만 그를 섬기라 하였느니라." 그 한마디에 온 광야가 진동하는 듯했습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 19, '달콤하던 속삭임이 찢어지는 비명처럼 멀어지더니, 이내 광야에 깊은 정적이 내려앉았습니다. 펼쳐졌던 모든 환영이 사라지고, 다시 돌과 모래뿐인 땅이 돌아왔습니다.

그때, 어디선가 빛 같은 존재들이 그분께 다가와 조용히 그분을 섬기기 시작했습니다. 당신은 난생처음 보는 평온이 광야를 가득 채우는 것을 느꼈습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 20, '당신은 자기도 모르게 양 떼 곁에 무릎을 꿇습니다. 누가 시킨 것도 아닌데, 그저 그렇게 해야 할 것만 같았습니다.

이 메마른 광야가, 방금 가장 거룩한 싸움이 벌어진 성소처럼 느껴졌습니다. 당신은 고개를 숙인 채, 그 정적이 가슴 깊이 스며들도록 가만히 머물렀습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 21, '당신은 양 떼를 끌어안듯 주저앉습니다. 팔뚝에 돋은 소름이 좀처럼 가라앉지 않았습니다.

눈에 보이지 않던 무언가가, 방금 이 광야에서 정면으로 부딪혔습니다. 그리고 분명히, 그분이 이겼습니다. "이분은… 대체 누구신가." 그 물음이 가슴을 떠나지 않았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 22, '까닭 모를 눈물이 당신의 뺨을 타고 흘렀습니다. 사십 일을, 그 끔찍한 외로움과 굶주림을, 그분은 누구의 도움도 없이 홀로 견뎌냈습니다.

가엾고도 위대한 모습이었습니다. 당신은 흐르는 눈물을 닦지도 못한 채, 멀어지는 그 고요한 뒷모습을 오래도록 바라보았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 23, '이윽고 기운을 추스른 그분이 천천히 일어나, 광야를 떠나 사람들이 사는 마을 쪽으로 발걸음을 옮기십니다.

당신은 양 떼 곁에 남아, 멀어지는 그분을 바라봅니다. 오늘 이 광야에서 본 것을, 당신은 어떻게 품고 살아갈까요?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 24, '당신은 알았습니다. 누구에게나 저마다의 광야가 있고, 저마다의 속삭임이 있다는 것을. 배고픔이, 욕심이, 손쉬운 길이 언제나 귓가를 맴돈다는 것을.

그러나 오늘 똑똑히 보았습니다. 말씀 앞에서 그 모든 속삭임이 힘을 잃는다는 것을. 당신은 그 한 가지를 가슴에 새기고, 당신만의 광야를 향해 발을 내딛습니다.

📖 마태복음 4:4
"사람이 떡으로만 살 것이 아니요, 하나님의 입으로 나오는 모든 말씀으로 살 것이라"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 25, '당신은 더는 가만히 있을 수 없었습니다. 양 떼를 이웃 목자에게 부탁하고는, 그분이 사라진 길을 향해 조심스레 걸음을 옮깁니다.

가까이 다가갈 용기는 아직 없습니다. 그저 멀찍이서, 저분이 앞으로 어떤 길을 걸으실지 두 눈으로 보고 싶었습니다. 이름 없는 한 사람의 작은 발걸음이, 그분의 뒤를 따라 광야를 벗어납니다.

📖 마태복음 4:4
"사람이 떡으로만 살 것이 아니요, 하나님의 입으로 나오는 모든 말씀으로 살 것이라"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 26, '당신은 다시 양 떼에게로 돌아갑니다. 겉보기엔 어제와 똑같은 광야, 똑같은 목동의 하루입니다.

그러나 당신 안에는 무엇과도 바꿀 수 없는 한 장면이 남았습니다. 배고픔과 유혹이 당신을 흔들 때마다, 광야에서 홀로 시험을 이기던 그 고요한 음성이 또렷이 되살아날 것입니다. 그것은 잊히지 않을 씨앗이 되어, 당신 안에서 조용히 자라기 시작했습니다.

📖 마태복음 4:4
"사람이 떡으로만 살 것이 아니요, 하나님의 입으로 나오는 모든 말씀으로 살 것이라"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade');

  INSERT INTO public.choices (scene_id, label, next_scene_id, choice_order) VALUES
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=1), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '양 떼를 잠시 두고 좀 더 가까이 다가가 본다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=3), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '먼발치에서 매일 그분의 모습을 눈으로 좇는다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=4), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '내 물자루와 빵을 나눠드릴까 망설인다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=3), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=4), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), '당신도 주린 배를 움켜쥐며 마른침을 삼킨다 — 그 떡이 간절하다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), '하실 수 있을 텐데, 왜 망설이실까 의아하다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), '환영인가 실제인가, 눈을 비비며 다시 본다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), '가슴이 철렁 내려앉는다 — 정말 뛰어내리시면 어쩌나', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), '그 눈부신 영광에 당신마저 잠시 눈이 멀 것만 같다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), '저 모든 걸 거저 준다니, 너무 쉬운 길 아닌가 솔깃하다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), '달콤한 만큼, 어딘가 섬뜩한 거짓의 냄새가 난다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), '무릎을 꿇고, 그 거룩한 정적에 가만히 잠긴다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), '온몸에 소름이 돋는다 — 방금 본 것은 대체 무엇이었나', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), '까닭 모를 눈물이 흐른다 — 홀로 견뎌낸 그분이 사무친다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), '나의 광야로 돌아가더라도, 나 또한 말씀으로 시험을 이기리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=24), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), '양 떼를 두고서라도, 그분의 뒤를 멀찍이 따라가 본다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), '오늘 본 것을 가슴 깊이 묻고, 다시 양 떼에게로 돌아간다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=24), '챕터 완료', NULL, 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), '챕터 완료', NULL, 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), '챕터 완료', NULL, 1);

END $$;
