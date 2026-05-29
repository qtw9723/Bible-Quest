-- Chapters 2~11 시나리오 데이터
DO $$
DECLARE
  -- 챕터 ID 변수
  ch2 INT; ch3 INT; ch4 INT; ch5 INT; ch6 INT;
  ch7 INT; ch8 INT; ch9 INT; ch10 INT; ch11 INT;
  -- 장면 ID 변수 (각 챕터별 s1~s6)
  s1 INT; s2 INT; s3 INT; s4 INT; s5 INT; s6 INT;
BEGIN

-- ══════════════════════════════════════════
-- CHAPTER 2: 광야의 시험
-- ══════════════════════════════════════════
INSERT INTO chapters (chapter_num, title, description)
  VALUES (2, '광야의 시험', '광야에서 40일 금식 후 사탄의 시험을 받으신 예수님')
  RETURNING id INTO ch2;

INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch2, 1, '세례를 받으신 직후, 성령이 예수님을 광야로 이끄셨습니다.' || chr(10) || chr(10) || '당신은 광야 끝자락에서 양 떼를 돌보는 목동입니다. 저 멀리, 홀로 앉아 기도하는 한 사람의 모습이 눈에 들어옵니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s1;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch2, 2, '40일이 지났습니다. 그분은 아무것도 드시지 않아 극도로 쇠약해 보였습니다.' || chr(10) || chr(10) || '그때, 어디선가 속삭이는 목소리가 들렸습니다.' || chr(10) || '"네가 하나님의 아들이거든 이 돌들에게 명하여 떡이 되게 하라."', NULL, NULL, NULL, 'fade') RETURNING id INTO s2;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch2, 3, '예수님은 흔들리지 않고 대답하셨습니다.' || chr(10) || chr(10) || '"기록되었으되 사람이 떡으로만 살 것이 아니요, 하나님의 입으로 나오는 모든 말씀으로 살 것이라 하였느니라."' || chr(10) || chr(10) || '목소리는 다시 시험했습니다. 성전 꼭대기에서 뛰어내리라고, 세상 모든 나라를 주겠다고.', NULL, NULL, NULL, 'fade') RETURNING id INTO s3;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch2, 4, '당신은 이 장면을 목격하며 생각합니다. 시험이란 무엇일까요?', NULL, NULL, NULL, 'fade') RETURNING id INTO s4;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch2, 5, '예수님은 "주 너의 하나님을 시험하지 말라"고 하시며 모든 시험을 물리치셨습니다.' || chr(10) || chr(10) || '그러자 사탄은 물러갔고, 천사들이 나아와 그분을 섬겼습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s5;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch2, 6, '당신도 살면서 시험을 받습니다. 배고픔, 욕망, 권력의 유혹.' || chr(10) || chr(10) || '그러나 오늘 광야에서 보았습니다. 말씀 앞에서 시험은 힘을 잃는다는 것을.' || chr(10) || chr(10) || '📖 마태복음 4:4' || chr(10) || '"사람이 떡으로만 살 것이 아니요, 하나님의 입으로 나오는 모든 말씀으로 살 것이라"', NULL, NULL, NULL, 'fade') RETURNING id INTO s6;

INSERT INTO choices (scene_id, label, next_scene_id, choice_order) VALUES
  (s1, '계속 →', s2, 1), (s2, '계속 →', s3, 1), (s3, '계속 →', s4, 1),
  (s4, '나도 같은 시험을 받은 적이 있다', s5, 1),
  (s4, '저분은 왜 혼자 이 고난을 감당하실까', s5, 2),
  (s5, '계속 →', s6, 1), (s6, '챕터 완료', NULL, 1);

-- ══════════════════════════════════════════
-- CHAPTER 3: 산상수훈
-- ══════════════════════════════════════════
INSERT INTO chapters (chapter_num, title, description)
  VALUES (3, '산상수훈', '산 위에서 선포하신 하나님 나라의 가르침')
  RETURNING id INTO ch3;

INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch3, 1, '갈릴리 산 기슭에 수많은 사람들이 몰려들었습니다.' || chr(10) || chr(10) || '당신은 그중 하나로, 먼 길을 걸어 이 자리에 왔습니다. 병든 가족 때문에, 혹은 희망을 찾아서.', NULL, NULL, NULL, 'fade') RETURNING id INTO s1;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch3, 2, '예수님이 산 위에 앉으시자 제자들이 나아왔고, 그분이 입을 열어 가르치시기 시작했습니다.' || chr(10) || chr(10) || '"심령이 가난한 자는 복이 있나니 천국이 그들의 것임이요."' || chr(10) || '"애통하는 자는 복이 있나니 그들이 위로를 받을 것임이요."', NULL, NULL, NULL, 'fade') RETURNING id INTO s2;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch3, 3, '말씀은 계속 이어졌습니다.' || chr(10) || chr(10) || '"원수를 사랑하며 너희를 박해하는 자를 위하여 기도하라."' || chr(10) || chr(10) || '군중 사이에서 웅성거리는 소리가 들렸습니다. 너무 어렵다고, 불가능하다고.', NULL, NULL, NULL, 'fade') RETURNING id INTO s3;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch3, 4, '당신의 마음은 어떻습니까?', NULL, NULL, NULL, 'fade') RETURNING id INTO s4;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch3, 5, '말씀을 들으며 당신의 마음이 조용히 움직였습니다.' || chr(10) || chr(10) || '"너희는 세상의 빛이라. 산 위에 있는 동네가 숨겨지지 못할 것이요."' || chr(10) || chr(10) || '이 가르침은 율법을 폐하러 온 것이 아니라, 완성하러 오신 것이었습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s5;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch3, 6, '해가 기울어도 사람들은 자리를 뜨지 않았습니다. 이렇게 가르치는 자를 본 적이 없었기 때문입니다.' || chr(10) || chr(10) || '📖 마태복음 5:14' || chr(10) || '"너희는 세상의 빛이라. 산 위에 있는 동네가 숨겨지지 못할 것이요"', NULL, NULL, NULL, 'fade') RETURNING id INTO s6;

INSERT INTO choices (scene_id, label, next_scene_id, choice_order) VALUES
  (s1, '계속 →', s2, 1), (s2, '계속 →', s3, 1), (s3, '계속 →', s4, 1),
  (s4, '이 말씀이 내 삶을 바꿀 수 있을까 생각한다', s5, 1),
  (s4, '너무 높은 기준이라 부담스럽다', s5, 2),
  (s5, '계속 →', s6, 1), (s6, '챕터 완료', NULL, 1);

-- ══════════════════════════════════════════
-- CHAPTER 4: 풍랑을 잠재우심
-- ══════════════════════════════════════════
INSERT INTO chapters (chapter_num, title, description)
  VALUES (4, '풍랑을 잠재우심', '거센 폭풍 속에서 "잠잠하라"고 명하신 예수님')
  RETURNING id INTO ch4;

INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch4, 1, '해가 지자 예수님이 말씀하셨습니다. "우리가 저편으로 건너가자."' || chr(10) || chr(10) || '당신은 어부 출신 제자 중 하나로, 노를 잡고 배에 올랐습니다. 잔잔해 보이는 갈릴리 호수였습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s1;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch4, 2, '예수님은 배 고물에서 베개를 베고 주무셨습니다. 그런데 갑자기 큰 광풍이 일어났습니다.' || chr(10) || chr(10) || '물결이 배 안으로 들이쳐 배가 거의 잠길 지경이 되었습니다. 당신의 손이 부들부들 떨렸습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s2;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch4, 3, '제자들이 예수님을 깨우며 외쳤습니다. "선생님이여, 우리가 죽게 된 것을 돌아보지 아니하시나이까?"' || chr(10) || chr(10) || '당신도 그 절박함 속에 있었습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s3;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch4, 4, '당신은 어떻게 하겠습니까?', NULL, NULL, NULL, 'fade') RETURNING id INTO s4;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch4, 5, '예수님이 깨어나 바람을 꾸짖으시고 바다에 말씀하셨습니다.' || chr(10) || '"잠잠하라, 고요하라."' || chr(10) || chr(10) || '그러자 바람이 그치고 아주 잔잔해졌습니다. 순식간의 일이었습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s5;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch4, 6, '"어찌하여 이렇게 무서워하느냐? 너희가 어찌 믿음이 없느냐?"' || chr(10) || chr(10) || '제자들은 심히 두려워하며 서로 말했습니다. "그가 누구이기에 바람과 바다도 순종하는가?"' || chr(10) || chr(10) || '📖 마가복음 4:39' || chr(10) || '"잠잠하라, 고요하라. 이에 바람이 그치고 아주 잔잔하여지더라"', NULL, NULL, NULL, 'fade') RETURNING id INTO s6;

