-- ① 캐릭터 이미지 카테고리 수정 (backgrounds → characters)
UPDATE image_assets SET category = 'characters' WHERE name IN (
  '소년 (오병이어)', '선한 사마리아인', '아버지 (탕자의 아버지)',
  ' 마리아 (나사로의 누이)', ' 유다'
);

-- URL 변수
DO $$
DECLARE
  base TEXT := 'https://elqomxaemqiqalzhczfc.supabase.co/storage/v1/object/public/bible-quest/';

  -- 배경
  bg_갈릴리   TEXT := base || 'backgrounds/1780066644483-ba37e71c-eeb4-4b50-a33e-6289ae6293b7.jpg';
  bg_광야     TEXT := base || 'backgrounds/1780075421622-ed48e4de-bc39-4b45-994a-a128f472fc53.jpg';
  bg_산초원   TEXT := base || 'backgrounds/1780075666818-5a3cbeab-8f53-485f-8cf1-bd2e7837e080.jpg';
  bg_폭풍     TEXT := base || 'backgrounds/1780075872351-5ae29af8-4945-48da-a34a-7a75dfbbebd7.jpg';
  bg_들판     TEXT := base || 'backgrounds/1780075988588-d6dd2442-cab8-48ea-8aba-8ad8f8e5257d.jpg';
  bg_밤바다   TEXT := base || 'backgrounds/1780076018986-bbf951a6-bee9-41df-ada4-904328b9d063.jpg';
  bg_길       TEXT := base || 'backgrounds/1780076057716-e20abf2e-00d6-4d91-8a28-73d447d33cc3.jpg';
  bg_돼지농장 TEXT := base || 'backgrounds/1780076097234-9c8e2f4e-74b1-4043-b5e4-802f955be784.jpg';
  bg_무덤     TEXT := base || 'backgrounds/1780076132834-5f1890a9-1475-4b16-af7e-8753427fa45f.jpg';
  bg_다락방   TEXT := base || 'backgrounds/1780076212240-8f6c5335-8389-4e87-86fd-56dc2aa8adc6.jpg';
  bg_겟세마네 TEXT := base || 'backgrounds/1780076292843-33bbe0c3-0e7a-4e20-b0c6-0c10a4fd9c12.jpg';

  -- 캐릭터
  ch_예수    TEXT := base || 'characters/1780066635906-9b63e293-613e-4ab4-b3c9-3b394e081e2c.jpg';
  ch_베드로  TEXT := base || 'characters/1780066640469-ac2dbd22-e1e5-4a6e-942c-be05036b6436.jpg';
  ch_소년    TEXT := base || 'backgrounds/1780076342371-08c2c507-7b63-4763-8159-b9e77ec900fe.jpg';
  ch_사마리아 TEXT := base || 'backgrounds/1780076373910-c42b48cd-3044-4042-84e3-3bf8d990159f.jpg';
  ch_아버지  TEXT := base || 'backgrounds/1780076406708-c84d8c00-9842-4d18-92d8-9c81c9610078.jpg';
  ch_마리아  TEXT := base || 'backgrounds/1780076504415-6b0f0f7f-421c-4c5d-bcc1-b61880e50f4a.jpg';
  ch_유다    TEXT := base || 'backgrounds/1780076529569-0aef12b3-4f72-478f-a6e9-4d16a6c83873.jpg';

  -- BGM
  bgm_morning  TEXT := base || 'bgm/1780068239921-Morning_Over_Galilee.mp3';
  bgm_throne   TEXT := base || 'bgm/1780070087125-Throne_of_Dawn.mp3';
  bgm_snow     TEXT := base || 'bgm/1780071045784-Falling_Snowfield.mp3';

BEGIN

-- ════════════════════════════════
-- Ch2 광야의 시험 (13~18)
-- ════════════════════════════════
UPDATE scenes SET background=bg_광야, character=NULL,    bgm_url=bgm_morning, bgm_transition='fade' WHERE id=13;
UPDATE scenes SET background=bg_광야, character=ch_예수, bgm_url=bgm_morning, bgm_transition='fade' WHERE id=14;
UPDATE scenes SET background=bg_광야, character=ch_예수, bgm_url=bgm_throne,  bgm_transition='fade' WHERE id=15;
UPDATE scenes SET background=bg_광야, character=ch_예수, bgm_url=bgm_throne,  bgm_transition='fade' WHERE id=16;
UPDATE scenes SET background=bg_광야, character=ch_예수, bgm_url=bgm_throne,  bgm_transition='fade' WHERE id=17;
UPDATE scenes SET background=bg_광야, character=NULL,    bgm_url=bgm_snow,    bgm_transition='fade' WHERE id=18;

