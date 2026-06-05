/**
 * EndingBridge.jsx — 챕터 완료 브리지 화면
 *
 * 스토리 마지막 씬과 챕터 완료(트로피) 화면 사이에 표시되는 감상 화면.
 * 급작스러운 전환을 방지하고, 말씀과 여운이 마음에 머무는 시간을 만든다.
 *
 * 표시 내용:
 *  1. 마지막 씬의 배경 이미지 유지 (연속감)
 *  2. 엔딩 유형 이름 + 아이콘 (선택한 길의 이름)
 *  3. 성경 구절 (씬 텍스트에서 파싱: 📖 표시 이후 부분)
 *  4. "마음에 새기고 계속하기" 버튼
 *
 * 엔딩 유형 (endingIndex 0·1·2):
 *  [0] 챕터별 고유 이름 (행동·결단의 길: 말씀·반석·나눔·믿음 등)
 *  [1] 따름의 길 — 그분의 뒤를 따라가는 선택
 *  [2] 씨앗의 길 — 가슴에 새기고 일상으로 돌아가는 선택
 *
 * Props:
 *  chapter: number         — 챕터 번호 (엔딩 이름 결정에 사용)
 *  endingScene: object     — 완료 시점의 씬 객체 (background, text 포함)
 *  endingIndex: number     — 0·1·2 중 하나 (선택한 엔딩 순서)
 *  onContinue()            — "계속하기" 버튼 클릭 콜백 (완료 화면으로 이동)
 *  audioRef                — 스토리 BGM Audio 객체 ref (페이드아웃용)
 *  volume: number          — 현재 볼륨
 */
import { useEffect, useRef, useState } from 'react'
import { motion } from 'framer-motion'

// ── 챕터·엔딩별 이름 및 아이콘 정의 ──
// [0]: 각 챕터 고유 결단, [1]: 따름의 길, [2]: 씨앗의 길
const ENDING_TYPES = {
  1:  [
    { name: '따름의 길',  icon: '👣', sub: '모든 것을 두고 그분을 따라' },
    { name: '남음의 길',  icon: '⚓', sub: '버려진 그물 곁에 홀로 남아' },
    { name: '씨앗의 길',  icon: '🌱', sub: '부르심을 가슴에 품고 돌아와' },
  ],
  2:  [
    { name: '말씀의 길',  icon: '📖', sub: '말씀 한 절을 붙들고 살리라' },
    { name: '따름의 길',  icon: '👣', sub: '그분의 뒤를 멀찍이 따라가' },
    { name: '씨앗의 길',  icon: '🌱', sub: '오늘 본 것을 가슴에 새겨 두고' },
  ],
  3:  [
    { name: '반석의 길',  icon: '🪨', sub: '한 가지라도 행하며 살리라' },
    { name: '따름의 길',  icon: '👣', sub: '아버지를 더 알고 싶어 따라가' },
    { name: '씨앗의 길',  icon: '🌱', sub: '말씀을 가슴 깊이 새겨 품고' },
  ],
  4:  [
    { name: '믿음의 길',  icon: '🌊', sub: '풍랑 속에도 그분을 믿으리라' },
    { name: '따름의 길',  icon: '👣', sub: '그분이 누구신지 끝까지 지켜봐' },
    { name: '씨앗의 길',  icon: '🌱', sub: '잠잠해진 그 밤을 평생 새기며' },
  ],
  5:  [
    { name: '나눔의 길',  icon: '🫳', sub: '작은 것을 기꺼이 그분께 드리며' },
    { name: '따름의 길',  icon: '👣', sub: '저분을 더 알고 싶어 따라가' },
    { name: '씨앗의 길',  icon: '🌱', sub: '오병이어의 저녁을 평생 새기며' },
  ],
  6:  [
    { name: '믿음의 길',  icon: '🌊', sub: '두려울 때마다 그 손길을 믿으리' },
    { name: '따름의 길',  icon: '👣', sub: '그분의 배에 계속 남아 따라가' },
    { name: '씨앗의 길',  icon: '🌱', sub: '물 위를 걷던 새벽을 품고 살아' },
  ],
  7:  [
    { name: '이웃의 길',  icon: '🤝', sub: '먼저 멈추고 손 내미는 사람으로' },
    { name: '따름의 길',  icon: '👣', sub: '자비를 가르치신 그분을 따라가' },
    { name: '씨앗의 길',  icon: '🌱', sub: '그 비유를 가슴에 새기고 살아' },
  ],
  8:  [
    { name: '귀환의 길',  icon: '🏠', sub: '길을 잃어도 그 품으로 돌아가리' },
    { name: '따름의 길',  icon: '👣', sub: '아버지의 마음을 가르치신 분 따라' },
    { name: '씨앗의 길',  icon: '🌱', sub: '조건 없는 그 사랑을 품고 살아' },
  ],
  9:  [
    { name: '부활의 길',  icon: '✨', sub: '무덤 앞에서도 그 음성을 믿으리' },
    { name: '따름의 길',  icon: '👣', sub: '죽음을 이기신 그분을 끝까지 따라' },
    { name: '씨앗의 길',  icon: '🌱', sub: '함께 우신 그 눈물을 가슴에 새겨' },
  ],
  10: [
    { name: '기억의 길',  icon: '💛', sub: '떡을 뗄 때마다 이 밤을 기억하며' },
    { name: '따름의 길',  icon: '👣', sub: '어떤 밤에도 이분을 끝까지 따라' },
    { name: '씨앗의 길',  icon: '🌱', sub: '발 씻기던 그 사랑을 품고 살아' },
  ],
  11: [
    { name: '순종의 길',  icon: '🙏', sub: '쓴 잔 앞에서도 아버지의 뜻으로' },
    { name: '따름의 길',  icon: '👣', sub: '이렇게까지 하시는 그분을 따라가' },
    { name: '씨앗의 길',  icon: '🌱', sub: '그 밤의 기도를 가슴에 새기며' },
  ],
}

