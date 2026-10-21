-- Island Catan Online: Supabase schema
-- Run this in Supabase Dashboard > SQL Editor.
-- Prototype policies: anyone with the anon key can read/write rooms.
-- Do not use for a public competitive game without server-side authorization/validation.

create table if not exists public.catan_rooms (
  code text primary key check (code ~ '^[A-Z0-9]{6}$'),
  host_id text not null,
  state jsonb not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.catan_rooms enable row level security;

drop policy if exists "prototype read rooms" on public.catan_rooms;
create policy "prototype read rooms"
on public.catan_rooms for select to anon, authenticated
using (true);

drop policy if exists "prototype create rooms" on public.catan_rooms;
create policy "prototype create rooms"
on public.catan_rooms for insert to anon, authenticated
with check (true);

drop policy if exists "prototype update rooms" on public.catan_rooms;
create policy "prototype update rooms"
on public.catan_rooms for update to anon, authenticated
using (true) with check (true);

-- Enable realtime updates for the room table.
do $$
begin
  alter publication supabase_realtime add table public.catan_rooms;
exception when duplicate_object then null;
when undefined_object then null;
end $$;

create index if not exists catan_rooms_updated_at_idx
on public.catan_rooms (updated_at desc);
