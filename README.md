# Mise en Place

Sistema de gestão do restaurante: estoque, contagens (estoque geral, soft e adega), fichas técnicas, cozinha de produção com calculadora de rendimento, planilha de compras, cotações, envio de pedidos pelo WhatsApp, compras × faturamento, faturamento por setor com CMC em tempo real e inventários. Tem login com senha para Adm e equipe, e importação e exportação em PDF e Excel.

É um site estático e fica hospedado de graça no **GitHub Pages**. Sempre que você enviar uma alteração, o próprio GitHub publica o site de novo.

## Estrutura do repositório

```
├── index.html                  → o sistema completo
├── config.js                   → dados do Supabase (banco na nuvem)
├── supabase.sql                → cria a tabela no Supabase (roda uma vez)
├── favicon.svg                 → ícone do site
├── manifest.webmanifest        → permite "instalar" no celular
├── .nojekyll                   → faz o GitHub servir os arquivos como estão
├── .github/workflows/deploy.yml→ publica o site automaticamente
└── modelos-importacao/         → planilhas modelo para importar dados
```

---

## 1. Colocar no GitHub

### Opção A: pelo site do GitHub (sem instalar nada)

1. Entre em [github.com/new](https://github.com/new) e crie o repositório `mise-en-place`. Não marque nenhuma opção de README.
2. Na página do repositório vazio, clique em **uploading an existing file**.
3. Descompacte o .zip no computador, abra a pasta, selecione **todos os arquivos e pastas de dentro dela** e arraste para a página.
   > No Windows e no Mac, a pasta `.github` pode ficar oculta. Ative "mostrar arquivos ocultos" (no Mac: `Cmd + Shift + .`) para ela ir junto. Se esquecer, tudo bem: use o passo 2 da seção seguinte, **opção "Deploy from a branch"**.
4. Clique em **Commit changes**.

### Opção B: pelo terminal (Git)

O .zip já traz um repositório Git com tudo commitado. Descompacte, entre na pasta e rode:

```bash
git remote add origin https://github.com/SEU-USUARIO/mise-en-place.git
git branch -M main
git push -u origin main
```

## 2. Ligar o GitHub Pages

1. No repositório, vá em **Settings → Pages**.
2. Em **Source**, escolha **GitHub Actions**. O arquivo `deploy.yml` faz a publicação.
   - Se a pasta `.github` não foi enviada, escolha **Deploy from a branch**, depois a branch **main** e a pasta **/(root)**, e clique em **Save**.
3. Aguarde 1 ou 2 minutos. O progresso aparece na aba **Actions**. O endereço do site fica em **Settings → Pages**:
   `https://SEU-USUARIO.github.io/mise-en-place/`

Nesse ponto o sistema já funciona em **modo local**: cada navegador guarda os próprios dados. Para a equipe toda ver as mesmas informações, faça o passo 3.

## 3. Banco na nuvem (Supabase): para compartilhar com a equipe

1. Crie uma conta grátis em [supabase.com](https://supabase.com) e clique em **New project**.
2. Abra **SQL Editor → New query**, cole o conteúdo de `supabase.sql` e clique em **Run**.
3. Em **Project Settings → API**, copie a **Project URL** e a chave **anon public**.
4. No GitHub, abra o arquivo `config.js`, clique no lápis ✏️ e preencha:

```js
window.MP_CONFIG = {
  supabaseUrl: 'https://abcdefghijk.supabase.co',
  supabaseAnonKey: 'eyJhbGciOi...'
};
```

5. Clique em **Commit changes**. O site é publicado de novo sozinho, em cerca de 1 minuto. A partir daí, todos os computadores e celulares veem os mesmos dados, em tempo real.

## 4. Primeiro acesso

1. Abra o site. Ele pede para criar a **senha do Adm** e a **senha da equipe**.
2. Entre como Adm e cadastre produtos, fichas e fornecedores. Também dá para usar o botão **Importar**, disponível em Estoque, Fichas técnicas, Planilha de compras, Compras, Faturamento e Contagens. As planilhas de `modelos-importacao/` mostram as colunas que o sistema reconhece.
3. Passe para a equipe o endereço do site e a senha da equipe.
4. **No celular:** abra o site e escolha "Adicionar à tela inicial". Ele passa a abrir como um aplicativo.

As senhas podem ser trocadas em **Ajustes**. Em Ajustes também dá para baixar um **backup** completo em JSON.

## Atualizar o sistema

Substitua o `index.html` no repositório (no site: abra o arquivo → ✏️ ou **Add file → Upload files**) e faça o commit. O site é publicado de novo automaticamente, e os dados continuam no Supabase.

## Segurança

- As senhas são guardadas com hash (PBKDF2) e controlam o que cada pessoa vê.
- O banco é acessado com a chave pública do Supabase (`anon`). Quem tiver o endereço do site e conhecimento técnico consegue ler os dados direto do banco, sem passar pela senha. Para uso interno isso costuma bastar. Para proteger de verdade, ative o **Supabase Auth** (login por e-mail) e restrinja a tabela a usuários autenticados.
- Os dados ficam no Supabase, nunca no GitHub. Mesmo com o repositório público, o GitHub guarda só o código.

## Diferenças da versão no Claude

- **Ler PDF com IA** na importação só existe dentro do Claude. Aqui funcionam Excel, CSV e a leitura normal de PDF.
- Quem é Adm é definido pela senha, não pela conta Claude.
