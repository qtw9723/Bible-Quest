-- =====================================================================
-- 갈릴리의 부름 (Chapter 1) — 확장판 시나리오
-- =====================================================================
-- 컨셉: 플레이어는 '시몬 베드로의 어린 조수' — 성경 사건을 곁에서 지켜보는
--       이름 없는 관찰자. 선택은 성경의 결과(예수·베드로가 하는 일)를 바꾸지
--       않으며, 오직 '나 자신'의 위치/마음/주변 교류/개인 행동만 바꾼다.
--       분기는 갈라졌다가 성경의 고정점(anchor)에서 다시 합류한다.
--
-- 추가 본문: 마태복음 4:18-22(부르심) + 누가복음 5:1-11(깊은 데로/기적적 어획)
--
-- 구조: 4막 · 23씬 · 분기 6곳 · 엔딩 3개
--   [1막 빈 그물의 새벽]   s1 → s2 →(3분기)→ s4
--   [2막 그분의 등장]      s4 →(2분기)→ s6
--   [3막 깊은 데로]        s6 →(2분기)→ s8 →(2분기)→ s10 → s11 →(3분기)→ s13
--   [4막 부르심과 결단]    s13 →(3엔딩) e_follow / e_stay / e_remember
--
-- BGM 아크: morning(아침 테마) → throne(부름의 순간) → snowfield(여운)
-- 실행: Supabase Dashboard → SQL Editor 에서 본 파일 전체 실행
-- =====================================================================

DO $$
DECLARE
  chap INT;
  -- 씬 id 보관용
  s1 INT; s2 INT; s3a INT; s3b INT; s3c INT;
  s4 INT; s5c INT; s5r INT;
  s6 INT; s7a INT; s7b INT; s8 INT; s9d INT; s9h INT;
  s10 INT; s11 INT; s12a INT; s12f INT; s12w INT;
  s13 INT; ef INT; es INT; er INT;
  -- 에셋 URL
  bg       TEXT := 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg';
  jesus    TEXT := 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg';
  peter    TEXT := 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780066640469-ac2dbd22-e1e5-4a6e-942c-be05036b6436.jpg';
  morning  TEXT := 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101158917-3.mp3';
  throne   TEXT := 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780101284801-4.mp3';
  snowfield TEXT := 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/bgm/1780071045784-Falling_Snowfield.mp3';
  nl TEXT := chr(10) || chr(10);  -- 문단 구분
