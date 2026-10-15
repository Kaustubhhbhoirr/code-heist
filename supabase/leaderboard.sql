-- Code Heist leaderboards.
-- Paste this into Supabase → SQL Editor → New query → Run. Safe to run more than once.

create table if not exists public.scores (
  user_id    uuid not null references auth.users (id) on delete cascade,
  level      text not null check (char_length(level) between 1 and 40),   -- job slug, or 'endless'
  name       text not null check (name ~ '^[A-Za-z0-9_ -]{2,16}$'),       -- thief name, never the email
  ticks      int  not null default 1 check (ticks between 1 and 5000),
  lines      int  not null default 1 check (lines between 1 and 500),
  streak     int  not null default 0 check (streak between 0 and 100000), -- endless only
  updated_at timestamptz not null default now(),
  primary key (user_id, level)
);

create index if not exists scores_job_rank     on public.scores (level, ticks, lines, updated_at);
create index if not exists scores_endless_rank on public.scores (level, streak desc, updated_at);

alter table public.scores enable row level security;

-- Boards are public to read; players can only write their own rows.
drop policy if exists "anyone reads scores" on public.scores;
drop policy if exists "insert own score"    on public.scores;
drop policy if exists "update own score"    on public.scores;

create policy "anyone reads scores" on public.scores for select using (true);
create policy "insert own score"    on public.scores for insert with check (auth.uid() = user_id);
create policy "update own score"    on public.scores for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