/**
 * 씬 텍스트에서 성경 구절을 파싱한다.
 * 텍스트 끝부분 형식: "📖 마태복음 4:19\n\"나를 따라오라...\""
 *
 * @param {string} text — 씬 텍스트
 * @returns {{ ref: string, quote: string }}
 */
function parseVerse(text) {
  if (!text) return { ref: '', quote: '' }
  // 📖 다음 줄: 성경 참조 | 그 다음 줄 따옴표 안: 구절 본문
  const match = text.match(/📖\s*([^\n]+)\n"([^"]+)"/)
  if (!match) return { ref: '', quote: '' }
  return { ref: match[1].trim(), quote: match[2].trim() }
}

export default function EndingBridge({ chapter, endingScene, endingIndex, onContinue, audioRef, volume = 0.7 }) {
  const [visible, setVisible] = useState(false)   // 콘텐츠 페이드인 트리거
  const [btnVisible, setBtnVisible] = useState(false) // 버튼 지연 등장
  const fadeTimerRef = useRef(null)

  // 마운트 직후 콘텐츠 페이드인 시작
  useEffect(() => {
    const t1 = setTimeout(() => setVisible(true), 100)
    const t2 = setTimeout(() => setBtnVisible(true), 2000) // 버튼은 2초 후 등장
    return () => { clearTimeout(t1); clearTimeout(t2) }
  }, [])

  // 컴포넌트 언마운트 시 페이드 타이머 정리
  useEffect(() => {
    return () => { if (fadeTimerRef.current) clearInterval(fadeTimerRef.current) }
  }, [])

  /**
   * "계속하기" 클릭: 스토리 BGM을 페이드아웃하고 완료 화면으로 이동.
   * audioRef.current가 없으면 (이미 정지됐으면) 바로 이동.
   */
  const handleContinue = () => {
    const audio = audioRef?.current
    if (!audio || audio.paused) {
      onContinue()
      return
    }
    // BGM 페이드아웃 후 완료 화면 전환
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

  // 엔딩 유형 정보 (챕터별 · 인덱스별)
  const chapterEndings = ENDING_TYPES[chapter] || ENDING_TYPES[1]
  const ending = chapterEndings[Math.min(endingIndex, 2)] || chapterEndings[2]

  // 성경 구절 파싱
  const verse = parseVerse(endingScene?.text || '')

  return (
    <div className="size-full relative overflow-hidden bg-gradient-to-br from-[#0d1f3c] via-[#1a2d5a] to-[#2a1845]">

      {/* ── 배경 이미지 (마지막 씬 배경 유지 — 연속감) ── */}
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
              filter: 'brightness(0.3)', // 스토리 화면보다 더 어둡게 — 감상적 분위기
            }}
          />
        </motion.div>
      )}

      {/* 그라디언트 오버레이 — 하단으로 갈수록 어두워짐 */}
      <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/30 to-black/10" />

      {/* ── 메인 콘텐츠 (중앙 정렬) ── */}
      <div className="relative z-10 size-full flex flex-col items-center justify-center px-6 py-12">
        <motion.div
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: visible ? 1 : 0, y: visible ? 0 : 20 }}
          transition={{ duration: 1.2 }}
          className="w-full max-w-lg text-center space-y-8"
        >
          {/* 챕터 배지 */}
          <div className="inline-flex items-center gap-2 px-4 py-1.5 bg-white/10 backdrop-blur-sm rounded-full border border-white/20">
            <span className="text-white/60 text-sm">챕터 {chapter}</span>
          </div>

          {/* ── 엔딩 유형 ── */}
          <div className="space-y-2">
            <motion.div
              initial={{ opacity: 0, scale: 0.8 }}
              animate={{ opacity: visible ? 1 : 0, scale: visible ? 1 : 0.8 }}
              transition={{ duration: 0.8, delay: 0.3 }}
              className="text-5xl mb-2"
            >
              {ending.icon}
            </motion.div>
            <motion.h2
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: visible ? 1 : 0, y: visible ? 0 : 10 }}
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
          {verse.ref && (
            <motion.div
              initial={{ opacity: 0, y: 10 }}
              animate={{ opacity: visible ? 1 : 0, y: visible ? 0 : 10 }}
              transition={{ duration: 0.8, delay: 1.1 }}
              className="space-y-3 px-4"
            >
              <p className="text-amber-400/70 text-sm tracking-widest uppercase">
                📖 {verse.ref}
              </p>
              <p className="text-white/90 text-lg md:text-xl leading-relaxed italic">
                "{verse.quote}"
              </p>
            </motion.div>
          )}

          {/* ── 계속하기 버튼 ── */}
          <motion.div
            initial={{ opacity: 0, y: 10 }}
            animate={{ opacity: btnVisible ? 1 : 0, y: btnVisible ? 0 : 10 }}
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