INSERT INTO choices (scene_id, label, next_scene_id, choice_order) VALUES
  (s1, '계속 →', s2, 1), (s2, '계속 →', s3, 1), (s3, '계속 →', s4, 1),
  (s4, '예수님을 흔들어 깨운다', s5, 1),
  (s4, '스스로 버텨보려 노를 더 힘차게 젓는다', s5, 2),
  (s5, '계속 →', s6, 1), (s6, '챕터 완료', NULL, 1);

-- ══════════════════════════════════════════
-- CHAPTER 5: 오병이어
-- ══════════════════════════════════════════
INSERT INTO chapters (chapter_num, title, description)
  VALUES (5, '오병이어의 기적', '떡 다섯 개와 물고기 두 마리로 오천 명을 먹이신 기적')
  RETURNING id INTO ch5;

INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch5, 1, '어느 날 저물어 갈 때, 벳새다 들판에 오천 명이 넘는 사람들이 모여 있었습니다.' || chr(10) || chr(10) || '당신은 어머니와 함께 온 열두 살 소년입니다. 아침부터 아무것도 먹지 못했고 배가 많이 고팠습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s1;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch5, 2, '제자들이 예수님께 나아와 말했습니다. "여기는 빈 들이요 때도 이미 저물었으니 무리를 보내어 먹을 것을 사 먹게 하소서."' || chr(10) || chr(10) || '예수님이 물으셨습니다. "너희에게 떡이 몇 개나 있느냐?"', NULL, NULL, NULL, 'fade') RETURNING id INTO s2;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch5, 3, '안드레가 말했습니다. "여기 한 아이가 있어 보리떡 다섯 개와 물고기 두 마리를 가졌나이다. 그러나 그것이 이 많은 사람에게 얼마나 되겠삽나이까?"' || chr(10) || chr(10) || '그 아이가 바로 당신이었습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s3;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch5, 4, '예수님이 당신을 바라보셨습니다. 당신은 어떻게 하겠습니까?', NULL, NULL, NULL, 'fade') RETURNING id INTO s4;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch5, 5, '예수님은 떡을 들어 하늘을 향해 감사 기도를 드리신 후 나눠 주셨습니다.' || chr(10) || chr(10) || '놀랍게도 오천 명이 넘는 사람들이 모두 배불리 먹었고, 남은 조각을 모으니 열두 바구니가 가득 찼습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s5;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch5, 6, '당신의 작은 도시락이 수천 명을 먹였습니다.' || chr(10) || chr(10) || '아무것도 아닌 것처럼 보였던 것이, 예수님의 손에 건네졌을 때 기적이 되었습니다.' || chr(10) || chr(10) || '📖 요한복음 6:11' || chr(10) || '"예수께서 떡을 가져 축사하신 후에 앉아 있는 자들에게 나눠 주시고"', NULL, NULL, NULL, 'fade') RETURNING id INTO s6;

INSERT INTO choices (scene_id, label, next_scene_id, choice_order) VALUES
  (s1, '계속 →', s2, 1), (s2, '계속 →', s3, 1), (s3, '계속 →', s4, 1),
  (s4, '망설이다가 도시락을 내민다', s5, 1),
  (s4, '너무 적어서 부끄럽지만 드린다', s5, 2),
  (s5, '계속 →', s6, 1), (s6, '챕터 완료', NULL, 1);

-- ══════════════════════════════════════════
-- CHAPTER 6: 물 위를 걸으심
-- ══════════════════════════════════════════
INSERT INTO chapters (chapter_num, title, description)
  VALUES (6, '물 위를 걸으심', '바다 위를 걸어오신 예수님과 베드로의 믿음')
  RETURNING id INTO ch6;

INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch6, 1, '오병이어 기적 직후, 예수님은 제자들을 배에 먼저 태우시고 홀로 산에 올라 기도하셨습니다.' || chr(10) || chr(10) || '당신은 배 안에서 노를 저으며 예수님을 기다리고 있었습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s1;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch6, 2, '밤 사경쯤 되었을 때였습니다. 파도가 거세지고 바람이 맞바람이 되어 배가 나아가지 못했습니다.' || chr(10) || chr(10) || '그때 누군가가 바다 위를 걸어서 다가오는 것이 보였습니다. 제자들은 유령이라고 외치며 두려워했습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s2;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch6, 3, '"안심하라, 나니 두려워하지 말라."' || chr(10) || chr(10) || '예수님의 목소리였습니다. 베드로가 말했습니다. "주여, 만일 주시어든 나를 명하사 물 위로 오라 하소서."', NULL, NULL, NULL, 'fade') RETURNING id INTO s3;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch6, 4, '"오라." 단 한 마디였습니다. 당신이 베드로라면 어떻게 하겠습니까?', NULL, NULL, NULL, 'fade') RETURNING id INTO s4;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch6, 5, '베드로는 배에서 내려 물 위를 걸어 예수님께로 나아갔습니다.' || chr(10) || chr(10) || '그러나 바람이 보이자 무서워 빠지기 시작하며 외쳤습니다. "주여, 나를 구원하소서!"' || chr(10) || chr(10) || '예수님이 즉시 손을 내밀어 잡으셨습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s5;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch6, 6, '"믿음이 작은 자여, 왜 의심하였느냐?"' || chr(10) || chr(10) || '배에 오르자 바람이 그쳤습니다. 제자들이 절하며 말했습니다. "진실로 하나님의 아들이로소이다."' || chr(10) || chr(10) || '📖 마태복음 14:31' || chr(10) || '"믿음이 작은 자여, 왜 의심하였느냐"', NULL, NULL, NULL, 'fade') RETURNING id INTO s6;

INSERT INTO choices (scene_id, label, next_scene_id, choice_order) VALUES
  (s1, '계속 →', s2, 1), (s2, '계속 →', s3, 1), (s3, '계속 →', s4, 1),
  (s4, '두렵지만 배에서 내려 걷는다', s5, 1),
  (s4, '너무 무서워 배 안에서 지켜본다', s5, 2),
  (s5, '계속 →', s6, 1), (s6, '챕터 완료', NULL, 1);

-- ══════════════════════════════════════════
-- CHAPTER 7: 선한 사마리아인
-- ══════════════════════════════════════════
INSERT INTO chapters (chapter_num, title, description)
  VALUES (7, '선한 사마리아인', '내 이웃이 누구인가에 대한 예수님의 비유')
  RETURNING id INTO ch7;

INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch7, 1, '한 율법사가 예수님을 시험하여 물었습니다. "내 이웃이 누구니이까?"' || chr(10) || chr(10) || '예수님이 비유로 대답하셨습니다. 당신은 그 자리에서 이 이야기를 듣고 있습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s1;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch7, 2, '"어떤 사람이 예루살렘에서 여리고로 내려가다가 강도를 만났습니다. 강도들이 그 옷을 벗기고 때려 거의 죽게 된 채로 길에 버려두었습니다."' || chr(10) || chr(10) || '당신은 그 길을 지나가는 행인입니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s2;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch7, 3, '제사장이 지나가다 그를 보고 피해 지나갔습니다. 레위인도 마찬가지였습니다.' || chr(10) || chr(10) || '그때 유대인에게 멸시받던 사마리아인이 다가왔습니다. 당신이 그 자리에 있다면?', NULL, NULL, NULL, 'fade') RETURNING id INTO s3;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch7, 4, '사마리아인은 그를 보고 불쌍히 여겨 상처를 싸매고, 자신의 나귀에 태워 주막으로 데려가 돌보았습니다.' || chr(10) || chr(10) || '다음 날 그는 돈을 내어 주인에게 맡기며 말했습니다. "비용이 더 들면 내가 돌아올 때 갚겠소."', NULL, NULL, NULL, 'fade') RETURNING id INTO s4;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch7, 5, '예수님이 물으셨습니다. "네 생각에는 이 세 사람 중에 누가 강도 만난 자의 이웃이 되겠느냐?"' || chr(10) || chr(10) || '율법사가 말했습니다. "자비를 베푼 자니이다."' || chr(10) || '"가서 너도 이와 같이 하라."', NULL, NULL, NULL, 'fade') RETURNING id INTO s5;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch7, 6, '이웃은 가까이 사는 사람이 아니었습니다.' || chr(10) || chr(10) || '이웃은 자비를 베푸는 사람이었습니다.' || chr(10) || chr(10) || '📖 누가복음 10:37' || chr(10) || '"가서 너도 이와 같이 하라"', NULL, NULL, NULL, 'fade') RETURNING id INTO s6;

