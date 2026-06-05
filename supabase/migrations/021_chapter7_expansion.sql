-- =====================================================================
-- 선한 사마리아인 (Chapter 7) — 확장판  [자동 생성: _apply.mjs]
-- 컨셉: 비유. 플레이어는 비유 속 '여리고 길의 가난한 나그네'로 들어가 목격한다.
--       구원은 사마리아인이 행하며(성경 결과 유지), 플레이어의 선택은 자신의 마음만 바꾼다.
-- 본문: 누가복음 10:25-37 (선한 사마리아인 비유)
-- 구조: 5막 · 30씬 · 분기 6곳 · 엔딩 3개   BGM: morning→throne→snowfield
-- =====================================================================

DO $$
DECLARE chap INT;
BEGIN
  SELECT id INTO chap FROM public.chapters WHERE chapter_num = 7;
  IF chap IS NULL THEN RAISE EXCEPTION 'chapter_num=7 챕터를 찾을 수 없습니다.'; END IF;

  DELETE FROM public.choices WHERE scene_id IN (SELECT id FROM public.scenes WHERE chapter_id = chap);
  DELETE FROM public.scenes WHERE chapter_id = chap;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition) VALUES
    (chap, 1, '한 율법교사가 예수님을 시험하려고 물었습니다. "선생님, 그러면 내 이웃이 누구입니까?"

예수님은 곧장 답하지 않으시고, 한 가지 이야기를 들려주기 시작하셨습니다. 무리 속에서 그 이야기를 듣던 당신은, 어느새 자신이 그 이야기 속 여리고 길 위에 서 있는 것을 느낍니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 2, '예루살렘에서 여리고로 내려가는 길. 당신은 봇짐 하나 멘 가난한 나그네입니다. 굽이굽이 험한 내리막에, 인적이라곤 찾아볼 수 없습니다.

예부터 강도가 자주 나온다는 흉흉한 길이었습니다. 당신은 이 길을 어떻게 걷고 있습니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 3, '당신은 부지런히 발을 놀립니다. 이런 길에서 어둠을 만나는 것만큼 위험한 일도 없으니까요.

마음이 급한 탓에, 길가의 풍경 따위는 눈에 들어오지도 않았습니다. 그저 무사히 이 길을 벗어나는 것만이 머릿속에 가득했습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 4, '당신은 바위 그늘 하나, 수풀 하나에도 신경을 곤두세우며 걷습니다. 어디서 강도가 튀어나올지 모른다는 두려움이 발끝까지 따라붙었습니다.

그 긴장 속에서, 당신은 누군가를 도울 여유 같은 건 미처 생각하지 못한 채 길을 재촉했습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 5, '당신은 굳이 서두르지 않고, 지친 다리를 쉬어 가며 천천히 걷습니다. 어차피 가진 것도 없으니 강도를 만난들 빼앗길 것도 없다는 생각이었지요.

그렇게 느긋이 모퉁이를 돌던 그때, 당신의 발걸음을 멈추게 하는 무언가가 눈에 들어왔습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3', 'fade'),
    (chap, 6, '길 한복판에 한 사람이 쓰러져 있었습니다. 옷이 다 벗겨지고 온몸이 피투성이가 된 채, 가느다란 신음만 흘리고 있었습니다.

강도를 만난 것이 분명했습니다. 그는 거의 죽어 가고 있었고, 이 외진 길에 그를 본 사람은 — 지금으로선 당신뿐이었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 7, '당신의 가슴이 철렁 내려앉았습니다. 그러나 당신 또한 가진 것 없고 힘없는 나그네일 뿐. 그를 온전히 구할 처지가 못 됩니다.

쓰러진 그를 앞에 두고, 당신의 마음에는 먼저 무엇이 떠오릅니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 8, '당신은 주위를 두리번거립니다. "이렇게 사람을 만들어 놓고, 강도들이 멀리 갔을 리 없어." 다음 차례가 당신이 될지도 모른다는 공포가 발목을 잡았습니다.

쓰러진 이가 가여웠지만, 두려움이 연민을 짓눌렀습니다. 당신은 어쩔 줄 모른 채 그 자리에 굳어 있었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 9, '당신은 안타까움에 발을 동동 굴렀습니다. 상처를 싸맬 천도, 그를 태울 짐승도, 주막에 맡길 돈도 — 당신에겐 아무것도 없었습니다.

"내가 무얼 할 수 있단 말인가." 빈손인 자신이 이토록 원망스러운 적이 없었습니다. 그저 그의 신음만이 가슴을 후벼 팠습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 10, '솔직히, 당신의 마음 한구석에서는 그냥 지나치라는 목소리가 들렸습니다. "괜히 엮였다가 무슨 봉변을 당하려고."

그러나 그렇게 생각하는 순간, 당신은 스스로가 견딜 수 없이 부끄러워졌습니다. 죽어 가는 사람을 앞에 두고 셈부터 하는 자신이.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 11, '그때, 저편에서 한 사람이 내려오는 것이 보였습니다. 옷차림을 보니 성전에서 섬기는 제사장이었습니다.

당신은 내심 안도했습니다. "하나님을 섬기는 분이니, 분명 이 사람을 도우시겠지." 그러나 제사장은 쓰러진 이를 흘긋 보더니, 오히려 길 반대편으로 피해 지나가 버렸습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 12, '잠시 후, 이번엔 레위인 한 사람이 그곳에 이르렀습니다. 성전 일을 돕는 사람이니, 그라면 다를 줄 알았습니다.

그러나 레위인 역시 가까이 와서 그를 보고는, 마치 못 볼 것을 본 듯 길 저편으로 비켜 지나갔습니다. 쓰러진 이의 신음만이 텅 빈 길에 남았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 13, '거룩하다는 두 사람이 차례로 외면하고 지나가는 것을, 당신은 두 눈으로 똑똑히 보았습니다.

그 광경 앞에서, 당신의 마음에는 무엇이 일어납니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 14, '당신은 분노가 치밀었습니다. "성전에서 하나님을 섬긴다는 사람들이, 죽어 가는 이를 두고 어떻게 길 건너로 피할 수가 있나."

그들의 거룩한 옷차림과 그 차가운 뒷모습 사이의 간극이, 당신을 견딜 수 없게 만들었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 15, '당신은 그들을 차마 욕할 수만은 없었습니다. 방금 전, 두려움에 발이 묶였던 당신 자신이 떠올랐으니까요.

"부정을 탈까 봐, 위험할까 봐… 저들도 저들 나름의 이유가 있었겠지." 그러나 그 이해의 끝에는, 어쩐지 더 깊은 씁쓸함이 남았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 16, '당신은 가슴이 무너지는 것 같았습니다. 마지막 희망이었던 두 사람마저 지나가 버리자, 이 사람은 정말 이대로 죽는구나 싶었습니다.

"이 길에 자비란 없는 걸까." 당신은 어쩌지도 못한 채, 점점 약해지는 그의 숨소리를 들으며 절망에 잠겼습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3', 'fade'),
    (chap, 17, '그때, 또 한 사람이 길을 따라 내려왔습니다. 행색을 보니 — 사마리아인이었습니다. 유대인들이 상종조차 하지 않고 멸시하던 바로 그 사마리아 사람.

당신은 그를 보며 별 기대를 품지 않았습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076373910-c42b48cd-3044-4042-84e3-3bf8d990159f.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 18, '멸시받는 사마리아인이 쓰러진 유대인 앞에 멈춰 섭니다. 당신은 그가 어떻게 할지, 마른침을 삼키며 지켜봅니다.

당신은 속으로 어떻게 예상합니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076373910-c42b48cd-3044-4042-84e3-3bf8d990159f.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 19, '당신은 속으로 코웃음을 쳤습니다. "제사장도, 레위인도 외면했는데, 천대받는 사마리아인이 뭘 하겠어."

어쩌면 당신은, 그가 그냥 지나가 주기를 — 그래서 당신의 냉소가 옳았음을 확인받고 싶었는지도 모릅니다. 사람을 겉모습으로 가르는 그 마음이, 당신 안에도 있었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 20, '당신은 까닭 모를 기대로 그를 지켜봅니다. "거룩한 사람들도 못 한 일을, 설마 저 사람이…?"

멸시받는 자에게서 무언가를 기대하는 자신이 낯설었지만, 당신은 그의 다음 행동에서 눈을 뗄 수 없었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 21, '사마리아인은 쓰러진 이를 보고 ''불쌍히 여겼습니다.'' 그는 다가가 자기 짐에서 기름과 포도주를 꺼내 상처를 싸매고, 자신의 나귀에 그를 태워 주막으로 데려갔습니다.

밤새 그를 돌본 그는, 이튿날 두 데나리온을 꺼내 주막 주인에게 맡기며 말했습니다. "이 사람을 돌보아 주시오. 비용이 더 들면, 내가 돌아올 때 갚으리다."', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076373910-c42b48cd-3044-4042-84e3-3bf8d990159f.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 22, '당신은 그 모든 광경을 지켜보았습니다. 멸시받던 자가, 거룩하다는 이들도 외면한 일을 묵묵히 해내는 것을.

당신의 가슴에는 무엇이 차오릅니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 23, '당신은 고개를 들 수 없었습니다. 그를 행색만 보고 냉소했던 자신이, 정작 죽어 가는 이 앞에서 아무것도 하지 못했으니까.

"멸시받아 마땅한 건… 어쩌면 나였구나." 겉모습으로 사람을 재던 당신의 잣대가, 산산이 부서지는 순간이었습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 24, '당신의 가슴이 뜨겁게 차올랐습니다. 이웃이란 핏줄이나 신분으로 정해지는 것이 아니었습니다.

자비를 베푸는 자, 멈춰 서서 손을 내미는 자 — 그가 바로 이웃이었습니다. 당신은 비로소, ''이웃''이라는 말의 참뜻을 두 눈으로 본 듯했습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 25, '당신의 눈에서 뜨거운 눈물이 흘러내렸습니다. 강도 만나 죽어 가던 그 사람이, 마치 당신 자신처럼 느껴졌으니까요.

누군가 멈춰 서서 그렇게 싸매어 주고 돌보아 주기를, 당신 또한 얼마나 바라 왔던가. 그리고 동시에, 당신도 누군가에게 그런 사람이 되고 싶어졌습니다.', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 26, '그 광경이 아지랑이처럼 흩어지고, 당신은 다시 무리 속에 서 있는 자신을 발견합니다. 예수님이 율법교사를 바라보며 물으셨습니다.

"네 생각에는 이 세 사람 중에 누가 강도 만난 자의 이웃이 되겠느냐?" 율법교사가 답했습니다. "자비를 베푼 자니이다." 그러자 예수님이 말씀하셨습니다. "가서 너도 이와 같이 하라."', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg', NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 27, '"가서 너도 이와 같이 하라." 그 말씀은 율법교사만이 아니라, 길 위에서 머뭇거리기만 했던 당신의 가슴에도 곧장 와 박혔습니다.

당신은 이 이야기를, 이제 어떻게 살아내시겠습니까?', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 28, '당신은 깨달았습니다. 처음 율법교사의 물음은 "내 이웃이 누구인가"였지만, 정작 중요한 물음은 "나는 누구의 이웃이 되어 줄 것인가"였음을.

이제 당신은 길에서 쓰러진 누군가를 만나면, 셈하기 전에 먼저 멈춰 서기로 합니다. 거룩한 옷을 입은 사람이 아니라, 자비를 베푸는 사람이 되기로.

📖 누가복음 10:37
"예수께서 이르시되 가서 너도 이와 같이 하라 하시니라"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 29, '당신은 이런 이야기를 들려주신 분이 더없이 궁금해졌습니다. 멸시받는 사마리아인을 참된 이웃으로 세우신 그분의 마음을, 더 알고 싶었습니다.

무리가 흩어진 뒤에도, 당신의 발은 그분이 가시는 쪽으로 향합니다. 이름 없는 한 사람으로, 자비가 무엇인지 그분께 더 배우기 위하여.

📖 누가복음 10:37
"예수께서 이르시되 가서 너도 이와 같이 하라 하시니라"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade'),
    (chap, 30, '당신은 다시 일상으로 돌아갑니다. 여전히 바쁘고, 여전히 두렵고, 여전히 가진 것 없는 날들.

그러나 길가에 누군가 쓰러져 있을 때마다, 당신은 그 비유를 떠올릴 것입니다. 외면하고 지나간 이들과, 멈춰 서서 싸매어 준 한 사람을. ''가서 너도 이와 같이 하라''는 그 말씀은, 잊히지 않을 씨앗이 되어 당신 안에서 자라기 시작했습니다.

📖 누가복음 10:37
"예수께서 이르시되 가서 너도 이와 같이 하라 하시니라"', 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg', NULL, NULL, 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3', 'fade');

  INSERT INTO public.choices (scene_id, label, next_scene_id, choice_order) VALUES
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=1), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '해가 지기 전에 빠져나가려 걸음을 재촉한다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=3), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '혹시 모를 위험에 주위를 두리번거리며 조심조심 걷는다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=4), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=2), '지친 다리를 달래며 느릿느릿 걸음을 옮긴다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=3), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=4), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=5), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=6), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), '가엾지만… 강도가 아직 근처에 숨어 있을까 봐 겁이 난다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), '돕고 싶어도, 내겐 약도 돈도 그를 옮길 힘도 없다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=7), '못 본 척 지나치고 싶은 마음이 든다 — 그리고 그런 자신이 부끄럽다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=8), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=9), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=10), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=11), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=12), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), '분노가 치민다 — 하나님을 섬긴다는 자들이 어떻게 저럴 수가', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), '씁쓸하지만 이해도 된다 — 나도 무서워 못 갔으니, 그들도 사정이 있겠지', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=13), '절망스럽다 — 그럼 이 사람은 이대로 죽는 건가', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=14), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=15), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=16), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=17), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), '''사마리아인 주제에, 저 사람도 결국 그냥 지나가겠지'' 냉소한다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=18), '''혹시… 저 사람만은 다를까?'' 일말의 기대로 지켜본다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=19), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=20), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=21), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), '부끄럽다 — 내가 속으로 멸시하던 그가, 나보다 훨씬 나은 사람이었다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), '가슴이 뜨거워진다 — 바로 이것이 참된 이웃의 모습이구나', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=24), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=22), '눈물이 난다 — 나도 저런 사랑을 받고 싶고, 또 베풀고 싶어진다', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=23), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=24), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=25), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=26), '계속 →', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '누구를 만나든, 내가 먼저 그의 이웃이 되어 주리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=28), 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '자비가 무엇인지 더 배우고 싶다 — 이 말씀을 하신 분을 따르리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=29), 2),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=27), '''가서 너도 이와 같이 하라''를 평생 가슴에 새겨 두리라', (SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=30), 3),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=28), '챕터 완료', NULL, 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=29), '챕터 완료', NULL, 1),
    ((SELECT id FROM public.scenes WHERE chapter_id=chap AND scene_order=30), '챕터 완료', NULL, 1);

END $$;