BEGIN
  -- 챕터 id 동적 해석 (chapter_num = 1)
  SELECT id INTO chap FROM public.chapters WHERE chapter_num = 1;
  IF chap IS NULL THEN
    RAISE EXCEPTION 'chapter_num = 1 챕터를 찾을 수 없습니다.';
  END IF;

  -- 기존 1챕터 장면/선택지 초기화
  DELETE FROM public.choices WHERE scene_id IN (SELECT id FROM public.scenes WHERE chapter_id = chap);
  DELETE FROM public.scenes WHERE chapter_id = chap;

  -- ================= [1막 빈 그물의 새벽] =================

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 1,
    '갈릴리 호수의 새벽. 물안개가 잿빛 수면 위를 천천히 기어다니고, 밤새 호수로 나갔던 배들이 하나둘 빈 손으로 돌아옵니다.' || nl ||
    '당신은 시몬 베드로의 어린 조수입니다. 오늘도 밤을 꼬박 새웠지만 그물에 걸린 것이라곤 물풀과 모래뿐. 무거운 그물을 끌어올리는 어깨가 욱신거립니다.',
    bg, peter, NULL, morning, 'fade') RETURNING id INTO s1;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 2,
    '베드로가 텅 빈 배 바닥을 내려다보며 깊은 한숨을 내쉽니다. 곁에서 형 안드레가 말없이 젖은 그물을 추스릅니다.' || nl ||
    '"또 빈 배라니…" 어디선가 늙은 어부의 푸념이 들려옵니다. 지친 새벽의 공기 속에서, 당신은 무엇을 할까요?',
    bg, peter, NULL, morning, 'fade') RETURNING id INTO s2;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 3,
    '당신은 말없이 베드로 곁에 앉아 함께 그물을 폅니다. 거칠게 갈라진 그의 두 손, 소금기에 튼 손등이 눈에 들어옵니다.' || nl ||
    '"고생했다." 베드로가 짧게 내뱉습니다. 무뚝뚝하지만 그 한마디에 묘한 정이 배어 있습니다. 이 사람도 그저 하루하루를 견디는 한 인간이구나, 싶었습니다.',
    bg, peter, NULL, morning, 'fade') RETURNING id INTO s3a;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 4,
    '당신은 옆 배의 또래 조수 곁으로 다가갑니다. 그 아이가 목소리를 낮춰 속삭입니다.' || nl ||
    '"너 그 소문 들었어? 가버나움 회당에서 어떤 분이… 더러운 귀신 들린 사람을 말 한마디로 고쳤대. 나사렛에서 왔다는데, 온 갈릴리가 그 얘기뿐이야." 당신의 가슴 한구석이 까닭 없이 술렁입니다.',
    bg, NULL, NULL, morning, 'fade') RETURNING id INTO s3b;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 5,
    '당신은 조금 떨어진 호숫가에 홀로 앉아 텅 빈 수면을 바라봅니다. 떠오르는 해가 물결 위에 부서지고 있습니다.' || nl ||
    '"이 호수가… 내 평생의 전부일까." 매일 같은 새벽, 같은 그물, 같은 허기. 문득 가슴 깊은 곳에서 알 수 없는 갈증이 차오릅니다.',
    bg, NULL, NULL, morning, 'fade') RETURNING id INTO s3c;

  -- ================= [2막 그분의 등장] =================

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 6,
    '그때, 호숫가 저편이 술렁이기 시작합니다. 한 무리의 사람들이 누군가를 에워싸고 이쪽으로 몰려옵니다. 그 중심에 한 사람이 걸어오고 있습니다.' || nl ||
    '베드로가 그물을 추스르다 말고 나직이 중얼거립니다. "저분이… 나사렛 예수라네. 요즘 온 갈릴리가 떠들썩한 그 사람이야." 당신은 어디서 그분을 지켜볼까요?',
    bg, jesus, NULL, morning, 'fade') RETURNING id INTO s4;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 7,
    '당신은 사람들 틈을 비집고 군중 속으로 들어갑니다. 병든 가족을 업고 온 이, 지팡이에 의지한 노인, 눈물 그렁한 여인들이 그분께 닿으려 애쓰고 있습니다.' || nl ||
    '"저분이 손만 대면 낫는다더라." "아니, 말씀만 하셔도…" 들뜬 수군거림 사이로, 낮고 따뜻한 한 음성이 군중을 가르며 들려옵니다. 그 목소리에 이상하게 마음이 가라앉습니다.',
    bg, jesus, NULL, morning, 'fade') RETURNING id INTO s5c;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 8,
    '당신은 배를 매어둔 호숫가 바위 위로 올라가 멀찍이 전체를 내려다봅니다. 사람의 물결이 그분을 따라 천천히 호숫가로 밀려옵니다.' || nl ||
    '곁에 선 베드로의 옆얼굴이 보입니다. 평소의 무뚝뚝함은 어디 가고, 까닭 모를 긴장으로 그의 턱이 굳어 있습니다. 그분의 발걸음은 곧장 베드로의 배를 향하고 있었습니다.',
    bg, peter, NULL, morning, 'fade') RETURNING id INTO s5r;

  -- ================= [3막 깊은 데로 (눅 5)] =================

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 9,
    '무리에 떠밀리듯, 예수께서 마침 시몬의 배에 오르십니다. "배를 뭍에서 조금 떼어 놓으라." 베드로가 얼떨결에 노를 저어 배를 띄우자, 그분은 뱃전에 앉아 호숫가의 무리를 가르치기 시작하십니다.' || nl ||
    '당신은 배 한 귀퉁이에서 숨죽인 채 그 광경을 지켜봅니다. 무엇에 더 마음이 끌립니까?',
    bg, jesus, NULL, throne, 'fade') RETURNING id INTO s6;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 10,
    '당신은 그분의 말씀 한마디 한마디에 귀를 기울입니다. 어려운 율법 조항도, 위협도 없었습니다. 그저 하늘과 씨앗과 새들에 관한 이야기였는데도, 가슴 깊은 곳이 이상하게 데워집니다.' || nl ||
    '마치 오래전부터 당신을 알고 있던 누군가가, 당신만을 위해 건네는 말 같았습니다.',
    bg, jesus, NULL, throne, 'fade') RETURNING id INTO s7a;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 11,
    '당신은 노를 쥔 베드로의 얼굴에서 눈을 떼지 못합니다. 처음엔 떨떠름하게 먼 산을 보던 그였습니다.' || nl ||
    '그런데 말씀이 이어질수록, 그의 시선이 조금씩 그분께로 빨려듭니다. 굳었던 어깨가 풀리고, 거친 숨이 잦아들고, 무언가에 붙들린 사람처럼 입술이 살며시 벌어집니다.',
    bg, peter, NULL, throne, 'fade') RETURNING id INTO s7b;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 12,
    '말씀을 마치신 예수께서 베드로를 돌아보십니다. "깊은 데로 가서 그물을 내려 고기를 잡으라."' || nl ||
    '베드로가 잠시 머뭇거리다 입을 엽니다. "스승님, 우리가 밤이 새도록 수고하였으되 잡은 것이 없지만… 말씀에 의지하여 내리겠나이다." 당신은 속으로 무슨 생각을 합니까?',
    bg, jesus, NULL, throne, 'fade') RETURNING id INTO s8;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 13,
    '"한낮에, 그것도 밤새 허탕 친 그 자리에서 고기가 잡힌다고?" 당신은 반신반의하며 노 젓는 일을 돕습니다.' || nl ||
    '그물이 깊고 어두운 물속으로 천천히 가라앉습니다. 당신은 별 기대 없이, 그저 시키는 대로 밧줄을 붙잡고 있을 뿐이었습니다.',
    bg, peter, NULL, throne, 'fade') RETURNING id INTO s9d;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 14,
    '까닭은 알 수 없지만, 당신의 심장이 두근거리기 시작합니다. "어쩌면… 무슨 일이 일어날지도 몰라." 당신은 서둘러 그물 내리는 일을 거듭니다.' || nl ||
    '그물이 깊고 어두운 물속으로 가라앉는 동안, 당신은 자기도 모르게 숨을 죽인 채 수면을 응시합니다.',
    bg, peter, NULL, throne, 'fade') RETURNING id INTO s9h;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 15,
    '순간, 밧줄이 팽팽해지며 배가 한쪽으로 크게 기웁니다! 그물이 찢어질 듯 무겁습니다. 끌어올리자 은빛 물고기들이 폭포처럼 쏟아져 배 안을 가득 메웁니다.' || nl ||
    '"이쪽으로! 빨리!" 다급히 부른 동료의 배까지 달려와 함께 끌어올리지만, 두 배가 고기로 가라앉을 지경입니다. 당신은 넘쳐나는 물고기 속에서 다리가 후들거립니다.',
    bg, peter, NULL, throne, 'fade') RETURNING id INTO s10;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 16,
    '그 광경 앞에서, 베드로가 털썩 무릎을 꿇더니 예수의 발 앞에 엎드립니다.' || nl ||
    '"주여, 나를 떠나소서. 나는 죄인이로소이다." 평생 호수를 호령하던 그 거친 사내가, 어린아이처럼 떨고 있었습니다. 그 순간, 당신의 몸은 어떻게 반응합니까?',
    bg, jesus, peter, throne, 'fade') RETURNING id INTO s11;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 17,
    '당신은 자기도 모르게 무릎이 꺾여, 베드로 곁에 함께 엎드립니다. 감히 고개를 들 수 없었습니다.' || nl ||
    '이것은 운이나 우연이 아니었습니다. 당신의 온몸이, 설명할 수 없는 어떤 거룩함 앞에 서 있음을 알고 있었습니다.',
    bg, NULL, NULL, throne, 'fade') RETURNING id INTO s12a;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 18,
    '당신은 놀라 뒷걸음질치다 뱃전에 등을 기댑니다. 차마 다가갈 수도, 눈을 뗄 수도 없었습니다.' || nl ||
    '가슴이 쿵쿵 뛰었습니다. 기쁨인지 두려움인지 알 수 없는 무언가가 온몸을 휘감았습니다. "이분은… 대체 누구신가."',
    bg, NULL, NULL, throne, 'fade') RETURNING id INTO s12f;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 19,
    '당신은 발치에 넘쳐나는 물고기를 멍하니 두 손으로 만져 봅니다. 차갑고, 미끄럽고, 분명히 진짜였습니다.' || nl ||
    '꿈이 아니었습니다. 방금 두 눈으로 본 일을 머리가 도무지 따라잡지 못합니다. 당신은 그저 입을 벌린 채 그분을 바라볼 뿐이었습니다.',
    bg, NULL, NULL, throne, 'fade') RETURNING id INTO s12w;

  -- ================= [4막 부르심과 결단] =================

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 20,
    '예수께서 떨고 있는 베드로를 일으키며 말씀하십니다. "무서워하지 말라. 이제 후로는 네가 사람을 취하리라."' || nl ||
    '베드로와 안드레, 그리고 세베대의 두 아들 야고보와 요한이 배를 뭍에 대고는, 모든 것을 그 자리에 버려둔 채 그분을 따라나섭니다. 멀어지는 그들의 뒷모습을 보며, 당신의 마음은 어디로 향합니까?',
    bg, jesus, NULL, throne, 'fade') RETURNING id INTO s13;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 21,
    '당신의 발이 저절로 움직입니다. 그물도, 배도, 어제까지의 삶도 등 뒤에 남겨둔 채, 당신은 그 행렬의 맨 끝에서 조용히 걸음을 옮깁니다.' || nl ||
    '이름도 없는 한 사람으로. 그러나 분명히, 그분을 따라가는 한 사람으로. 무엇이 기다릴지 알 수 없지만, 가슴만은 그 어느 때보다 벅찼습니다.' || nl ||
    '📖 마태복음 4:19' || chr(10) ||
    '"나를 따라오라, 내가 너희를 사람을 낚는 어부가 되게 하리라"',
    bg, NULL, NULL, snowfield, 'fade') RETURNING id INTO ef;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 22,
    '차마 발이 떨어지지 않았습니다. 당신은 멀어지는 그들의 뒷모습을 끝까지 바라보다, 버려진 그물을 천천히 끌어안습니다.' || nl ||
    '가슴속엔 지울 수 없는 울림이 남았습니다. "언젠가… 나에게도 그런 날이 올까." 호숫가에 홀로 선 당신의 그림자가 아침 해에 길게 늘어집니다.' || nl ||
    '📖 마태복음 4:19' || chr(10) ||
    '"나를 따라오라, 내가 너희를 사람을 낚는 어부가 되게 하리라"',
    bg, NULL, NULL, snowfield, 'fade') RETURNING id INTO es;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, character2, bgm_url, bgm_transition)
  VALUES (chap, 23,
    '당신은 따라나서지 못한 채 일상의 자리로 돌아갑니다. 그러나 어제의 당신과 오늘의 당신은 같지 않았습니다.' || nl ||
    '빈 그물을 씻는 새벽마다, 깊은 데서 그물이 차오르던 그 순간이, 그 낮고 따뜻한 음성이 가슴속에 또렷이 되살아납니다. 그 부르심은, 잊히지 않을 씨앗이 되어 당신 안에 남았습니다.' || nl ||
    '📖 마태복음 4:19' || chr(10) ||
    '"나를 따라오라, 내가 너희를 사람을 낚는 어부가 되게 하리라"',
    bg, NULL, NULL, snowfield, 'fade') RETURNING id INTO er;

  -- ================= 선택지 연결 =================
  INSERT INTO public.choices (scene_id, label, next_scene_id, choice_order) VALUES
    -- 1막
    (s1,  '계속 →',                                  s2,   1),
    (s2,  '베드로 곁으로 가 말없이 그물을 함께 정리한다', s3a,  1),
    (s2,  '옆 배의 또래 조수 곁에서 푸념을 듣는다',       s3b,  2),
    (s2,  '혼자 호숫가에 앉아 텅 빈 수면을 바라본다',     s3c,  3),
    (s3a, '계속 →',                                  s4,   1),
    (s3b, '계속 →',                                  s4,   1),
    (s3c, '계속 →',                                  s4,   1),
    -- 2막
    (s4,  '군중 속으로 비집고 들어간다',                s5c,  1),
    (s4,  '배 곁 바위에 올라 멀리서 지켜본다',           s5r,  2),
    (s5c, '계속 →',                                  s6,   1),
    (s5r, '계속 →',                                  s6,   1),
    -- 3막
    (s6,  '그분의 말씀 한마디 한마디에 귀를 기울인다',    s7a,  1),
    (s6,  '베드로의 표정 변화를 살핀다',                s7b,  2),
    (s7a, '계속 →',                                  s8,   1),
    (s7b, '계속 →',                                  s8,   1),
    (s8,  '설마 이 시간에 고기가… 의심스럽다',           s9d,  1),
    (s8,  '어쩐지 가슴이 뛴다. 무슨 일이 일어날 것만 같다', s9h,  2),
    (s9d, '계속 →',                                  s10,  1),
    (s9h, '계속 →',                                  s10,  1),
    (s10, '계속 →',                                  s11,  1),
    (s11, '나도 모르게 무릎이 꺾여 함께 엎드린다',        s12a, 1),
    (s11, '놀라 뒤로 물러서며 그 광경을 응시한다',        s12f, 2),
    (s11, '이게 꿈인가… 가득 찬 고기를 멍하니 만져본다',   s12w, 3),
    (s12a,'계속 →',                                  s13,  1),
    (s12f,'계속 →',                                  s13,  1),
    (s12w,'계속 →',                                  s13,  1),
    -- 4막 (엔딩 분기)
    (s13, '나도 모든 것을 두고 그들의 뒤를 따라 걷는다',   ef,   1),
    (s13, '차마 발이 떨어지지 않아 그 자리에 남는다',      es,   2),
    (s13, '지금은 따라가지 못해도, 그분을 마음 깊이 새긴다', er,   3),
    -- 엔딩 → 챕터 완료
    (ef,  '챕터 완료',                                NULL, 1),
    (es,  '챕터 완료',                                NULL, 1),
    (er,  '챕터 완료',                                NULL, 1);

END $$;
