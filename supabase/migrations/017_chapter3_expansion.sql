-- =====================================================================
-- 산상수훈 (Chapter 3) — 확장판 시나리오  [자동 생성: build_apply_ch3.mjs]
-- =====================================================================
-- 컨셉: 플레이어는 '산기슭 군중 속 한 사람' — 이름 없는 관찰자.
--       자기 삶의 짐(미움/근심/인정욕구)을 안고 올라와, 각 가르침에 개인적으로 반응한다.
--       선택은 성경의 말씀을 바꾸지 않으며, 오직 '나 자신'의 마음만 움직인다. 분기는 고정점에서 합류.
-- 본문: 마태복음 5-7 (팔복·소금과 빛·원수 사랑·주기도문·염려·반석 위의 집)
-- 구조: 7막 · 30씬 · 분기 6곳 · 엔딩 3개   BGM: morning↔throne→snowfield
-- 실행: Supabase SQL Editor 에서 본 파일 전체 실행
-- =====================================================================

DO $$
DECLARE chap INT;
BEGIN
  SELECT id INTO chap FROM public.chapters WHERE chapter_num = 3;
  IF chap IS NULL THEN RAISE EXCEPTION 'chapter_num=3 챕터를 찾을 수 없습니다.'; END IF;

  DELETE FROM public.choices WHERE scene_id IN (SELECT id FROM public.scenes WHERE chapter_id = chap);
  DELETE FROM public.scenes WHERE chapter_id = chap;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition) VALUES
    (chap, 1, '갈릴리의 완만한 산기슭에, 어디서 왔는지 모를 수많은 사람들이 구름처럼 몰려들었습니다. 병든 가족을 부축한 이, 지친 농부, 호기심 어린 아이들까지.

당신도 그 무리 가운데 한 사람입니다. 먼 길을 걸어 이 산에 올랐습니다. 무언가에 떠밀리듯, 혹은 무언가를 찾아서.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 2, '사람들이 풀밭 여기저기 자리를 잡는 동안, 당신은 가만히 자신의 마음을 들여다봅니다. 이 먼 길을 오르게 만든, 가슴 한쪽의 무게.

당신은 오늘, 무엇을 안고 이 산에 올랐습니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 3, '당신의 가슴엔 한 사람의 얼굴이 박혀 있습니다. 떠올리기만 해도 명치가 뜨거워지는, 당신을 짓밟은 그 사람.

"세상에 용서받지 못할 일도 있는 법이지." 당신은 그 미움을 당연한 것으로 여기며, 무거운 마음으로 풀밭에 앉습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 4, '당신의 머릿속은 온통 셈으로 가득합니다. 떨어져 가는 양식, 갚아야 할 빚, 병든 식구. 밤마다 천장을 보며 뒤척이던 근심이 오늘도 어깨를 누릅니다.

"이런 내가 이 산에 오를 자격이나 있을까." 당신은 한숨을 삼키며 풀밭 한구석에 앉습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 5, '당신은 늘 남의 눈을 의식하며 살아왔습니다. 회당에서의 자리, 사람들의 인사, 의롭다는 평판. 그것이 당신을 지탱하는 기둥이었습니다.

"오늘 이 자리에 온 것을 누군가 알아봐 주면 좋으련만." 당신은 옷매무새를 고치며 사람들 눈에 잘 띄는 곳에 앉습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 6, '이윽고 예수님이 산 위에 앉으시자, 제자들이 그 곁으로 나아왔습니다. 그분이 입을 여시자, 그 많던 웅성거림이 거짓말처럼 잦아들었습니다.

"심령이 가난한 자는 복이 있나니, 천국이 그들의 것임이요. 애통하는 자는 복이 있나니, 그들이 위로를 받을 것임이요."', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 7, '말씀은 잔잔한 물결처럼 이어졌습니다. "온유한 자는 복이 있나니 그들이 땅을 기업으로 받을 것임이요, 의에 주리고 목마른 자는 복이 있나니 그들이 배부를 것임이요."

복이라니. 가난하고, 슬프고, 굶주린 자가 복되다니 — 당신이 알던 세상과는 정반대의 말이었습니다. 이 말씀이 당신의 마음에 어떻게 닿습니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 8, '당신은 고개를 갸웃합니다. 평생 가진 자가 복되고, 웃는 자가 복되다고 배워왔습니다.

그런데 이분은 거꾸로 말합니다. 가난한 자, 우는 자가 복되다고. 머리로는 받아들이기 어려웠지만, 이상하게도 그 거꾸로 된 말이 가슴 한구석을 건드렸습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 9, '당신의 눈가가 뜨거워졌습니다. 비참함이야말로 당신이 가장 잘 아는 것이었으니까.

"이 말이 사실이라면… 버림받은 줄 알았던 내가, 실은 복의 문턱에 서 있는 거란 말인가." 오랫동안 닫혀 있던 마음에 가느다란 빛이 스며들었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 10, '예수님의 시선이 군중 전체를 천천히 훑었습니다. 보잘것없는 농부와 어부, 병자와 가난한 자들을.

"너희는 세상의 소금이니… 너희는 세상의 빛이라. 산 위에 있는 동네가 숨겨지지 못할 것이요." 그 누구도 당신 같은 사람을 ''빛''이라 불러준 적이 없었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 11, '그러나 말씀은 점점 더 깊고 날카로워졌습니다. "옛 사람에게 말한 바… 그러나 나는 너희에게 이르노니, 형제에게 노하는 자마다 심판을 받게 되리라."

이윽고 그분이 말씀하셨습니다. "네 원수를 사랑하며, 너희를 박해하는 자를 위하여 기도하라." 군중 사이에서 술렁임이 일었습니다. "너무 어렵다", "그게 사람이 할 수 있는 일이냐"고.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 12, '그 한마디가, 당신의 가장 아픈 곳을 정확히 찔렀습니다. 원수를 사랑하라니. 기도해 주라니.

가슴속 그 사람의 얼굴이 다시 떠올랐습니다. 당신은 이 말씀 앞에서, 무엇을 느낍니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 13, '당신은 속으로 거세게 고개를 젓습니다. "다른 건 몰라도 그것만은 안 됩니다."

그러나 그렇게 거부하는 순간에도, 마음 깊은 곳이 욱신거렸습니다. 어쩌면 당신은, 그 미움을 내려놓는 것이 두려운 것인지도 몰랐습니다. 그것마저 놓으면 무엇이 남을지 알 수 없어서.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 14, '문득 당신은 깨달았습니다. 그 미움이 그 사람을 해친 적은 없었습니다. 정작 밤마다 잠 못 이루고, 속을 끓이며 야위어 간 것은 — 당신 자신이었습니다.

"내가 그를 가둔 줄 알았는데, 갇혀 있던 건 나였구나." 오래 짊어진 짐의 정체를, 당신은 비로소 마주했습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 15, '당신은 반발하는 대신, 간절히 묻고 싶어졌습니다. "어떻게요? 어떻게 하면 그 사람을 미워하지 않을 수 있습니까?"

불가능해 보이는 그 말씀이, 역설적으로 당신 안에 작은 갈망을 일으켰습니다. 정말 그럴 수만 있다면, 이 무거운 짐에서 놓여날 수 있을 것만 같았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 16, '이어 그분은 기도에 대해 말씀하셨습니다. "기도할 때에 외식하는 자와 같이 사람에게 보이려 하지 말고, 은밀한 중에 계신 네 아버지께 기도하라."

그러고는 친히 본을 보이셨습니다. "하늘에 계신 우리 아버지여, 이름이 거룩히 여김을 받으시오며, 나라가 임하시오며, 뜻이 하늘에서 이룬 것 같이 땅에서도 이루어지이다."', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 17, '짧고 꾸밈없는 기도였습니다. 그런데 그 한 마디 한 마디가, 화려한 어떤 기도보다 깊이 당신의 마음을 적셨습니다.

특히 ''아버지''라는 그 한 단어가, 가슴에 오래 머물렀습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 18, '당신은 그 단어를 속으로 가만히 되뇌어 봅니다. 아버지. 멀고 두렵기만 하던 하늘의 그분을, 그렇게 불러도 된다니.

버림받았다고 느꼈던 마음 한구석이, 그 한 단어 앞에서 천천히 녹아내리는 것 같았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 19, '당신은 늘 기도가 어려웠습니다. 그럴듯한 말을 길게 늘어놓아야 들어주실 것만 같았으니까.

그런데 이렇게 짧고 진실한 기도면 충분하다니. 어쩐지 무거운 어깨가 한결 가벼워지는 기분이었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 20, '그분은 근심에 짓눌린 사람들을 향해 말씀을 이으셨습니다. "목숨을 위하여 무엇을 먹을까 무엇을 입을까 염려하지 말라."

"공중의 새를 보라. 심지도 거두지도 않으되 너희 하늘 아버지께서 기르시나니… 들의 백합화가 어떻게 자라는가 보라. 너희는 먼저 그의 나라와 그의 의를 구하라. 그리하면 이 모든 것을 너희에게 더하시리라."', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 21, '근심으로 밤을 지새우던 당신에게, 그 말씀은 차마 믿기 어려운 위로였습니다. 정말 저 작은 새와 들꽃까지 돌보시는 분이, 나의 내일까지 아신다는 걸까.

당신은 이 말씀 앞에서, 어떤 마음이 듭니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 22, '당신의 가슴 깊은 곳에서 무언가 따뜻한 것이 차올랐습니다. 누구도 내 사정을 모른다고 생각했는데.

"아버지께서 다 아신다." 그 한마디가, 평생 혼자 짊어졌다고 여긴 짐을 함께 들어 주는 손길처럼 느껴졌습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 23, '그러나 당신의 마음은 그리 쉽게 놓이지 않았습니다. "말씀은 아름답지만, 당장 내일 끼니는 어쩌란 말인가."

그럼에도 이상하게, 그 의심마저 솔직히 품은 채로 말씀을 더 듣고 싶었습니다. 어쩌면 믿음이란, 두려움이 다 사라진 자리가 아니라 두려움을 안고도 한 걸음 내딛는 것인지도 몰랐습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 24, '당신은 가만히 눈을 감고, 늘 꽉 움켜쥐고 있던 근심을 한 움큼 손에서 내려놓아 봅니다.

달라진 것은 아무것도 없는데, 잠시나마 어깨가 가벼워졌습니다. 어쩌면 이 가르침은 머리로 이해하는 것이 아니라, 이렇게 한 번씩 내맡겨 보는 것인지도 몰랐습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 25, '해가 기울 무렵, 그분은 가르침을 마무리하셨습니다. "좁은 문으로 들어가라." 그리고 마지막으로 한 가지 비유를 들려주셨습니다.

"누구든지 나의 이 말을 듣고 행하는 자는 그 집을 반석 위에 지은 지혜로운 사람 같으리니, 비가 내리고 창수가 나고 바람이 불어도 무너지지 아니하나니 이는 주춧돌을 반석 위에 놓은 까닭이요." 듣고 행치 않는 자는 모래 위에 집을 지은 어리석은 사람 같다 하셨습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 26, '예수님이 이 말씀을 마치시자, 무리가 그 가르치심에 놀랐습니다. 권위 있는 자처럼 가르치시고, 그들이 늘 듣던 서기관들과는 같지 않으셨기 때문입니다.

해가 산등성이로 붉게 기울어도, 사람들은 쉬이 자리를 뜨지 못했습니다. 당신 역시, 가슴에 묵직한 무언가를 안은 채 그 자리에 앉아 있었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 27, '마침내 당신은 자리에서 일어나, 사람들과 함께 산을 내려가기 시작합니다. 오늘 들은 말씀들이 가슴속에서 여전히 메아리치고 있습니다.

반석 위의 집과 모래 위의 집. 듣는 것과 행하는 것. 당신은 이 말씀들을, 이제 어떻게 하시겠습니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 28, '산을 내려가는 당신의 마음은 더없이 분명해졌습니다. 다 지킬 수는 없을지라도, 듣기만 하고 흘려보내지는 않으리라.

"오늘부터 단 한 가지라도 행하며 살자." 미움 하나를 내려놓는 일이든, 근심 하나를 맡기는 일이든. 당신은 모래가 아니라 반석 위에, 당신의 삶이라는 집을 짓기로 마음먹습니다.

📖 마태복음 7:24
"누구든지 나의 이 말을 듣고 행하는 자는 그 집을 반석 위에 지은 지혜로운 사람 같으리니"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 29, '당신은 자꾸만 뒤를 돌아봅니다. 저 산 위에서 말씀을 전하던 그분을, 그 ''아버지''를 이야기하던 그 음성을, 더 듣고 싶었습니다.

집으로 가는 갈림길에서, 당신의 발은 사람들이 흩어지는 쪽이 아니라 그분이 머무신 쪽으로 향합니다. 이름 없는 한 사람으로, 당신은 그분을 조금 더 가까이에서 따라가 보기로 합니다.

📖 마태복음 7:24
"누구든지 나의 이 말을 듣고 행하는 자는 그 집을 반석 위에 지은 지혜로운 사람 같으리니"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 30, '당신은 다시 일상으로 돌아갑니다. 당신을 짓누르던 미움도, 근심도, 어쩌면 내일이면 또 당신을 흔들 것입니다.

그러나 오늘 산 위에서 들은 말씀들은 쉽게 지워지지 않을 것입니다. 흔들리는 순간마다 그 음성이 가슴속에 또렷이 되살아나, 당신을 붙들 것입니다. 그것은 잊히지 않을 씨앗이 되어, 당신 안에서 조용히 뿌리내리기 시작했습니다.

📖 마태복음 7:24
"누구든지 나의 이 말을 듣고 행하는 자는 그 집을 반석 위에 지은 지혜로운 사람 같으리니"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade');

  INSERT INTO public.choices (scene_id, label, next_scene_id, choice_order) VALUES
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=1), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '나를 깊이 상처 입힌 이웃에 대한, 쉬이 풀리지 않는 미움', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=3), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '내일은 또 무엇을 먹고 입을까, 끝나지 않는 근심', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=4), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '남들에게 의롭고 번듯한 사람으로 보이고 싶은 갈망', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=3), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=4), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), '가난과 슬픔이 복이라니, 세상과 거꾸로다 — 혼란스럽다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), '그렇다면 비참한 지금의 나도… 복의 자리에 있는 걸까', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), '도저히 못 하겠다. 그 사람만은, 용서할 수 없다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), '미움에 갇혀 정작 병들어 온 건… 나 자신이었구나', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), '대체 어떻게 그게 가능한지, 그분께 묻고 싶다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), '하나님을 ''아버지''라 불러도 되는 걸까 — 낯설고도 뭉클하다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), '이렇게 짧아도 되는구나 — 어쩐지 마음이 놓인다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), '정말 내 모든 걱정을 다 아신다고? — 깊은 위로가 밀려온다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), '그래도 당장 내일이 두렵다 — 쉽게 놓이지 않는다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), '꽉 쥐고 있던 근심을, 잠시 손에서 내려놓아 본다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=24), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=24), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '반석 위에 집을 짓듯, 오늘부터 단 한 가지라도 행하며 살리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=28), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '무엇보다 그 ''아버지''를 더 알고 싶다 — 그분의 뒤를 따라가 보리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=29), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '다 행할 자신은 없지만, 이 말씀만은 가슴에 깊이 새겨 품으리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=30), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=28), '챕터 완료', NULL, 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=29), '챕터 완료', NULL, 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=30), '챕터 완료', NULL, 1);

END $$;
