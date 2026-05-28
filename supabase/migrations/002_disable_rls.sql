-- Disable RLS for story tables to allow admin data entry
ALTER TABLE public.chapters DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.scenes DISABLE ROW LEVEL SECURITY;
ALTER TABLE public.choices DISABLE ROW LEVEL SECURITY;
