-- Storage RLS 정책: bible-quest 버킷 업로드/조회/삭제 허용
-- anon 및 authenticated 역할 모두 허용 (어드민 패널에서 업로드 가능하도록)

DROP POLICY IF EXISTS "allow_all_uploads" ON storage.objects;
DROP POLICY IF EXISTS "allow_all_reads" ON storage.objects;
DROP POLICY IF EXISTS "allow_all_deletes" ON storage.objects;
DROP POLICY IF EXISTS "allow_all_updates" ON storage.objects;

CREATE POLICY "allow_all_uploads" ON storage.objects
  FOR INSERT TO anon, authenticated
  WITH CHECK (bucket_id = 'bible-quest');

CREATE POLICY "allow_all_reads" ON storage.objects
  FOR SELECT TO anon, authenticated
  USING (bucket_id = 'bible-quest');

CREATE POLICY "allow_all_deletes" ON storage.objects
  FOR DELETE TO anon, authenticated
  USING (bucket_id = 'bible-quest');

CREATE POLICY "allow_all_updates" ON storage.objects
  FOR UPDATE TO anon, authenticated
  USING (bucket_id = 'bible-quest');
