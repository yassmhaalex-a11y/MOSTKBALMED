-- Run this in the SQL Editor of a NEW Supabase project, not Flash Store.
create extension if not exists pgcrypto;
create table if not exists public.med_admins (user_id uuid primary key references auth.users(id) on delete cascade);
create table if not exists public.med_categories (id uuid primary key default gen_random_uuid(), name text not null, icon text not null default '✚', description text not null default '');
create table if not exists public.med_products (id uuid primary key default gen_random_uuid(), name text not null, category uuid not null references public.med_categories(id) on delete restrict, image text not null default '', description text not null default '', features text[] not null default '{}', active boolean not null default true, created_at timestamptz not null default now());
alter table public.med_admins enable row level security;
alter table public.med_categories enable row level security;
alter table public.med_products enable row level security;
create policy "admins can read own membership" on public.med_admins for select to authenticated using (user_id = (select auth.uid()));
create policy "anyone can view categories" on public.med_categories for select to anon, authenticated using (true);
create policy "anyone can view active products" on public.med_products for select to anon, authenticated using (active or exists(select 1 from public.med_admins a where a.user_id = (select auth.uid())));
create policy "admins insert categories" on public.med_categories for insert to authenticated with check (exists(select 1 from public.med_admins a where a.user_id = (select auth.uid())));
create policy "admins update categories" on public.med_categories for update to authenticated using (exists(select 1 from public.med_admins a where a.user_id = (select auth.uid()))) with check (exists(select 1 from public.med_admins a where a.user_id = (select auth.uid())));
create policy "admins delete categories" on public.med_categories for delete to authenticated using (exists(select 1 from public.med_admins a where a.user_id = (select auth.uid())));
create policy "admins insert products" on public.med_products for insert to authenticated with check (exists(select 1 from public.med_admins a where a.user_id = (select auth.uid())));
create policy "admins update products" on public.med_products for update to authenticated using (exists(select 1 from public.med_admins a where a.user_id = (select auth.uid()))) with check (exists(select 1 from public.med_admins a where a.user_id = (select auth.uid())));
create policy "admins delete products" on public.med_products for delete to authenticated using (exists(select 1 from public.med_admins a where a.user_id = (select auth.uid())));
insert into storage.buckets(id,name,public,file_size_limit,allowed_mime_types) values ('med-images','med-images',true,5242880,array['image/jpeg','image/png','image/webp']) on conflict(id) do nothing;
create policy "public can view medical images" on storage.objects for select to anon, authenticated using (bucket_id='med-images');
create policy "admins can upload medical images" on storage.objects for insert to authenticated with check (bucket_id='med-images' and exists(select 1 from public.med_admins a where a.user_id = (select auth.uid())));
-- AFTER creating your admin user in Supabase Authentication > Users, run:
-- insert into public.med_admins(user_id) values ('PASTE-YOUR-AUTH-USER-UUID-HERE');
