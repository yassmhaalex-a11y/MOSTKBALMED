-- Run once in Supabase SQL Editor. PDF files are public so visitors can open them.
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES ('med-pdfs', 'med-pdfs', true, 20971520, ARRAY['application/pdf'])
ON CONFLICT (id) DO UPDATE SET public=true, file_size_limit=20971520, allowed_mime_types=ARRAY['application/pdf'];

DROP POLICY IF EXISTS "med_pdfs_public_read_v27" ON storage.objects;
CREATE POLICY "med_pdfs_public_read_v27" ON storage.objects FOR SELECT TO public USING (bucket_id='med-pdfs');

DROP POLICY IF EXISTS "med_pdfs_authenticated_upload_v27" ON storage.objects;
CREATE POLICY "med_pdfs_authenticated_upload_v27" ON storage.objects FOR INSERT TO authenticated WITH CHECK (bucket_id='med-pdfs');
