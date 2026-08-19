-- Life Scrapbook cloud sync setup (Supabase)
-- Run this once in Supabase: SQL Editor -> New query -> paste -> Run.

create table if not exists public.scrapbook_entries (
  user_id uuid not null references auth.users(id) on delete cascade,
  entry_id text not null,
  payload jsonb not null,
  updated_at timestamptz not null default now(),
  primary key (user_id, entry_id)
);

create table if not exists public.scrapbook_deletions (
  user_id uuid not null references auth.users(id) on delete cascade,
  entry_id text not null,
  deleted_at timestamptz not null default now(),
  primary key (user_id, entry_id)
);

create table if not exists public.scrapbook_settings (
  user_id uuid not null references auth.users(id) on delete cascade,
  key text not null,
  value jsonb,
  updated_at timestamptz not null default now(),
  primary key (user_id, key)
);

alter table public.scrapbook_entries enable row level security;
alter table public.scrapbook_deletions enable row level security;
alter table public.scrapbook_settings enable row level security;

drop policy if exists "Users manage own scrapbook entries" on public.scrapbook_entries;
create policy "Users manage own scrapbook entries" on public.scrapbook_entries
for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "Users manage own scrapbook deletions" on public.scrapbook_deletions;
create policy "Users manage own scrapbook deletions" on public.scrapbook_deletions
for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "Users manage own scrapbook settings" on public.scrapbook_settings;
create policy "Users manage own scrapbook settings" on public.scrapbook_settings
for all to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);

insert into storage.buckets (id, name, public)
values ('scrapbook-media', 'scrapbook-media', false)
on conflict (id) do update set public = false;

drop policy if exists "Users read own scrapbook media" on storage.objects;
create policy "Users read own scrapbook media" on storage.objects
for select to authenticated
using (bucket_id = 'scrapbook-media' and (storage.foldername(name))[1] = auth.uid()::text);

drop policy if exists "Users upload own scrapbook media" on storage.objects;
create policy "Users upload own scrapbook media" on storage.objects
for insert to authenticated
with check (bucket_id = 'scrapbook-media' and (storage.foldername(name))[1] = auth.uid()::text);

drop policy if exists "Users update own scrapbook media" on storage.objects;
create policy "Users update own scrapbook media" on storage.objects
for update to authenticated
using (bucket_id = 'scrapbook-media' and (storage.foldername(name))[1] = auth.uid()::text)
with check (bucket_id = 'scrapbook-media' and (storage.foldername(name))[1] = auth.uid()::text);

drop policy if exists "Users delete own scrapbook media" on storage.objects;
create policy "Users delete own scrapbook media" on storage.objects
for delete to authenticated
using (bucket_id = 'scrapbook-media' and (storage.foldername(name))[1] = auth.uid()::text);
