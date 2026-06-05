-- =====================================================================
-- 탕자의 귀환 (Chapter 8) — 확장판  [자동 생성: _apply.mjs]
-- 컨셉: 비유. 플레이어는 비유 속 '부잣집의 오랜 종'으로, 기다리는 아버지를 곁에서 지켜본다.
--       탕자가 되지 않고 관찰한다. 선택은 성경의 결과를 바꾸지 않고 나의 마음만 바꾼다.
-- 본문: 누가복음 15:11-32 (탕자의 비유)
-- 구조: 6막 · 28씬 · 분기 6곳 · 엔딩 3개   BGM: snow↔throne→morning→snow
-- =====================================================================

DO $$
DECLARE chap INT;
BEGIN
  SELECT id INTO chap FROM public.chapters WHERE chapter_num = 8;
  IF chap IS NULL THEN RAISE EXCEPTION 'chapter_num=8 챕터를 찾을 수 없습니다.'; END IF;

  DELETE FROM public.choices WHERE scene_id IN (SELECT id FROM public.scenes WHERE chapter_id = chap);
  DELETE FROM public.scenes WHERE chapter_id = chap;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition) VALUES
    (chap, 1, '세리와 죄인들이 예수님 곁에 몰려들자, 바리새인과 서기관들이 수군거렸습니다. "이 사람이 죄인을 영접하고 함께 먹는구나."

예수님은 그들에게 한 가지 이야기를 들려주기 시작하셨습니다. 무리 속에서 듣던 당신은, 어느새 그 이야기 속 한 부잣집에서 오래 일해 온 종이 되어 있었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 2, '어느 날, 작은아들이 아버지 앞에 서서 당돌하게 말했습니다. "아버지, 재산 중에서 내게 돌아올 몫을 지금 주십시오."

살아 계신 아버지께 미리 유산을 내놓으라니. 곁에서 시중들던 당신은 자기 귀를 의심했습니다. 당신의 마음에는 무엇이 먼저 듭니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 3, '당신은 속에서 부아가 치밀었습니다. 유산이란 아버지가 돌아가신 뒤에야 나누는 법. 그런데 멀쩡히 살아 계신 아버지께 제 몫을 내놓으라니.

"저건 아버지더러 죽은 사람 취급을 하는 거나 다름없지 않은가." 당신은 작은아들의 철없음에 혀를 끌끌 찼습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 4, '당신의 시선은 작은아들이 아니라 아버지께로 향했습니다. 그 무례한 요구를 들으신 주인어른의 얼굴에, 깊은 그늘이 스쳤으니까요.

"얼마나 가슴이 미어지실까." 오래 모셔 온 주인의 마음을 헤아리며, 당신은 함께 마음이 아팠습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 5, '당신은 까닭 모를 불안에 휩싸였습니다. 평소 들떠 있던 작은아들의 눈빛이, 이미 이 집을 떠나 먼 곳을 향해 있었으니까요.

"저 도련님이 저 돈을 들고 대체 무슨 일을…?" 무언가 돌이킬 수 없는 일이 시작되고 있다는 예감에, 당신은 마음을 졸였습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 6, '아버지는 한참을 말없이 계시더니, 끝내 살림을 둘로 나누어 작은아들의 몫을 내어 주셨습니다. 작은아들은 그 모든 것을 챙겨, 뒤도 돌아보지 않고 먼 나라로 떠나 버렸습니다.

그 먼 땅에서 그는 흥청망청, 허랑방탕하게 가진 것을 모조리 탕진했습니다. 친구도, 쾌락도, 돈이 있을 때뿐이었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076097234-9c8e2f4e-74b1-4043-b5e4-802f955be784.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 7, '가진 것이 바닥나자, 설상가상으로 그 땅에 극심한 흉년까지 닥쳤습니다. 굶주린 그는 결국 남의 집 돼지를 치는 신세로 전락했습니다.

돼지가 먹는 쥐엄 열매로라도 배를 채우고 싶었지만, 그것조차 주는 이가 없었습니다. 바로 그 밑바닥에서, 그는 비로소 정신이 번쩍 들었습니다. "내 아버지의 품꾼들은 양식이 넘치는데, 나는 여기서 굶어 죽는구나. 일어나 아버지께 돌아가자."', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076097234-9c8e2f4e-74b1-4043-b5e4-802f955be784.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 8, '한편 그 집에서는, 아버지가 매일같이 대문 밖에 나가 서 계셨습니다. 작은아들이 떠난 그 길을, 하루도 거르지 않고 하염없이 바라보시면서.

종인 당신은 그런 주인어른을 날마다 곁에서 지켜보았습니다. 그 모습이 당신에게는 어떻게 보였습니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076406708-c84d8c00-9842-4d18-92d8-9c81c9610078.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 9, '당신은 주인어른이 못내 안쓰러웠습니다. 그렇게 무례하게 등을 돌리고 떠난 자식인데, 아버지는 그 빈 길을 바라보며 야위어 가셨습니다.

"이제 그만 마음을 거두셔도 될 텐데." 당신은 차마 그 말을 입 밖에 내지 못하고, 주인의 굽은 등을 안타깝게 바라보았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 10, '솔직히 당신은 주인어른을 이해할 수 없었습니다. 재산을 챙겨 멋대로 떠나 버린 아들을, 어찌 저토록 한결같이 기다리실 수 있단 말인가.

"나라면 진작 자식으로 여기지도 않았을 텐데." 그러나 매일 같은 자리에 서 계신 아버지를 보며, 당신은 그 한결같음에 알 수 없는 두려움마저 느꼈습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 11, '당신은 그 뒷모습을 보며 가슴이 먹먹해졌습니다. 야단도, 원망도 아니었습니다. 그저 기다림. 끝이 보이지 않는 기다림이었습니다.

"자식을 향한 부모의 마음이란 게, 저런 것인가." 당신은 그 깊이를 다 헤아릴 수 없어, 그저 묵묵히 곁을 지켰습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 12, '그러던 어느 날 해 질 무렵이었습니다. 길 끝에 누더기를 걸친 비쩍 마른 그림자 하나가 나타났습니다. 알아보기도 힘든 몰골이었지만, 아버지는 한눈에 알아보셨습니다.

그러고는 — 체통이고 뭐고 다 내던지신 채, 버선발로 그 아들을 향해 달려 나가셨습니다. 그 광경을 보며 당신은 어떻게 합니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076406708-c84d8c00-9842-4d18-92d8-9c81c9610078.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 13, '당신은 어안이 벙벙했습니다. 동네 어른이 뛰는 법이 없는 시절에, 그것도 가산을 탕진하고 돌아온 자식에게 주인어른이 달려가시다니.

"꾸짖어도 모자랄 판에…" 당신의 상식으로는 도무지 이해되지 않는 광경이었습니다. 그러나 아버지의 발걸음엔 한 점의 망설임도 없었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 14, '당신은 자기도 모르게 코끝이 찡해져, 주인어른의 뒤를 따라 달렸습니다. 그 다급한 뒷모습이, 매일 대문 밖을 지키던 그 모든 날들을 말해 주고 있었으니까요.

"드디어, 드디어 돌아왔구나." 당신의 눈에도 어느새 눈물이 차올랐습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 15, '당신은 그 자리에 멈춰 선 채, 달려가는 아버지의 뒷모습을 멍하니 바라보았습니다. 늙은 어깨가 그토록 빠르게 움직이는 것을, 당신은 처음 보았습니다.

그것은 단순한 반가움이 아니었습니다. 잃어버렸던 것을 되찾은 자의, 온몸을 던진 기쁨이었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 16, '아버지는 달려가 아들의 목을 끌어안고 입을 맞추셨습니다. 흙먼지와 돼지 냄새가 밴 그 더러운 몸을, 조금도 마다하지 않으시고.

아들이 울먹이며 말했습니다. "아버지, 제가 하늘과 아버지께 죄를 지었으니, 이제는 아들이라 불릴 자격도 없습니다." 그러나 아버지는 그 말을 끝까지 듣지도 않으셨습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076406708-c84d8c00-9842-4d18-92d8-9c81c9610078.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 17, '자격이 없다는 아들을, 아버지는 더 꼭 끌어안으셨습니다. 죄의 목록을 따지지도, 변명을 요구하지도 않으셨습니다.

그 포옹을 지켜보며, 당신의 마음에는 무엇이 일어납니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 18, '당신은 깨달았습니다. 아들은 "아들이라 불릴 자격이 없다"고 했지만, 아버지에게 자격 따위는 처음부터 문제가 아니었습니다.

돌아왔다는 것. 그것 하나로 충분했습니다. 무언가를 갚거나 증명해야 받아들여지는 줄 알았던 당신의 셈법이, 그 포옹 앞에서 무너져 내렸습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 19, '이상하게도, 당신의 가슴 깊은 곳에서 낯선 그리움이 솟았습니다. 누군가의 품에, 아무 조건 없이 저렇게 안기고 싶다는.

흠 많고 부족한 자신도, 어쩌면 저렇게 받아들여질 수 있을까. 당신은 남의 일을 보고 있는데도, 마치 자기 이야기인 것처럼 마음이 일렁였습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 20, '아버지는 곧장 종들에게 분부하셨습니다. "어서 제일 좋은 옷을 내어다 입히고, 손에 가락지를, 발에 신을 신겨라. 그리고 살진 송아지를 잡아라. 우리가 먹고 즐기자!"

"이 내 아들은 죽었다가 다시 살아났으며, 내가 잃었다가 다시 얻었노라." 온 집안이 음악과 춤으로, 잔치의 기쁨으로 가득 찼습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076406708-c84d8c00-9842-4d18-92d8-9c81c9610078.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 21, '그런데 들에서 돌아온 큰아들이, 잔치 소리를 듣고는 화가 나서 집에 들어오려 하지 않았습니다. "저는 여러 해 아버지를 섬겼는데 염소 새끼 한 마리 주신 적 없으면서, 재산을 탕진한 저 아들에게는 살진 송아지를…!"

아버지는 밖으로 나가 큰아들을 다정히 타이르셨습니다. 큰아들의 분노를 들으며, 당신의 마음은 어느 쪽으로 기웁니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 22, '당신은 큰아들의 억울함이 이해되었습니다. 묵묵히 아버지를 섬겨 온 그에게, 이 잔치는 부당하게 느껴질 만도 했으니까요.

"성실한 사람은 대체 뭐가 되나." 그러나 그렇게 따지는 마음 한편으로, 아버지가 "너는 늘 나와 함께 있으니 내 것이 다 네 것"이라 하신 말씀이 묘하게 걸렸습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 23, '당신은 아버지의 편에 마음이 기울었습니다. 아버지의 말씀대로, 이것은 옳고 그름을 따질 일이 아니라 죽었던 자가 살아 돌아온 기쁨의 자리였으니까요.

"잃었던 동생을 되찾았는데, 어찌 기뻐하지 않을 수 있나." 당신은 큰아들도 어서 이 기쁨에 함께하기를 바랐습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 24, '큰아들의 성난 목소리를 들으며, 당신은 뜨끔했습니다. "여러 해 섬겼는데 나에겐 아무것도…" 그 불평이, 어쩐지 당신 자신의 속마음 같았으니까요.

당신 안에도, 받은 은혜는 잊고 남이 받는 은혜는 시샘하는 마음이 있었습니다. 탕자만이 아니라, 큰아들 또한 — 당신의 모습이었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 25, '잔칫집의 불빛이 따뜻하게 새어 나오는 마당. 당신은 오늘 이 집에서 본 것을, 어떻게 품고 살아갈지 생각합니다.

돌아온 자를 향해 버선발로 달려가던, 그 아버지를.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 26, '당신은 알게 되었습니다. 누구에게나 길을 잃고 먼 나라로 떠나는 때가 있다는 것을. 그리고 그때에도, 대문 밖에서 그 길을 바라보며 기다리는 분이 계시다는 것을.

언젠가 당신이 길을 잃더라도, 이제 두려워하지 않기로 합니다. "자격이 없다" 머뭇거리기 전에, 그 품을 향해 돌아가기로. 아버지는 이미, 저 멀리서부터 달려오고 계실 테니까요.

📖 누가복음 15:20
"아버지가 그를 보고 측은히 여겨 달려가 목을 안고 입을 맞추니"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 27, '당신은 이런 아버지의 마음을 비유로 들려주신 분이 못내 궁금해졌습니다. 죄인을 영접하고 함께 먹는다고 손가락질받으면서도, 돌아온 자를 향해 달려가는 그 사랑을 말씀하신 분.

무리가 흩어진 뒤에도, 당신의 발은 그분이 가시는 쪽으로 향합니다. 이름 없는 한 사람으로, 그 아버지의 마음을 더 알기 위하여.

📖 누가복음 15:20
"아버지가 그를 보고 측은히 여겨 달려가 목을 안고 입을 맞추니"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 28, '당신은 다시 종의 평범한 일상으로 돌아갑니다. 마당을 쓸고, 상을 차리고, 주인을 시중드는 날들.

그러나 대문 밖 그 길을 지날 때마다, 당신은 그날을 떠올릴 것입니다. 누더기 차림의 아들에게 버선발로 달려가던 아버지를. 조건 없이 안기던 그 포옹을. 그것은 잊히지 않을 씨앗이 되어, 당신 안에서 조용히 자라기 시작했습니다.

📖 누가복음 15:20
"아버지가 그를 보고 측은히 여겨 달려가 목을 안고 입을 맞추니"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade');

  INSERT INTO public.choices (scene_id, label, next_scene_id, choice_order) VALUES
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=1), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '괘씸하다 — 아버지가 죽기라도 바라는 듯한 저 무엄한 요구라니', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=3), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '안타깝다 — 주인어른께서 얼마나 마음이 무너지실까', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=4), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '불안하다 — 저 도련님이 대체 무슨 일을 벌이려는 걸까', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=3), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=4), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), '안쓰럽다 — 떠나 버린 자식을 저리 못 잊으시다니', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), '이해가 안 된다 — 그렇게 속을 썩인 아들을 왜 아직도 기다리시나', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), '가슴이 먹먹하다 — 저것이 자식을 향한 부모의 마음인가', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), '''아니, 저런 자식한테 뛰어가시다니!'' 어안이 벙벙하다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), '나도 모르게 코끝이 찡해져 그 뒤를 따라 달린다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), '달려가는 아버지의 모습에서 눈을 떼지 못한 채 멈춰 선다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), '''자격''을 말하는 아들과, ''자격''을 묻지 않는 아버지의 차이가 가슴을 친다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), '나도 저렇게 조건 없이 안기고 싶다는, 낯선 그리움이 솟는다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), '큰아들이 이해된다 — 성실히 산 사람 입장에선 억울할 만도 하다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), '그래도 아버지 말씀이 옳다 — 죽었던 동생이 살아왔으니 기뻐할 일이다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), '내 안에도 큰아들 같은 마음이 있었음을 깨닫는다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=24), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=24), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), '나도 언젠가 길을 잃거든, 망설임 없이 그 품으로 돌아가리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), '이런 아버지의 마음을 가르치신 분을 더 알고 싶다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), '조건 없이 안아 주던 그 사랑을, 평생 가슴에 새기리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=28), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), '챕터 완료', NULL, 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '챕터 완료', NULL, 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=28), '챕터 완료', NULL, 1);

END $$;
