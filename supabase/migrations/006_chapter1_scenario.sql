-- 갈릴리의 부름 (Chapter 1) 시나리오 데이터
-- 기존 장면/선택지 초기화 후 재삽입

DELETE FROM public.choices WHERE scene_id IN (SELECT id FROM public.scenes WHERE chapter_id = 2);
DELETE FROM public.scenes WHERE chapter_id = 2;

DO $$
DECLARE
  s1  INT; s2  INT; s3  INT; s4  INT; s5  INT;
  s6  INT; s7  INT; s8  INT; s9  INT; s10 INT;
  bg  TEXT := 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/backgrounds/1780053537212-ChatGPT_Image_2026_3_4_09_26_50.png';
  ch  TEXT := 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/characters/1780054403695-KakaoTalk_20250514_115708537.jpg';
BEGIN

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (2, 1,
    '갈릴리 호수의 이른 아침. 물안개가 수면 위를 가로지르고, 어부들이 하룻밤의 조업을 마치고 그물을 정리하고 있습니다.' || chr(10) || chr(10) ||
    '당신은 시몬 베드로의 어린 조수로, 오늘도 지친 몸을 이끌며 그물을 씻고 있습니다.',
    bg, NULL, NULL, 'fade') RETURNING id INTO s1;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (2, 2,
    '그때, 군중들 사이에서 한 사람이 호숫가를 따라 걸어옵니다. 사람들이 그분을 향해 몰려들기 시작하자, 베드로가 조용히 당신에게 속삭입니다.' || chr(10) || chr(10) ||
    '"저분이… 나사렛 예수라네. 요즘 온 갈릴리에 소문이 자자한 분이야."',
    bg, ch, NULL, 'fade') RETURNING id INTO s2;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (2, 3,
    '예수께서 호숫가를 걷다가 시몬 베드로와 그의 형제 안드레가 그물 던지는 것을 보셨습니다. 그분이 멈춰 서서 그들을 부르십니다.' || chr(10) || chr(10) ||
    '"나를 따라오라. 내가 너희를 사람을 낚는 어부가 되게 하리라."' || chr(10) || chr(10) ||
    '당신은 어떻게 할까요?',
    bg, ch, NULL, 'fade') RETURNING id INTO s3;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (2, 4,
    '당신은 조심스럽게 그분 가까이 다가갑니다. 예수님의 목소리는 크지 않았지만, 묘하게 온 몸에 울려 퍼지는 느낌이었습니다.' || chr(10) || chr(10) ||
    '그분의 눈이 잠깐 당신과 마주쳤고, 따뜻하면서도 깊은 눈빛에 가슴이 두근거렸습니다.',
    bg, ch, NULL, 'fade') RETURNING id INTO s4;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (2, 5,
    '당신은 그물을 붙잡은 채 멀리서 지켜봅니다. 베드로의 표정이 달라지는 것이 보였습니다.' || chr(10) || chr(10) ||
    '의심 가득했던 눈빛이 점점 흔들리더니, 무언가에 붙잡힌 듯 그물을 천천히 내려놓기 시작했습니다.',
    bg, NULL, NULL, 'fade') RETURNING id INTO s5;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (2, 6,
    '베드로와 안드레는 즉시 그물을 버려두고 예수님을 따라나섰습니다. 평생 붙들고 살던 생업을 단 한 마디에 내려놓은 것입니다.' || chr(10) || chr(10) ||
    '당신은 멍하니 그들의 뒷모습을 바라봅니다. "저게… 가능한 일인가?"',
    bg, NULL, NULL, 'fade') RETURNING id INTO s6;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (2, 7,
    '예수님의 행렬이 조금 더 나아가자, 세베대의 아들 야고보와 요한이 배에서 그물을 깁고 있었습니다. 예수님이 그들도 부르시자, 두 형제 역시 아버지와 배를 그 자리에 두고 일어나 따라갔습니다.' || chr(10) || chr(10) ||
    '당신의 마음속에는 어떤 감정이 일어납니까?',
    bg, NULL, NULL, 'fade') RETURNING id INTO s7;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (2, 8,
    '당신의 발걸음이 저절로 그들을 따라가기 시작합니다.' || chr(10) || chr(10) ||
    '"나도… 저분을 따라가고 싶다." 이유를 설명할 수는 없지만, 가슴 속에서 무언가가 강하게 당기는 느낌이었습니다.',
    bg, NULL, NULL, 'fade') RETURNING id INTO s8;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (2, 9,
    '야고보와 요한도 망설임 없이 일어나는 것을 보며, 당신은 말로 표현할 수 없는 감정을 느낍니다.' || chr(10) || chr(10) ||
    '부러움인지, 두려움인지. "나였다면 과연 저렇게 할 수 있었을까…"',
    bg, NULL, NULL, 'fade') RETURNING id INTO s9;

  INSERT INTO public.scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (2, 10,
    '그날 이후, 갈릴리의 어부 네 명이 예수님과 함께 사라졌습니다. 호숫가엔 버려진 그물만이 남아 출렁이고 있었습니다.' || chr(10) || chr(10) ||
    '당신은 그 그물을 바라보며 생각합니다.' || chr(10) ||
    '"부름이란 무엇일까. 나에게도 저런 날이 올까…"' || chr(10) || chr(10) ||
    '📖 마태복음 4:19' || chr(10) ||
    '"나를 따라오라, 내가 너희를 사람을 낚는 어부가 되게 하리라"',
    bg, NULL, NULL, 'fade') RETURNING id INTO s10;

  -- 선택지 연결
  INSERT INTO public.choices (scene_id, label, next_scene_id, choice_order) VALUES
    (s1,  '계속 →',                   s2,   1),
    (s2,  '계속 →',                   s3,   1),
    (s3,  '가까이 다가가 말씀을 듣는다', s4,   1),
    (s3,  '멀리서 지켜본다',            s5,   2),
    (s4,  '계속 →',                   s6,   1),
    (s5,  '계속 →',                   s6,   1),
    (s6,  '계속 →',                   s7,   1),
    (s7,  '나도 저분을 따라가고 싶다',   s8,   1),
    (s7,  '그들이 부럽고 두렵다',        s9,   2),
    (s8,  '계속 →',                   s10,  1),
    (s9,  '계속 →',                   s10,  1),
    (s10, '챕터 완료',                 NULL, 1);

END $$;