-- ════════════════════════════════
-- Ch3 산상수훈 (19~24)
-- ════════════════════════════════
UPDATE scenes SET background=bg_산초원, character=NULL,    bgm_url=bgm_morning, bgm_transition='fade' WHERE id=19;
UPDATE scenes SET background=bg_산초원, character=ch_예수, bgm_url=bgm_morning, bgm_transition='fade' WHERE id=20;
UPDATE scenes SET background=bg_산초원, character=ch_예수, bgm_url=bgm_morning, bgm_transition='fade' WHERE id=21;
UPDATE scenes SET background=bg_산초원, character=ch_예수, bgm_url=bgm_morning, bgm_transition='fade' WHERE id=22;
UPDATE scenes SET background=bg_산초원, character=ch_예수, bgm_url=bgm_morning, bgm_transition='fade' WHERE id=23;
UPDATE scenes SET background=bg_산초원, character=NULL,    bgm_url=bgm_snow,    bgm_transition='fade' WHERE id=24;

-- ════════════════════════════════
-- Ch4 풍랑을 잠재우심 (25~30)
-- ════════════════════════════════
UPDATE scenes SET background=bg_갈릴리, character=ch_베드로, bgm_url=bgm_morning, bgm_transition='fade' WHERE id=25;
UPDATE scenes SET background=bg_폭풍,   character=ch_베드로, bgm_url=bgm_throne,  bgm_transition='fade' WHERE id=26;
UPDATE scenes SET background=bg_폭풍,   character=ch_베드로, bgm_url=bgm_throne,  bgm_transition='fade' WHERE id=27;
UPDATE scenes SET background=bg_폭풍,   character=ch_베드로, bgm_url=bgm_throne,  bgm_transition='fade' WHERE id=28;
UPDATE scenes SET background=bg_폭풍,   character=ch_예수,   bgm_url=bgm_throne,  bgm_transition='fade' WHERE id=29;
UPDATE scenes SET background=bg_갈릴리, character=ch_예수,   bgm_url=bgm_snow,    bgm_transition='fade' WHERE id=30;

-- ════════════════════════════════
-- Ch5 오병이어 (31~36)
-- ════════════════════════════════
UPDATE scenes SET background=bg_들판, character=ch_소년,  bgm_url=bgm_morning, bgm_transition='fade' WHERE id=31;
UPDATE scenes SET background=bg_들판, character=ch_예수,  bgm_url=bgm_morning, bgm_transition='fade' WHERE id=32;
UPDATE scenes SET background=bg_들판, character=ch_소년,  bgm_url=bgm_throne,  bgm_transition='fade' WHERE id=33;
UPDATE scenes SET background=bg_들판, character=ch_소년,  bgm_url=bgm_throne,  bgm_transition='fade' WHERE id=34;
UPDATE scenes SET background=bg_들판, character=ch_예수,  bgm_url=bgm_throne,  bgm_transition='fade' WHERE id=35;
UPDATE scenes SET background=bg_들판, character=NULL,     bgm_url=bgm_snow,    bgm_transition='fade' WHERE id=36;

-- ════════════════════════════════
-- Ch6 물 위를 걸으심 (37~42)
-- ════════════════════════════════
UPDATE scenes SET background=bg_갈릴리, character=ch_베드로, bgm_url=bgm_morning, bgm_transition='fade' WHERE id=37;
UPDATE scenes SET background=bg_밤바다, character=ch_베드로, bgm_url=bgm_throne,  bgm_transition='fade' WHERE id=38;
UPDATE scenes SET background=bg_밤바다, character=ch_예수,   bgm_url=bgm_throne,  bgm_transition='fade' WHERE id=39;
UPDATE scenes SET background=bg_밤바다, character=ch_베드로, bgm_url=bgm_throne,  bgm_transition='fade' WHERE id=40;
UPDATE scenes SET background=bg_밤바다, character=ch_예수,   bgm_url=bgm_throne,  bgm_transition='fade' WHERE id=41;
UPDATE scenes SET background=bg_갈릴리, character=ch_예수,   bgm_url=bgm_snow,    bgm_transition='fade' WHERE id=42;

