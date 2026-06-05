/**
 * EndingBridge.jsx — 챕터 완료 브리지 화면
 *
 * 스토리 마지막 씬과 챕터 완료(트로피) 화면 사이에 표시되는 감상 화면.
 * 급작스러운 전환을 방지하고, 말씀과 여운이 마음에 머무는 시간을 만든다.
 *
 * 표시 내용:
 *  1. 마지막 씬의 배경 이미지 유지 (연속감)
 *  2. 엔딩 유형 이름 + 아이콘 (선택한 길의 이름)
 *  3. 해당 엔딩에 꼭 맞는 성경 구절 (시나리오 분석 기반, 챕터·엔딩별 고유)
 *  4. "마음에 새기고 계속하기" 버튼 (2초 후 등장)
 *
 * 엔딩 유형 구조:
 *  [0] 챕터별 고유 결단 (말씀·반석·나눔·믿음·이웃·귀환·부활·기억·순종·따름 등)
 *  [1] 따름의 길 — 그분을 더 알고 싶어 뒤따라가는 선택
 *  [2] 씨앗의 길 — 일상으로 돌아가지만 말씀이 가슴에 남는 선택
 *
 * Props:
 *  chapter: number         — 챕터 번호 (1~11)
 *  endingScene: object     — 완료 시점의 씬 객체 (background 이미지 포함)
 *  endingIndex: number     — 0·1·2 중 하나 (선택한 엔딩 순서)
 *  onContinue()            — "계속하기" 버튼 클릭 콜백
 *  audioRef                — 스토리 BGM Audio 객체 ref (페이드아웃용)
 *  volume: number          — 현재 볼륨
 */
import { useEffect, useRef, useState } from 'react'
import { motion } from 'framer-motion'

