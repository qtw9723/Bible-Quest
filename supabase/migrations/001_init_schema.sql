-- Chapters table
CREATE TABLE chapters (
  id BIGSERIAL PRIMARY KEY,
  chapter_num INT UNIQUE NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Scenes table
CREATE TABLE scenes (
  id BIGSERIAL PRIMARY KEY,
  chapter_id BIGINT REFERENCES chapters(id) ON DELETE CASCADE,
  scene_order INT NOT NULL,
  background TEXT,
  character TEXT,
  text TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Choices table
CREATE TABLE choices (
  id BIGSERIAL PRIMARY KEY,
  scene_id BIGINT REFERENCES scenes(id) ON DELETE CASCADE,
  choice_order INT NOT NULL,
  label TEXT NOT NULL,
  next_scene_id BIGINT REFERENCES scenes(id) ON DELETE SET NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Players table
CREATE TABLE players (
  id BIGSERIAL PRIMARY KEY,
  nickname TEXT NOT NULL UNIQUE,
  completed_chapters INT[] DEFAULT '{}',
  last_chapter INT,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

-- Player Progress table
CREATE TABLE player_progress (
  id BIGSERIAL PRIMARY KEY,
  player_id BIGINT REFERENCES players(id) ON DELETE CASCADE,
  chapter_id BIGINT REFERENCES chapters(id) ON DELETE CASCADE,
  completed BOOLEAN DEFAULT FALSE,
  completed_at TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  UNIQUE(player_id, chapter_id)
);

-- Enable RLS
ALTER TABLE chapters ENABLE ROW LEVEL SECURITY;
ALTER TABLE scenes ENABLE ROW LEVEL SECURITY;
ALTER TABLE choices ENABLE ROW LEVEL SECURITY;
ALTER TABLE players ENABLE ROW LEVEL SECURITY;
ALTER TABLE player_progress ENABLE ROW LEVEL SECURITY;

-- Policies (allow public read for chapters/scenes/choices, authenticated for players)
CREATE POLICY "Allow public read on chapters" ON chapters
  FOR SELECT USING (true);

CREATE POLICY "Allow public read on scenes" ON scenes
  FOR SELECT USING (true);

CREATE POLICY "Allow public read on choices" ON choices
  FOR SELECT USING (true);

CREATE POLICY "Allow public insert on players" ON players
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Allow players to read own progress" ON player_progress
  FOR SELECT USING (true);

CREATE POLICY "Allow players to insert own progress" ON player_progress
  FOR INSERT WITH CHECK (true);

CREATE POLICY "Allow players to update own progress" ON player_progress
  FOR UPDATE USING (true);
