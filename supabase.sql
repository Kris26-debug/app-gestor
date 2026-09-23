-- Mise en Place · estrutura do banco no Supabase
-- Cole tudo no Supabase em: SQL Editor > New query > Run

create table if not exists public.mp_docs (
  col        text        not null,   -- tipo de registro (produtos, compras, fichas...)
  id         text        not null,   -- identificador do registro
  data       jsonb       not null,   -- conteúdo do registro
  updated_at timestamptz not null default now(),
  primary key (col, id)
);

alter table public.mp_docs enable row level security;

drop policy if exists "mise en place - acesso do app" on public.mp_docs;
create policy "mise en place - acesso do app"
  on public.mp_docs for all
  to anon, authenticated
  using (true) with check (true);

-- Atualização em tempo real entre computadores e celulares
alter table public.mp_docs replica identity full;
do $$ begin
  alter publication supabase_realtime add table public.mp_docs;
exception when duplicate_object then null; end $$;