// ────────────────────────────────────────────────────────────────
// 챕터·엔딩별 정의 (시나리오 분석 기반)
//
// 각 챕터의 스토리 흐름과 선택 맥락에 맞는 엔딩 이름과 성경 구절을 배치.
// [0]: 그 챕터 고유의 결단 (행동·변화), [1]: 따름의 길, [2]: 씨앗의 길
// ────────────────────────────────────────────────────────────────
const ENDING_TYPES = {

  // CH1 갈릴리의 부름 — 베드로의 어린 조수가 부르심을 목격
  // [0] 그들처럼 모든 것을 두고 즉시 따라감
  // [1] 떠나지 못하고 버려진 그물 곁에 남아 기다림
  // [2] 부르심을 마음에 새기고 일상으로 돌아감
  1: [
    {
      name: '따름의 길', icon: '👣',
      sub: '모든 것을 두고 그분을 따라',
      verseRef: '마태복음 4:20',
      verse: '그들이 곧 그물을 버려 두고 예수를 따르니라',
    },
    {
      name: '남음의 길', icon: '⚓',
      sub: '버려진 그물 곁에 홀로 남아',
      verseRef: '이사야 40:31',
      verse: '오직 여호와를 앙망하는 자는 새 힘을 얻으리니 독수리가 날개 치며 올라감 같을 것이요',
    },
    {
      name: '씨앗의 길', icon: '🌱',
      sub: '부르심을 가슴에 품고 돌아와',
      verseRef: '마태복음 4:19',
      verse: '나를 따라오라 내가 너희를 사람을 낚는 어부가 되게 하리라',
    },
  ],

  // CH2 광야의 시험 — 광야의 어린 목동이 세 가지 시험을 지켜봄
  // [0] 나의 광야에서도 말씀으로 시험을 이기리라는 결단
  // [1] 양 떼를 두고 그분 뒤를 멀찍이 따라나섬
  // [2] 오늘 본 것을 가슴에 새기고 양 떼에게로 돌아감
  2: [
    {
      name: '말씀의 길', icon: '📖',
      sub: '말씀 한 절을 붙들고 살리라',
      verseRef: '마태복음 4:4',
      verse: '사람이 떡으로만 살 것이 아니요 하나님의 입으로 나오는 모든 말씀으로 살 것이라',
    },
    {
      name: '따름의 길', icon: '👣',
      sub: '그분의 뒤를 멀찍이 따라가',
      verseRef: '요한복음 10:27',
      verse: '내 양은 내 음성을 들으며 나는 그들을 알며 그들은 나를 따르느니라',
    },
    {
      name: '씨앗의 길', icon: '🌱',
      sub: '오늘 본 것을 가슴에 새겨 두고',
      verseRef: '시편 119:105',
      verse: '주의 말씀은 내 발에 등이요 내 길에 빛이니이다',
    },
  ],

  // CH3 산상수훈 — 군중 속 한 사람이 마음의 짐을 안고 올라가 말씀을 들음
  // [0] 반석 위에 집 짓듯 한 가지라도 행하며 살리라
  // [1] '아버지'를 더 알고 싶어 그분의 뒤를 따라감
  // [2] 다 행할 자신은 없지만 말씀을 가슴에 새기고 돌아감
  3: [
    {
      name: '반석의 길', icon: '🪨',
      sub: '한 가지라도 행하며 살리라',
      verseRef: '마태복음 7:24',
      verse: '누구든지 나의 이 말을 듣고 행하는 자는 그 집을 반석 위에 지은 지혜로운 사람 같으리니',
    },
    {
      name: '따름의 길', icon: '👣',
      sub: '아버지를 더 알고 싶어 따라가',
      verseRef: '요한복음 14:9',
      verse: '나를 본 자는 아버지를 보았거늘 어찌하여 아버지를 보이라 하느냐',
    },
    {
      name: '씨앗의 길', icon: '🌱',
      sub: '말씀을 가슴 깊이 새겨 품고',
      verseRef: '야고보서 1:22',
      verse: '너희는 말씀을 행하는 자가 되고 듣기만 하여 자신을 속이는 자가 되지 말라',
    },
  ],

  // CH4 풍랑을 잠재우심 — 배에 탄 어린 일꾼이 광풍을 함께 겪음
  // [0] 내 인생의 풍랑에서도 '잠잠하라'는 말씀을 믿으리라
  // [1] 이분이 누구신지 끝까지 이 배에 남아 알아보리라
  // [2] 잠잠해지던 그 밤을 평생 가슴에 새기며 살아감
  4: [
    {
      name: '믿음의 길', icon: '🌊',
      sub: '풍랑 속에도 그분을 믿으리라',
      verseRef: '이사야 43:2',
      verse: '네가 물 가운데로 지날 때에 내가 함께 할 것이라 강을 건널 때에 물이 너를 침몰하지 못할 것이며',
    },
    {
      name: '따름의 길', icon: '👣',
      sub: '그분이 누구신지 끝까지 지켜봐',
      verseRef: '마가복음 4:41',
      verse: '그가 누구이기에 바람과 바다도 순종하는고',
    },
    {
      name: '씨앗의 길', icon: '🌱',
      sub: '잠잠해진 그 밤을 평생 새기며',
      verseRef: '마가복음 4:39',
      verse: '잠잠하라 고요하라 하시니 바람이 그치고 아주 잔잔하여지더라',
    },
  ],

  // CH5 오병이어의 기적 — 도시락을 가진 소년이 자신의 것을 내어줌
  // [0] 내 작은 것도 그분께 드리면 기적이 됨을 알고 나누며 살리라
  // [1] 이런 분을 더 알고 싶어 그분을 따라가 보리라
  // [2] 보리떡 다섯 개의 기적을 평생 가슴에 새기며 살아감
  5: [
    {
      name: '나눔의 길', icon: '🫳',
      sub: '작은 것을 기꺼이 그분께 드리며',
      verseRef: '고린도후서 9:7',
      verse: '하나님은 즐겨 내는 자를 사랑하시느니라',
    },
    {
      name: '따름의 길', icon: '👣',
      sub: '저분을 더 알고 싶어 따라가',
      verseRef: '요한복음 6:35',
      verse: '나는 생명의 떡이니 내게 오는 자는 결코 주리지 아니할 터이요 나를 믿는 자는 영원히 목마르지 아니하리라',
    },
    {
      name: '씨앗의 길', icon: '🌱',
      sub: '오병이어의 저녁을 평생 새기며',
      verseRef: '요한복음 6:11',
      verse: '예수께서 떡을 가져 축사하신 후에 앉아 있는 자들에게 나눠 주시니라',
    },
  ],

  // CH6 물 위를 걸으심 — 배에서 지켜보는 일꾼이 베드로가 빠지고 건짐받는 것을 목격
  // [0] 두려울 때마다 '나니 두려워 말라' 하시는 음성을 기억하며 살리라
  // [1] 하나님의 아들을 확인하고 그분의 배에 남아 따르리라
  // [2] 물 위를 걷던 새벽을 평생 가슴에 새기며 살아감
  6: [
    {
      name: '믿음의 길', icon: '🌊',
      sub: '두려울 때마다 그 손길을 믿으리',
      verseRef: '마태복음 14:27',
      verse: '안심하라 나니 두려워하지 말라',
    },
    {
      name: '따름의 길', icon: '👣',
      sub: '그분의 배에 계속 남아 따라가',
      verseRef: '마태복음 14:33',
      verse: '배에 있는 사람들이 예수께 절하며 이르되 진실로 하나님의 아들이로소이다',
    },
    {
      name: '씨앗의 길', icon: '🌱',
      sub: '물 위를 걷던 새벽을 품고 살아',
      verseRef: '마태복음 14:31',
      verse: '예수께서 즉시 손을 내밀어 그를 붙잡으시며 이르시되 믿음이 작은 자여 왜 의심하였느냐',
    },
  ],

  // CH7 선한 사마리아인 — 여리고 길의 나그네가 비유 속으로 들어가 목격
  // [0] 셈하기 전에 먼저 멈추고 이웃이 되어 주는 사람으로 살리라
  // [1] 자비를 가르치신 그분을 더 알고 싶어 따라가리라
  // [2] '가서 너도 이와 같이 하라'를 평생 가슴에 새기며 살아감
  7: [
    {
      name: '이웃의 길', icon: '🤝',
      sub: '먼저 멈추고 손 내미는 사람으로',
      verseRef: '누가복음 10:37',
      verse: '가서 너도 이와 같이 하라',
    },
    {
      name: '따름의 길', icon: '👣',
      sub: '자비를 가르치신 그분을 따라가',
      verseRef: '마태복음 22:39',
      verse: '둘째도 그와 같으니 네 이웃을 네 자신 같이 사랑하라',
    },
    {
      name: '씨앗의 길', icon: '🌱',
      sub: '그 비유를 가슴에 새기고 살아',
      verseRef: '갈라디아서 6:2',
      verse: '너희가 짐을 서로 지라 그리하여 그리스도의 법을 성취하라',
    },
  ],

  // CH8 탕자의 귀환 — 아버지 집의 종이 매일 기다리는 아버지를 곁에서 지켜봄
  // [0] 길을 잃어도 조건 없이 달려오실 아버지께 망설임 없이 돌아가리라
  // [1] 이런 아버지의 마음을 가르치신 분을 더 알고 싶어 따라가리라
  // [2] 버선발로 달려가던 그 사랑을 평생 가슴에 새기며 살아감
  8: [
    {
      name: '귀환의 길', icon: '🏠',
      sub: '길을 잃어도 그 품으로 돌아가리',
      verseRef: '누가복음 15:20',
      verse: '아버지가 그를 보고 측은히 여겨 달려가 목을 안고 입을 맞추니',
    },
    {
      name: '따름의 길', icon: '👣',
      sub: '아버지의 마음을 가르치신 분 따라',
      verseRef: '로마서 5:8',
      verse: '우리가 아직 죄인 되었을 때에 그리스도께서 우리를 위하여 죽으심으로 하나님께서 우리에 대한 자기의 사랑을 확증하셨느니라',
    },
    {
      name: '씨앗의 길', icon: '🌱',
      sub: '조건 없는 그 사랑을 품고 살아',
      verseRef: '요한일서 4:10',
      verse: '사랑은 여기 있으니 우리가 하나님을 사랑한 것이 아니요 하나님이 우리를 사랑하사 우리 죄를 속하기 위하여 화목 제물로 그 아들을 보내셨음이라',
    },
  ],

  // CH9 나사로를 살리심 — 베다니 마을의 벗이 나사로의 죽음·부활을 목격
  // [0] 내 삶의 무덤 앞에서도 부르시는 그분의 음성을 믿으리라
  // [1] 죽음까지 이기신 분이 누구신지 끝까지 따르며 알아가리라
  // [2] 함께 우시던 그 눈물과 부활을 평생 가슴에 새기며 살아감
  9: [
    {
      name: '부활의 길', icon: '✨',
      sub: '무덤 앞에서도 그 음성을 믿으리',
      verseRef: '요한복음 11:25',
      verse: '나는 부활이요 생명이니 나를 믿는 자는 죽어도 살겠고',
    },
    {
      name: '따름의 길', icon: '👣',
      sub: '죽음을 이기신 그분을 끝까지 따라',
      verseRef: '요한복음 11:26',
      verse: '무릇 살아서 나를 믿는 자는 영원히 죽지 아니하리니 이것을 네가 믿느냐',
    },
    {
      name: '씨앗의 길', icon: '🌱',
      sub: '함께 우신 그 눈물을 가슴에 새겨',
      verseRef: '요한복음 11:35',
      verse: '예수께서 눈물을 흘리시더라',
    },
  ],

  // CH10 최후의 만찬 — 다락방을 준비한 사람이 세족·성찬·배신 예고를 지켜봄
  // [0] 떡을 떼고 잔을 들 때마다 이 밤을 기억하며 살리라
  // [1] 어떤 밤이 와도 이분을 끝까지 따르리라
  // [2] 발 씻기던 그 낮은 사랑을 평생 가슴에 새기며 살아감
  10: [
    {
      name: '기억의 길', icon: '💛',
      sub: '떡을 뗄 때마다 이 밤을 기억하며',
      verseRef: '누가복음 22:19',
      verse: '이것은 너희를 위하여 주는 내 몸이라 너희가 이를 행하여 나를 기념하라',
    },
    {
      name: '따름의 길', icon: '👣',
      sub: '어떤 밤이 와도 이분을 끝까지 따라',
      verseRef: '요한복음 13:34',
      verse: '새 계명을 너희에게 주노니 서로 사랑하라 내가 너희를 사랑한 것 같이 너희도 서로 사랑하라',
    },
    {
      name: '씨앗의 길', icon: '🌱',
      sub: '발 씻기던 그 사랑을 품고 살아',
      verseRef: '요한복음 13:15',
      verse: '내가 너희에게 행한 것 같이 너희도 행하게 하려 하여 본을 보였노라',
    },
  ],

  // CH11 겟세마네 기도 — 동산의 불침번 경비가 피땀의 기도를 목격
  // [0] 내게도 피하고픈 잔이 올 때 '아버지의 원대로'를 기도하리라
  // [1] 이렇게까지 하시는 그분을 그 끝까지 따르리라
  // [2] 핏방울 같은 땀과 그 기도를 평생 가슴에 새기며 살아감
  11: [
    {
      name: '순종의 길', icon: '🙏',
      sub: '쓴 잔 앞에서도 아버지의 뜻으로',
      verseRef: '마태복음 26:39',
      verse: '그러나 나의 원대로 마시옵고 아버지의 원대로 하옵소서',
    },
    {
      name: '따름의 길', icon: '👣',
      sub: '이렇게까지 하시는 그분을 따라가',
      verseRef: '빌립보서 2:8',
      verse: '사람의 모양으로 나타나사 자기를 낮추시고 죽기까지 복종하셨으니 곧 십자가에 죽으심이라',
    },
    {
      name: '씨앗의 길', icon: '🌱',
      sub: '그 밤의 기도를 가슴에 새기며',
      verseRef: '히브리서 5:8',
      verse: '그가 아들이시면서도 받으신 고난으로 순종함을 배워서',
    },
  ],
}

