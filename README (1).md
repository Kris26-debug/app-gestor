# Mise en Place

Sistema de gestão do restaurante: estoque, contagens (estoque geral, soft e adega), fichas técnicas, cozinha de produção com calculadora de rendimento, planilha de compras, cotações, envio de pedidos pelo WhatsApp, compras × faturamento, faturamento por setor com CMC em tempo real e inventários. Tem login com senha para Adm e para a equipe, e importação e exportação em PDF e Excel.

É um site estático: um `index.html` e um `config.js`. Não tem instalação nem servidor próprio.

## Arquivos

| Arquivo | Para que serve |
|---|---|
| `index.html` | O sistema inteiro |
| `config.js` | Onde você cola os dados do Supabase (banco na nuvem) |
| `supabase.sql` | Cria a tabela no Supabase (roda uma vez só) |

## Passo 1: publicar no GitHub Pages

1. Crie um repositório no GitHub (ex.: `mise-en-place`).
2. Envie estes arquivos: **Add file → Upload files**, arraste tudo e clique em **Commit changes**.
3. Vá em **Settings → Pages**. Em *Source*, escolha **Deploy from a branch**, depois a branch **main** e a pasta **/(root)**. Clique em **Save**.
4. Em 1 ou 2 minutos o endereço aparece no topo da página, no formato `https://SEU-USUARIO.github.io/mise-en-place/`.

Sem o passo 2, o sistema já funciona em **modo local**: os dados ficam salvos só no navegador de quem usa. Serve para testar, mas não compartilha com a equipe.

## Passo 2: banco na nuvem com o Supabase (para a equipe toda)

1. Crie uma conta grátis em [supabase.com](https://supabase.com) e clique em **New project**.
2. No projeto, abra **SQL Editor → New query**, cole o conteúdo de `supabase.sql` e clique em **Run**.
3. Vá em **Project Settings → API** e copie:
   - **Project URL**
   - **anon public** (a chave pública)
4. No GitHub, abra `config.js`, clique no lápis (editar) e preencha:

```js
window.MP_CONFIG = {
  supabaseUrl: 'https://abcdefghijk.supabase.co',
  supabaseAnonKey: 'eyJhbGciOi...'
};
```

5. Clique em **Commit changes**. Em 1 minuto o site atualiza. A partir daí, todos os computadores e celulares veem os mesmos dados, atualizados em tempo real.

## Primeiro acesso

1. Abra o site. Ele vai pedir para criar a **senha do Adm** e a **senha da equipe**.
2. Entre como Adm e cadastre produtos, fichas e fornecedores, ou importe do seu outro aplicativo pelo botão **Importar**, disponível em Estoque, Fichas técnicas, Planilha de compras, Compras, Faturamento e Contagens.
3. Passe para a equipe o endereço do site e a senha da equipe.

As senhas podem ser trocadas em **Ajustes**.

## Segurança: leia antes de usar com dados reais

- As senhas são guardadas criptografadas (hash PBKDF2) e controlam o que cada pessoa vê na tela.
- Nesta versão, o banco do Supabase é acessado com a chave pública (`anon`). Quem tiver o endereço do site e souber mexer no navegador consegue, tecnicamente, ler os dados direto do banco, sem passar pela senha. Para uso interno de restaurante costuma bastar. Para proteger de verdade, o próximo passo é ativar o **Supabase Auth**, com login por e-mail, e restringir a tabela a usuários autenticados.
- Não publique o repositório com dados sensíveis dentro de arquivos. Os dados ficam no Supabase, não no GitHub.

## O que muda em relação à versão no Claude

- **Ler PDF com IA** na importação só existe na versão dentro do Claude. Aqui a importação de PDF usa a leitura automática de colunas, e Excel e CSV funcionam normalmente.
- Quem pode ser Adm é definido pela senha, não pela conta Claude.

## Atualizar o sistema

Para trocar a versão, substitua o `index.html` no repositório e faça o commit. Os dados continuam no Supabase.
