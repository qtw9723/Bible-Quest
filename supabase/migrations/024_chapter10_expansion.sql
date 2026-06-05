-- =====================================================================
-- 최후의 만찬 (Chapter 10) — 확장판  [자동 생성: _apply.mjs]
-- 컨셉: 플레이어는 '다락방을 준비하고 시중든 사람' — 이름 없는 관찰자.
--       선택은 성경의 결과를 바꾸지 않고 나의 마음만 바꾼다. 분기는 고정점에서 합류.
-- 본문: 마태복음 26 / 누가복음 22 / 요한복음 13 (세족·성찬·배신 예고)
-- 구조: 5막 · 30씬 · 분기 6곳 · 엔딩 3개   BGM: snow→throne→snow
-- =====================================================================

DO $$
DECLARE chap INT;
BEGIN
  SELECT id INTO chap FROM public.chapters WHERE chapter_num = 10;
  IF chap IS NULL THEN RAISE EXCEPTION 'chapter_num=10 챕터를 찾을 수 없습니다.'; END IF;

  DELETE FROM public.choices WHERE scene_id IN (SELECT id FROM public.scenes WHERE chapter_id = chap);
  DELETE FROM public.scenes WHERE chapter_id = chap;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition) VALUES
    (chap, 1, '유월절이 다가오자, 제자들이 예수님께 물었습니다. "유월절 음식을 어디서 준비하길 원하시나이까?" 예수님의 말씀을 따라, 한 다락방이 정해졌습니다.

당신은 그 다락방을 내어주고 상을 차린 사람입니다. 자리를 매만지고 등불을 밝히는 동안, 왠지 오늘 저녁이 예사롭지 않을 것 같은 예감이 들었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 2, '상보를 펴고, 떡과 포도주, 쓴 나물을 차례로 올려놓습니다. 곧 그 유명한 선생과 열두 제자가 이 방에 들 것입니다.

분주히 상을 매만지며, 당신의 마음은 어떻습니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 3, '당신은 손끝 하나까지 정성을 다해 상을 차립니다. 행여 흠이 될까, 잔 하나 수저 하나도 몇 번씩 매만졌습니다.

"이 귀한 분들을 모시는데, 부족함이 없어야지." 설렘 반 긴장 반으로, 당신의 손길은 더없이 조심스러웠습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 4, '상을 차리면서도, 당신은 자꾸만 먼저 와 계신 예수님의 안색을 살피게 됩니다. 평소와 달리, 그 얼굴엔 짙은 그늘이 드리워 있었습니다.

"무슨 근심이라도 있으신 걸까." 까닭 모를 무거움이 방 안에 내려앉은 듯하여, 당신의 마음도 함께 가라앉았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 5, '당신은 이 자리를 마련한 것이 더없이 영광스러웠습니다. 온 갈릴리가 우러르는 그 선생을, 바로 이 다락방에 모시게 되었으니까요.

"평생 잊지 못할 저녁이 되겠지." 당신은 벅찬 마음으로, 손님 맞을 채비를 서둘렀습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 6, '저녁이 되자 예수님이 열두 제자와 함께 식탁에 둘러앉으셨습니다. 그분이 입을 여셨습니다.

"내가 고난을 받기 전에 너희와 함께 이 유월절 먹기를 원하고 원하였노라." 그 한마디에, 방 안의 공기가 한층 더 무거워졌습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 7, '그런데 식사 도중, 예수님이 자리에서 일어나 겉옷을 벗고 수건을 두르시더니, 대야에 물을 떠 오셨습니다. 그러고는 무릎을 꿇고 제자들의 발을 하나하나 씻기기 시작하셨습니다.

발을 씻기는 일은, 이 집에서 가장 낮은 종인 — 바로 당신이 해야 할 일이었습니다. 그런데 그 일을, 선생이 친히 하고 계셨습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 8, '주인이 종의 일을 하시는 그 광경 앞에서, 당신은 어쩔 줄을 몰랐습니다.

당신의 마음에는 무엇이 일어납니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 9, '당신은 당황하여 어쩔 줄 몰랐습니다. "저건 제가 해야 할 일인데… 어찌 선생님께서." 종인 당신을 제쳐 두고 손수 발을 씻기시는 모습이, 송구하기 짝이 없었습니다.

선뜻 나서서 말리지도 못한 채, 당신은 그저 발갛게 달아오른 얼굴로 그 광경을 지켜볼 뿐이었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 10, '당신의 가슴이 뭉클해졌습니다. 모두가 우러르는 그 높은 분이, 무릎을 꿇고 제자들의 더러운 발을 씻기고 계셨습니다.

"가장 높은 분이, 가장 낮은 자리로 내려오시는구나." 당신은 평생 보아 온 그 어떤 윗사람과도 다른 그분의 모습에, 가슴 깊이 무언가가 울렸습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 11, '당신은 문득 부끄러워졌습니다. 종으로 살면서도, 정작 누군가의 발을 진심으로 씻겨 본 적이 있었던가.

낮은 일을 하면서도 마음만은 높았던 자신이 떠올랐습니다. 그런데 정작 가장 높으신 분이, 가장 낮은 자리에서 묵묵히 섬기고 계셨습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 12, '자리에 다시 앉으신 예수님이, 떡을 들어 감사 기도를 드리시고 떼어 나눠 주시며 말씀하셨습니다. "이것은 너희를 위하는 내 몸이라. 너희가 이를 행하여 나를 기념하라."

잔도 가져 감사하시고 주시며 말씀하셨습니다. "이 잔은 내 피로 세우는 새 언약이니, 곧 너희를 위하여 붓는 것이라."', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 13, '내 몸, 내 피. 떡과 잔을 두고 하시는 그 낯설고도 엄숙한 말씀이, 상을 차린 당신의 귀에도 또렷이 박혔습니다.

그 말씀 앞에서, 당신의 마음은 어떠합니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 14, '당신은 그 말씀의 뜻을 도무지 알 수 없어 가슴이 서늘해졌습니다. 떡이 몸이라니, 잔이 피라니.

그러나 알 수 없다고 흘려버릴 수도 없었습니다. 그 말씀에는, 함부로 흘려들어선 안 될 어떤 무게가 담겨 있었으니까요.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 15, '당신은 까닭 모를 불길함에 사로잡혔습니다. "고난을 받기 전에", "너희를 위하여 붓는 피" — 그분의 말씀은 자꾸만 무언가 끝을 향하고 있었습니다.

"설마, 무슨 일이 일어나려는 건 아니겠지." 즐거워야 할 유월절 식탁에, 당신은 알 수 없는 그림자를 느꼈습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 16, '당신은 그 말씀의 무게에 숨이 막혔습니다. 자신을 떼어 주고, 자신을 부어 주신다는 말. 그것은 곧 자기 전부를 내어 준다는 뜻이었습니다.

무엇을 위해, 누구를 위해. 당신은 그 사랑의 깊이를 다 헤아릴 수 없어, 그저 가슴이 먹먹했습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 17, '그때, 예수님이 무겁게 말씀하셨습니다. "내가 진실로 너희에게 이르노니, 너희 중의 하나가 나를 팔리라."

식탁이 술렁였습니다. 제자들이 서로를 돌아보며 근심에 차 물었습니다. "주여, 나는 아니지요?" "설마 저는 아니지요?"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076529569-0aef12b3-4f72-478f-a6e9-4d16a6c83873.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 18, '이 따뜻한 사랑의 식탁에 배신자가 있다는 그 말씀에, 상을 차린 당신마저 가슴이 철렁 내려앉았습니다.

당신은 무엇을 합니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 19, '당신은 자기도 모르게 제자들의 얼굴을 하나하나 살피게 되었습니다. "대체 누구지? 누가 저 좋은 분을 판단 말인가."

그러나 어느 얼굴에서도 답을 찾을 수 없었습니다. 다만 그 누구도, "그건 나다"라고 말하지 않았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 20, '당신은 도무지 믿기지 않았습니다. 방금 함께 떡을 떼고, 친히 발까지 씻김을 받은 이 식탁에 배신자가 있다니.

"이런 사랑을 받고도, 어떻게 사람이 그분을 판단 말인가." 사람의 마음이라는 것이, 그렇게나 알 수 없는 것임에 당신은 서늘해졌습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 21, '제자들의 "나는 아니지요?"라는 물음이, 어느새 당신 자신에게로 향했습니다. "나라면, 끝까지 신실할 수 있었을까."

장담할 수 없었습니다. 사람의 결심이 얼마나 약한지, 당신은 누구보다 잘 알고 있었으니까요. 그 물음 앞에서 당신은 한없이 작아졌습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 22, '식사를 마치고, 그들은 찬미하며 감람산으로 나아갔습니다. 길을 걸으며 예수님이 말씀하셨습니다. "오늘 밤 너희가 다 나를 버리리라."

베드로가 발끈하여 외쳤습니다. "모두 다 주를 버릴지라도, 저는 결코 버리지 않겠나이다." 예수님은 그저 슬픈 눈으로 그를 바라보셨습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 23, '배신도, 부인도, 도망도. 그 모든 것을 다 아시면서도, 예수님은 그들과 함께 떡을 떼고 그 발을 씻기셨습니다.

그 사실을 곱씹으며, 당신의 마음에는 무엇이 차오릅니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 24, '당신은 가슴이 미어졌습니다. 누가 자신을 팔지, 누가 자신을 버릴지 다 아시면서도, 그분은 그들과 마지막 식탁을 함께하셨습니다.

배신자의 발까지 씻기고, 그에게도 떡을 떼어 주신 사랑. 당신은 그런 사랑을 이전에 본 적도, 들은 적도 없었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 25, '당신은 큰소리치는 베드로가 못내 걱정스러웠습니다. "모두 버려도 나는 아니라"던 그 결심이, 과연 이 밤을 견뎌 낼 수 있을까.

사람의 장담이 얼마나 쉽게 무너지는지를 떠올리며, 당신은 그 호언장담이 도리어 위태롭게만 느껴졌습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 26, '당신은 문득 뭉클해졌습니다. 그분이 다 아시는 그 배신과 부인 속에, 어쩌면 당신의 약함도 들어 있을 텐데.

그럼에도 그분은 그런 자들과 끝까지 식탁을 함께하셨습니다. "나의 약함과 흔들림까지 다 아시고도, 품으시는 걸까." 그 생각에 당신의 눈가가 뜨거워졌습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 27, '그들이 떠난 뒤, 다락방에는 떡 부스러기와 비워진 잔만이 남았습니다. 당신은 그 자리를 정리하며, 오늘 저녁을 어떻게 품고 살아갈지 생각합니다.

친히 발을 씻기고, 몸과 피를 떼어 주신 그 밤을.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 28, '당신은 빈 잔을 가만히 들어 봅니다. "나를 기념하여 이것을 행하라" 하시던 그 말씀이 귓가에 맴돌았습니다.

앞으로 떡을 떼고 잔을 들 때마다, 당신은 오늘 밤을 기억하기로 합니다. 자신을 통째로 내어 주신 그 사랑을. 그것을 잊지 않는 것이, 당신이 드릴 수 있는 작은 응답이었습니다.

📖 누가복음 22:19
"이것은 너희를 위하여 주는 내 몸이라 너희가 이를 행하여 나를 기념하라"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 29, '당신은 이 저녁을 함께한 그분에게서 마음을 거둘 수 없었습니다. 배신을 아시면서도 떡을 떼고, 종처럼 무릎 꿇어 발을 씻기시던 분.

어떤 밤이 닥쳐오든, 당신은 이분을 끝까지 따르기로 합니다. 이름 없는 한 사람으로, 이 사랑의 끝이 어디까지인지 두 눈으로 보기 위하여.

📖 누가복음 22:19
"이것은 너희를 위하여 주는 내 몸이라 너희가 이를 행하여 나를 기념하라"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 30, '당신은 다시 평범한 일상으로 돌아갑니다. 상을 차리고, 손님을 맞고, 그릇을 정리하는 날들.

그러나 떡을 떼고 잔을 들 때마다, 당신은 그 밤을 떠올릴 것입니다. 약한 자들의 발을 씻기고, 배신자에게까지 떡을 떼어 주시던 그 사랑을. 그것은 잊히지 않을 씨앗이 되어, 당신 안에서 조용히 자라기 시작했습니다.

📖 누가복음 22:19
"이것은 너희를 위하여 주는 내 몸이라 너희가 이를 행하여 나를 기념하라"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade');

  INSERT INTO public.choices (scene_id, label, next_scene_id, choice_order) VALUES
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=1), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '손끝 하나까지 정성을 다해 상을 차리며 설렌다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=3), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '평소와 다른 그분의 어두운 안색이 마음에 걸린다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=4), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '이 귀한 분들을 모시게 된 것이 더없이 영광스럽다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=3), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=4), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), '당황스럽다 — 저건 종인 내가 해야 할 일인데', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), '가슴이 뭉클하다 — 가장 높은 분이 가장 낮은 자리로 내려오시다니', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), '부끄럽다 — 나는 진심으로 누구의 발도 씻겨 본 적이 없는데', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), '무슨 뜻인지 알 수 없어 가슴이 서늘하다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), '곧 무슨 일이 닥칠 것 같은 불길함이 든다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), '자기를 다 내어 주신다는 그 말씀의 무게에 숨이 막힌다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), '누구일까, 제자들의 얼굴을 하나하나 살핀다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), '이 사랑의 식탁에 배신자가 있다니 믿기지 않는다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), '''나라면 끝까지 신실할 수 있을까'' 나 자신을 돌아본다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), '다 아시면서도 함께 잡수신 그 사랑에 가슴이 미어진다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=24), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), '큰소리치는 베드로가 곧 흔들릴까 못내 걱정된다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), '나의 약함과 배신까지 아시고도 품으시는 걸까, 뭉클하다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=24), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '''나를 기념하여 행하라''는 말씀대로, 이 사랑을 기억하며 살리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=28), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '어떤 밤이 와도 이분을 끝까지 따르리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=29), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '약한 나까지 품으신 이 저녁을, 평생 잊지 않으리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=30), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=28), '챕터 완료', NULL, 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=29), '챕터 완료', NULL, 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=30), '챕터 완료', NULL, 1);

END $$;