INSERT INTO choices (scene_id, label, next_scene_id, choice_order) VALUES
  (s1, '계속 →', s2, 1), (s2, '계속 →', s3, 1),
  (s3, '멈추어 그를 돕는다', s4, 1),
  (s3, '위험할까봐 먼저 지나친다', s4, 2),
  (s4, '계속 →', s5, 1), (s5, '계속 →', s6, 1),
  (s6, '챕터 완료', NULL, 1);

-- ══════════════════════════════════════════
-- CHAPTER 8: 탕자의 귀환
-- ══════════════════════════════════════════
INSERT INTO chapters (chapter_num, title, description)
  VALUES (8, '탕자의 귀환', '아버지의 품으로 돌아온 아들에 관한 비유')
  RETURNING id INTO ch8;

INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch8, 1, '예수님이 죄인들을 영접하신다며 바리새인과 서기관들이 수군거렸습니다.' || chr(10) || chr(10) || '예수님이 비유를 말씀하셨습니다. 당신은 그 이야기 속으로 들어갑니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s1;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch8, 2, '"아버지, 재산 중 내게 돌아올 분깃을 지금 주소서."' || chr(10) || chr(10) || '작은아들은 유산을 받아 먼 나라로 떠났고, 거기서 허랑방탕하게 다 낭비했습니다.' || chr(10) || chr(10) || '당신은 그 작은아들입니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s2;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch8, 3, '돈이 다 떨어지자 극심한 흉년이 닥쳤습니다. 그는 돼지를 치는 신세가 되었고, 돼지가 먹는 쥐엄 열매라도 먹고 싶었지만 그것조차 주는 이가 없었습니다.' || chr(10) || chr(10) || '스스로에게 돌이켜 생각했습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s3;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch8, 4, '"내 아버지에게는 양식이 풍족한 품꾼이 얼마나 많은가. 나는 여기서 주려 죽는구나. 일어나 아버지께 가서 말하리라."' || chr(10) || chr(10) || '당신은 일어납니까?', NULL, NULL, NULL, 'fade') RETURNING id INTO s4;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch8, 5, '아직 거리가 먼데 아버지가 그를 보고 달려가 목을 안고 입을 맞추었습니다.' || chr(10) || chr(10) || '"아버지여 내가 하늘과 아버지께 죄를 지었사오니 지금부터는 아버지의 아들이라 불릴 자격이 없사오나…"' || chr(10) || chr(10) || '아버지는 종들에게 말했습니다. "제일 좋은 옷을 내어다가 입히라."', NULL, NULL, NULL, 'fade') RETURNING id INTO s5;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch8, 6, '"이 내 아들은 죽었다가 다시 살아났으며 내가 잃었다가 다시 얻었노라."' || chr(10) || chr(10) || '아버지는 이미 멀리서부터 달려왔습니다. 당신이 돌아오기를 기다리고 있었습니다.' || chr(10) || chr(10) || '📖 누가복음 15:20' || chr(10) || '"아버지가 그를 보고 측은히 여겨 달려가 목을 안고 입을 맞추니"', NULL, NULL, NULL, 'fade') RETURNING id INTO s6;

INSERT INTO choices (scene_id, label, next_scene_id, choice_order) VALUES
  (s1, '계속 →', s2, 1), (s2, '계속 →', s3, 1), (s3, '계속 →', s4, 1),
  (s4, '부끄럽지만 일어나 아버지께로 돌아간다', s5, 1),
  (s4, '너무 창피해서 차마 돌아가지 못한다', s5, 2),
  (s5, '계속 →', s6, 1), (s6, '챕터 완료', NULL, 1);

-- ══════════════════════════════════════════
-- CHAPTER 9: 나사로를 살리심
-- ══════════════════════════════════════════
INSERT INTO chapters (chapter_num, title, description)
  VALUES (9, '나사로를 살리심', '죽은 지 나흘 된 나사로를 살리신 예수님')
  RETURNING id INTO ch9;

INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch9, 1, '베다니에 사는 마리아와 마르다가 예수님께 전갈을 보냈습니다. "주여, 보시옵소서. 사랑하시는 자가 병들었나이다."' || chr(10) || chr(10) || '당신은 그 마을 사람으로, 나사로 가족과 오랜 친분이 있습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s1;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch9, 2, '나흘이 지났습니다. 나사로는 이미 무덤 안에 있었고, 온 마을은 슬픔에 잠겨 있었습니다.' || chr(10) || chr(10) || '마르다가 예수님께로 달려가 말했습니다. "주께서 여기 계셨더라면 내 오라버니가 죽지 아니하였겠나이다."', NULL, NULL, NULL, 'fade') RETURNING id INTO s2;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch9, 3, '"나는 부활이요 생명이니 나를 믿는 자는 죽어도 살겠고."' || chr(10) || chr(10) || '마리아도 울며 나아왔고, 함께 온 사람들도 울었습니다. 예수님도 눈물을 흘리셨습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s3;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch9, 4, '무덤 앞에 섰습니다. 돌을 옮기라 하시자 마르다가 말했습니다. "죽은 지 나흘이나 되어 냄새가 납니다."' || chr(10) || chr(10) || '예수님이 말씀하셨습니다. "내 말이 네가 믿으면 하나님의 영광을 보리라 하지 아니하였느냐?"', NULL, NULL, NULL, 'fade') RETURNING id INTO s4;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch9, 5, '예수님이 눈을 들어 기도하신 후 큰 소리로 부르셨습니다. "나사로야, 나오라!"' || chr(10) || chr(10) || '죽었던 자가 수족을 베로 동인 채로 나왔습니다. 무리 중에 탄성이 터졌습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s5;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch9, 6, '예수님도 우셨습니다. 전능한 분이 인간의 슬픔 앞에서 함께 눈물을 흘리셨습니다.' || chr(10) || chr(10) || '그분은 단지 기적을 행하신 것이 아니라, 우리의 아픔을 함께 지셨습니다.' || chr(10) || chr(10) || '📖 요한복음 11:35' || chr(10) || '"예수께서 눈물을 흘리시더라"', NULL, NULL, NULL, 'fade') RETURNING id INTO s6;

INSERT INTO choices (scene_id, label, next_scene_id, choice_order) VALUES
  (s1, '계속 →', s2, 1), (s2, '계속 →', s3, 1), (s3, '계속 →', s4, 1),
  (s4, '돌을 옮기는 것을 돕는다', s5, 1),
  (s4, '믿기 어려워 뒤에서 지켜본다', s5, 2),
  (s5, '계속 →', s6, 1), (s6, '챕터 완료', NULL, 1);

-- ══════════════════════════════════════════
-- CHAPTER 10: 최후의 만찬
-- ══════════════════════════════════════════
INSERT INTO chapters (chapter_num, title, description)
  VALUES (10, '최후의 만찬', '십자가 전날 밤, 제자들과 함께하신 마지막 식사')
  RETURNING id INTO ch10;

INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch10, 1, '유월절 첫날, 제자들이 예수님께 물었습니다. "유월절 음식을 어디서 잡수시려 하나이까?"' || chr(10) || chr(10) || '당신은 다락방을 준비한 사람입니다. 왠지 오늘 저녁이 특별할 것 같은 느낌이 들었습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s1;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch10, 2, '저녁이 되자 예수님이 열두 제자와 함께 앉으셨습니다.' || chr(10) || chr(10) || '"내가 고난을 받기 전에 너희와 함께 이 유월절 먹기를 원하고 원하였노라."' || chr(10) || chr(10) || '그 말씀에 무언가 무거운 것이 느껴졌습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s2;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch10, 3, '예수님이 떡을 들어 감사 기도를 드리시고 떼어 주시며 말씀하셨습니다.' || chr(10) || '"이것은 너희를 위하는 내 몸이라. 나를 기념하여 이것을 행하라."' || chr(10) || chr(10) || '잔을 드신 후에도 말씀하셨습니다. "이 잔은 내 피로 세우는 새 언약이니."', NULL, NULL, NULL, 'fade') RETURNING id INTO s3;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch10, 4, '그때 예수님이 말씀하셨습니다. "너희 중의 하나가 나를 팔리라."' || chr(10) || chr(10) || '제자들이 서로 보며 근심하여 물었습니다. "주여, 나는 아니지요?"' || chr(10) || chr(10) || '당신은 무슨 생각이 드십니까?', NULL, NULL, NULL, 'fade') RETURNING id INTO s4;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch10, 5, '식사를 마친 후 그들은 찬미하고 감람산으로 나갔습니다.' || chr(10) || chr(10) || '예수님이 말씀하셨습니다. "오늘 밤 너희가 다 나를 버리리라."' || chr(10) || chr(10) || '베드로가 강하게 말했습니다. "모두 버릴지라도 나는 아니하겠나이다."', NULL, NULL, NULL, 'fade') RETURNING id INTO s5;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch10, 6, '그 마지막 저녁, 예수님은 알고 계셨습니다. 배신, 부인, 도망.' || chr(10) || chr(10) || '그럼에도 함께 밥을 드셨습니다. 떡을 떼어 주셨습니다.' || chr(10) || chr(10) || '📖 누가복음 22:19' || chr(10) || '"나를 기념하여 이것을 행하라"', NULL, NULL, NULL, 'fade') RETURNING id INTO s6;