-- ════════════════════════════════
-- Ch7 선한 사마리아인 (43~48)
-- ════════════════════════════════
UPDATE scenes SET background=bg_길, character=NULL,        bgm_url=bgm_snow, bgm_transition='fade' WHERE id=43;
UPDATE scenes SET background=bg_길, character=NULL,        bgm_url=bgm_snow, bgm_transition='fade' WHERE id=44;
UPDATE scenes SET background=bg_길, character=ch_사마리아, bgm_url=bgm_snow, bgm_transition='fade' WHERE id=45;
UPDATE scenes SET background=bg_길, character=ch_사마리아, bgm_url=bgm_snow, bgm_transition='fade' WHERE id=46;
UPDATE scenes SET background=bg_길, character=ch_사마리아, bgm_url=bgm_snow, bgm_transition='fade' WHERE id=47;
UPDATE scenes SET background=bg_길, character=NULL,        bgm_url=bgm_snow, bgm_transition='fade' WHERE id=48;

-- ════════════════════════════════
-- Ch8 탕자의 귀환 (49~54)
-- ════════════════════════════════
UPDATE scenes SET background=bg_돼지농장, character=NULL,      bgm_url=bgm_snow,    bgm_transition='fade' WHERE id=49;
UPDATE scenes SET background=bg_돼지농장, character=NULL,      bgm_url=bgm_snow,    bgm_transition='fade' WHERE id=50;
UPDATE scenes SET background=bg_돼지농장, character=NULL,      bgm_url=bgm_snow,    bgm_transition='fade' WHERE id=51;
UPDATE scenes SET background=bg_돼지농장, character=NULL,      bgm_url=bgm_snow,    bgm_transition='fade' WHERE id=52;
UPDATE scenes SET background=bg_갈릴리,   character=ch_아버지, bgm_url=bgm_morning, bgm_transition='fade' WHERE id=53;
UPDATE scenes SET background=bg_갈릴리,   character=ch_아버지, bgm_url=bgm_morning, bgm_transition='fade' WHERE id=54;

-- ════════════════════════════════
-- Ch9 나사로를 살리심 (55~60)
-- ════════════════════════════════
UPDATE scenes SET background=bg_무덤, character=ch_마리아, bgm_url=bgm_snow,  bgm_transition='fade' WHERE id=55;
UPDATE scenes SET background=bg_무덤, character=ch_마리아, bgm_url=bgm_snow,  bgm_transition='fade' WHERE id=56;
UPDATE scenes SET background=bg_무덤, character=ch_예수,   bgm_url=bgm_snow,  bgm_transition='fade' WHERE id=57;
UPDATE scenes SET background=bg_무덤, character=ch_예수,   bgm_url=bgm_snow,  bgm_transition='fade' WHERE id=58;
UPDATE scenes SET background=bg_무덤, character=ch_예수,   bgm_url=bgm_throne,bgm_transition='fade' WHERE id=59;
UPDATE scenes SET background=bg_무덤, character=NULL,      bgm_url=bgm_snow,  bgm_transition='fade' WHERE id=60;

-- ════════════════════════════════
-- Ch10 최후의 만찬 (61~66)
-- ════════════════════════════════
UPDATE scenes SET background=bg_다락방, character=NULL,    bgm_url=bgm_snow, bgm_transition='fade' WHERE id=61;
UPDATE scenes SET background=bg_다락방, character=ch_예수, bgm_url=bgm_snow, bgm_transition='fade' WHERE id=62;
UPDATE scenes SET background=bg_다락방, character=ch_예수, bgm_url=bgm_snow, bgm_transition='fade' WHERE id=63;
UPDATE scenes SET background=bg_다락방, character=ch_유다, bgm_url=bgm_snow, bgm_transition='fade' WHERE id=64;
UPDATE scenes SET background=bg_다락방, character=ch_예수, bgm_url=bgm_snow, bgm_transition='fade' WHERE id=65;
UPDATE scenes SET background=bg_다락방, character=NULL,    bgm_url=bgm_snow, bgm_transition='fade' WHERE id=66;

-- ════════════════════════════════
-- Ch11 겟세마네 기도 (67~72)
-- ════════════════════════════════
UPDATE scenes SET background=bg_겟세마네, character=NULL,    bgm_url=bgm_snow, bgm_transition='fade' WHERE id=67;
UPDATE scenes SET background=bg_겟세마네, character=ch_예수, bgm_url=bgm_snow, bgm_transition='fade' WHERE id=68;
UPDATE scenes SET background=bg_겟세마네, character=ch_예수, bgm_url=bgm_snow, bgm_transition='fade' WHERE id=69;
UPDATE scenes SET background=bg_겟세마네, character=ch_예수, bgm_url=bgm_snow, bgm_transition='fade' WHERE id=70;
UPDATE scenes SET background=bg_겟세마네, character=NULL,    bgm_url=bgm_snow, bgm_transition='fade' WHERE id=71;
UPDATE scenes SET background=bg_겟세마네, character=ch_예수, bgm_url=bgm_snow, bgm_transition='fade' WHERE id=72;

END $$;