export default function EndingBridge({ chapter, endingScene, endingIndex, onContinue, audioRef, volume = 0.7 }) {
  const [visible, setVisible] = useState(false)
  const [btnVisible, setBtnVisible] = useState(false)
  const fadeTimerRef = useRef(null)

  // 마운트 직후 콘텐츠 페이드인 + 버튼은 2초 후 등장 (구절 읽을 시간 확보)
  useEffect(() => {
    const t1 = setTimeout(() => setVisible(true), 100)
    const t2 = setTimeout(() => setBtnVisible(true), 2000)
    return () => { clearTimeout(t1); clearTimeout(t2) }
  }, [])

  // 언마운트 시 타이머 정리
  useEffect(() => {
    return () => { if (fadeTimerRef.current) clearInterval(fadeTimerRef.current) }
  }, [])

  /**
   * "계속하기" 클릭: 스토리 BGM을 1.5초에 걸쳐 페이드아웃 후 완료 화면 전환.
   * 이미 정지된 경우 바로 전환.
   */
  const handleContinue = () => {
    const audio = audioRef?.current
    if (!audio || audio.paused) { onContinue(); return }
    const step = Math.max(0.02, audio.volume / (1500 / 50))
    fadeTimerRef.current = setInterval(() => {
      if (audio.volume > step) {
        audio.volume = Math.max(0, audio.volume - step)
      } else {
        audio.volume = 0
        audio.pause()
        clearInterval(fadeTimerRef.current)
        onContinue()
      }
    }, 50)
  }

  // 챕터·엔딩 인덱스로 해당 엔딩 정보 조회 (정의 없으면 1챕터 fallback)
  const chapterEndings = ENDING_TYPES[chapter] ?? ENDING_TYPES[1]
  const ending = chapterEndings[Math.min(Math.max(endingIndex, 0), 2)]

  return (
    <div className="size-full relative overflow-hidden bg-gradient-to-br from-[#0d1f3c] via-[#1a2d5a] to-[#2a1845]">

      {/* ── 배경 이미지: 마지막 씬 배경 유지 (연속감) ── */}
      {endingScene?.background && (
        <motion.div
          initial={{ opacity: 0 }}
          animate={{ opacity: 1 }}
          transition={{ duration: 1.5 }}
          className="absolute inset-0"
        >
          <div
            className="size-full bg-cover bg-center"
            style={{
              backgroundImage: `url(${endingScene.background})`,
              filter: 'brightness(0.25)', // 스토리보다 어둡게 — 감상적 분위기
            }}
          />
        </motion.div>
      )}

      {/* 하단으로 갈수록 어두워지는 그라디언트 오버레이 */}
      <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/30 to-black/10" />

      {/* ── 메인 콘텐츠 ── */}
      <div className="relative z-10 size-full flex flex-col items-center justify-center px-6 py-12">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: visible ? 1 : 0, y: visible ? 0 : 20 }}
          transition={{ duration: 1.2 }}
          className="w-full max-w-lg text-center space-y-8"
        >
          {/* 챕터 배지 */}
          <motion.div
            initial={{ opacity: 0 }}
            animate={{ opacity: visible ? 0.7 : 0 }}
            transition={{ duration: 0.8, delay: 0.1 }}
            className="inline-flex items-center gap-2 px-4 py-1.5 bg-white/10 backdrop-blur-sm rounded-full border border-white/20"
          >
            <span className="text-white/60 text-sm tracking-wide">챕터 {chapter}</span>
          </motion.div>

          {/* ── 엔딩 유형: 아이콘 + 이름 + 부제 ── */}
          <div className="space-y-2">
            <motion.div
              initial={{ opacity: 0, scale: 0.7 }}
              animate={{ opacity: visible ? 1 : 0, scale: visible ? 1 : 0.7 }}
              transition={{ duration: 0.8, delay: 0.3, type: 'spring', stiffness: 200 }}
              className="text-5xl"
            >
              {ending.icon}
            </motion.div>

            <motion.h2
              initial={{ opacity: 0, y: 8 }}
              animate={{ opacity: visible ? 1 : 0, y: visible ? 0 : 8 }}
              transition={{ duration: 0.8, delay: 0.5 }}
              className="text-3xl md:text-4xl font-bold text-transparent bg-clip-text bg-gradient-to-r from-amber-300 via-yellow-200 to-amber-400"
            >
              {ending.name}
            </motion.h2>

            <motion.p
              initial={{ opacity: 0 }}
              animate={{ opacity: visible ? 1 : 0 }}
              transition={{ duration: 0.8, delay: 0.7 }}
              className="text-white/50 text-sm tracking-wide"
            >
              {ending.sub}
            </motion.p>
          </div>

          {/* 구분선 */}
          <motion.div
            initial={{ scaleX: 0 }}
            animate={{ scaleX: visible ? 1 : 0 }}
            transition={{ duration: 0.8, delay: 0.9 }}
            className="w-24 h-px bg-gradient-to-r from-transparent via-amber-400/50 to-transparent mx-auto"
          />

          {/* ── 성경 구절 ── */}
          <motion.div
            initial={{ opacity: 0, y: 8 }}
            animate={{ opacity: visible ? 1 : 0, y: visible ? 0 : 8 }}
            transition={{ duration: 0.8, delay: 1.1 }}
            className="space-y-3 px-4"
          >
            <p className="text-amber-400/70 text-xs tracking-widest">
              📖 {ending.verseRef}
            </p>
            <p className="text-white/90 text-lg md:text-xl leading-relaxed">
              "{ending.verse}"
            </p>
          </motion.div>

          {/* ── 계속하기 버튼 (2초 후 등장) ── */}
          <motion.div
            initial={{ opacity: 0, y: 8 }}
            animate={{ opacity: btnVisible ? 1 : 0, y: btnVisible ? 0 : 8 }}
            transition={{ duration: 0.6 }}
          >
            <button
              onClick={handleContinue}
              className="mt-4 px-8 py-3 bg-white/10 hover:bg-amber-400/20 backdrop-blur-sm border border-white/20 hover:border-amber-400/50 rounded-full text-white/80 hover:text-amber-200 text-sm tracking-wider transition-all duration-300"
            >
              마음에 새기고 계속하기 →
            </button>
          </motion.div>
        </motion.div>
      </div>
    </div>
  )
}