INSERT INTO choices (scene_id, label, next_scene_id, choice_order) VALUES
  (s1, '계속 →', s2, 1), (s2, '계속 →', s3, 1), (s3, '계속 →', s4, 1),
  (s4, '"나는 아닐 것이다"라고 확신한다', s5, 1),
  (s4, '"혹시 나도…?" 마음이 불편해진다', s5, 2),
  (s5, '계속 →', s6, 1), (s6, '챕터 완료', NULL, 1);

-- ══════════════════════════════════════════
-- CHAPTER 11: 겟세마네 기도
-- ══════════════════════════════════════════
INSERT INTO chapters (chapter_num, title, description)
  VALUES (11, '겟세마네 기도', '십자가를 앞두고 홀로 기도하신 예수님')
  RETURNING id INTO ch11;

INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch11, 1, '최후의 만찬 후, 예수님은 제자들과 함께 겟세마네라는 곳에 이르셨습니다.' || chr(10) || chr(10) || '당신은 그곳에서 불침번을 서던 경비원입니다. 깊은 밤, 올리브 나무 사이로 누군가 들어오는 것을 보았습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s1;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch11, 2, '예수님은 세 제자를 따로 데리고 가시며 말씀하셨습니다.' || chr(10) || '"내 마음이 심히 고민하여 죽게 되었으니 너희는 여기 머물러 나와 함께 깨어 있으라."' || chr(10) || chr(10) || '그분의 목소리가 떨리고 있었습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s2;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch11, 3, '예수님이 조금 더 나아가 얼굴을 땅에 대시고 기도하셨습니다.' || chr(10) || chr(10) || '"아버지여, 만일 할 만하시거든 이 잔을 내게서 지나가게 하옵소서. 그러나 나의 원대로 마시옵고 아버지의 원대로 하옵소서."', NULL, NULL, NULL, 'fade') RETURNING id INTO s3;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch11, 4, '제자들에게 돌아오시니 그들은 잠들어 있었습니다. 세 번을 기도하시고 세 번을 돌아오셨지만 그들은 계속 잠들어 있었습니다.' || chr(10) || chr(10) || '당신이 거기 있었다면 어땠을까요?', NULL, NULL, NULL, 'fade') RETURNING id INTO s4;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch11, 5, '세 번째 기도를 마치시고 예수님이 일어나셨습니다.' || chr(10) || '"때가 왔도다. 인자가 죄인들의 손에 넘겨지느니라. 일어나라, 가자."' || chr(10) || chr(10) || '결국 혼자 감당하기로 하셨습니다.', NULL, NULL, NULL, 'fade') RETURNING id INTO s5;
INSERT INTO scenes (chapter_id, scene_order, text, background, character, bgm_url, bgm_transition)
  VALUES (ch11, 6, '"내 원대로 마시옵고 아버지의 원대로."' || chr(10) || chr(10) || '이것이 기도였습니다. 두렵고 고통스러워도 하나님의 뜻을 선택하는 것.' || chr(10) || chr(10) || '📖 마태복음 26:39' || chr(10) || '"그러나 나의 원대로 마시옵고 아버지의 원대로 하옵소서"', NULL, NULL, NULL, 'fade') RETURNING id INTO s6;

INSERT INTO choices (scene_id, label, next_scene_id, choice_order) VALUES
  (s1, '계속 →', s2, 1), (s2, '계속 →', s3, 1), (s3, '계속 →', s4, 1),
  (s4, '잠들지 않고 곁을 지켰을 것 같다', s5, 1),
  (s4, '나도 피곤해서 잠들었을 것 같다', s5, 2),
  (s5, '계속 →', s6, 1), (s6, '챕터 완료', NULL, 1);

END $$;
