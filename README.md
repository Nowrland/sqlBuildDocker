# PostgreSQL local com Docker

Ambiente local de PostgreSQL 17 para desenvolvimento. O Docker Compose inicia o banco com SSL habilitado e persiste os dados em um volume Docker. O repositório também inclui um dump SQL (`backup_completo.sql`) e um script para gerar certificados autoassinados.

## Requisitos

- Docker Desktop com Docker Compose v2
- OpenSSL para gerar os certificados, disponível no `PATH` ou pelo Git for Windows
- Node.js 18+ somente se você for usar o driver `pg` no seu projeto

## Arquivos principais

| Arquivo | Finalidade |
| --- | --- |
| `docker-compose.yml` | Define o serviço PostgreSQL 17, SSL, porta e volume de dados |
| `.env` | Configura usuário, senha, banco e porta do host; não compartilhe nem versione |
| `generate-ssl.cmd` | Gera `ssl/server.crt` e `ssl/server.key` no Windows |
| `backup_completo.sql` | Dump SQL com estrutura e dados do banco |
| `package.json` | Dependências Node (`pg`, `dotenv` e `nodemon`) e atalhos npm |

## Configuração e inicialização

1. Confira se o `.env` contém `POSTGRES_USER`, `POSTGRES_PASSWORD` e `POSTGRES_DB`. `POSTGRES_PORT` é opcional e, quando omitida, a porta publicada no host é `5432`.
2. No Windows, gere os certificados uma vez:

   ```cmd
   generate-ssl.cmd
   ```

   O Compose espera os arquivos `ssl/server.crt` e `ssl/server.key`. O certificado é autoassinado e destinado a desenvolvimento local.
3. Inicie o banco:

   ```sh
   docker compose up -d
   docker compose ps
   docker compose logs -f postgres
   ```

O diretório `ssl/` pode estar vazio antes da geração dos certificados. A chave e o certificado estão ignorados pelo Git.

## Restaurar o dump

O banco criado pelo Compose começa vazio. Para carregar a estrutura e os dados do dump em um banco vazio, execute na raiz do projeto:

```sh
docker compose exec -T postgres psql -U Arcanautadb -d arcaappteste < backup_completo.sql
```

No PowerShell, rode a mesma linha pelo `cmd.exe` para usar o redirecionamento do arquivo:

```powershell
cmd.exe /d /c "docker compose exec -T postgres psql -U Arcanautadb -d arcaappteste < backup_completo.sql"
```

O dump define objetos pertencentes a `Arcanautadb`; portanto, esse usuário precisa existir e ter permissão para criar os objetos. Se os valores de `POSTGRES_USER` ou `POSTGRES_DB` no `.env` forem diferentes, substitua `Arcanautadb` e `arcaappteste` pelos valores configurados. Restaure em um banco vazio para evitar conflitos com objetos já existentes.

## Conectar ao banco

Com os valores padrão usados pelo projeto:

| Campo | Valor |
| --- | --- |
| Host | `localhost` |
| Porta | valor de `POSTGRES_PORT` ou `5432` |
| Banco | valor de `POSTGRES_DB` (atualmente `arcaappteste`) |
| Usuário | valor de `POSTGRES_USER` (atualmente `Arcanautadb`) |
| SSL | habilitado; certificado autoassinado |

Com `psql` instalado localmente, use a senha configurada no `.env` quando solicitada:

```sh
psql "host=localhost port=5432 dbname=arcaappteste user=Arcanautadb sslmode=require"
```

Ou abra o `psql` dentro do container:

```sh
docker compose exec postgres psql -U Arcanautadb -d arcaappteste
```

A porta no exemplo local deve acompanhar `POSTGRES_PORT` se você a alterou.

## Usar com Node.js

O projeto fornece o driver `pg` e `dotenv`, mas não contém `index.js` nem uma aplicação Node pronta. Para instalar as dependências neste repositório:

```sh
npm install
```

Em uma aplicação Node, carregue as variáveis do arquivo `.env` da própria aplicação e configure o cliente para aceitar o certificado autoassinado apenas no ambiente de desenvolvimento:

```js
const { Pool } = require('pg')

const db = new Pool({
  host: 'localhost',
  port: Number(process.env.POSTGRES_PORT || 5432),
  database: process.env.POSTGRES_DB,
  user: process.env.POSTGRES_USER,
  password: process.env.POSTGRES_PASSWORD,
  ssl: { rejectUnauthorized: false },
})

module.exports = db
```

Use placeholders para valores em consultas:

```js
const { rows } = await db.query(
  'SELECT * FROM users WHERE discord_id = $1',
  [discordId]
)
```

Os scripts `npm start` e `npm run dev` declarados em `package.json` esperam um `index.js`, que não está presente neste repositório.

Os atalhos npm disponíveis são:

| Comando | Ação |
| --- | --- |
| `npm run db:up` | Inicia o serviço com Docker Compose |
| `npm run db:down` | Para os serviços sem apagar o volume |
| `npm run db:logs` | Acompanha os logs do container `postgres` |
| `npm run ssl` | Executa `generate-ssl.cmd` no Windows |

## Comandos úteis

```sh
docker compose up -d       # inicia o banco
docker compose ps          # mostra o estado dos serviços
docker compose logs -f postgres  # acompanha os logs
docker compose down        # para os containers; mantém os dados
```

Os dados ficam no volume `postgres_data` e permanecem após `docker compose down`. Para apagar o volume e os dados do banco, use `docker compose down -v`.

Para gerar novamente os certificados no Windows, execute `generate-ssl.cmd` e reinicie o serviço:

```sh
docker compose down
docker compose up -d
```
