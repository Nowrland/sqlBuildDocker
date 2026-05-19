

# PostgreSQL Local

**PostgreSQL 15 rodando em Docker para desenvolvimento Node.js com suporte a SSL**

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-336791?style=for-the-badge&logo=postgresql&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-Compose-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-pg-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)
![SSL](https://img.shields.io/badge/SSL-Enabled-green?style=for-the-badge&logo=letsencrypt&logoColor=white)

</div>

---

## Pre-requisitos

| Ferramenta   | Versao minima | Instalacao                              |
|--------------|---------------|-----------------------------------------|
| Docker       | 24+           | https://docs.docker.com/get-docker      |
| Node.js      | 18+           | https://nodejs.org                      |
| Git          | qualquer      | https://git-scm.com/download/win        |

> O **Git for Windows** ja inclui o OpenSSL. O script `generate-ssl.cmd` detecta automaticamente.
> Caso nao tenha o Git: `winget install ShiningLight.OpenSSL`

---

## Estrutura

```
postgreSql/
├── ssl/
│   ├── server.crt       # certificado publico (gerado pelo script)
│   └── server.key       # chave privada (gerado pelo script)
├── .env                 # credenciais (nao versionar)
├── .gitignore
├── docker-compose.yml   # container postgres com SSL
├── generate-ssl.cmd     # gera os certificados SSL
├── package.json
└── README.md
```

---

## Primeira vez (setup completo)

```cmd
:: 1. Instalar dependencias Node
npm install

:: 2. Gerar certificados SSL (apenas uma vez)
generate-ssl.cmd

:: 3. Subir o container
docker compose up -d
```

---

## Conexao

| Campo    | Valor          |
|----------|----------------|
| Host     | `localhost`    |
| Porta    | `5432`         |
| Database | `arcaappteste` |
| User     | `Arcanautadb`  |
| SSL      | habilitado     |

---

## Node.js (`pg`)

### Instalacao

```cmd
npm install
```

Dependencias incluidas no `package.json`:

| Pacote    | Uso                           |
|-----------|-------------------------------|
| `pg`      | Driver PostgreSQL             |
| `dotenv`  | Carrega variaveis do `.env`   |
| `nodemon` | Hot reload em desenvolvimento |

### Pool de conexao

```js
const { Pool } = require('pg')

const db = new Pool({
  host:     'localhost',
  port:     5432,
  database: 'arcaappteste',
  user:     'Arcanautadb',
  password: process.env.POSTGRES_PASSWORD,
  ssl:      { rejectUnauthorized: false }, // aceita certificado auto-assinado
})

module.exports = db
```

### Ou via DATABASE_URL

```env
# .env do seu projeto Node
DATABASE_URL=postgresql://Arcanautadb:senha@localhost:5432/arcaappteste?sslmode=require
```

```js
const { Pool } = require('pg')
const db = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: { rejectUnauthorized: false },
})
```

### Exemplos de query

```js
// SELECT
const { rows } = await db.query('SELECT * FROM users WHERE id = $1', [id])

// INSERT
await db.query('INSERT INTO users (name, email) VALUES ($1, $2)', [name, email])

// UPDATE
await db.query('UPDATE users SET name = $1 WHERE id = $2', [name, id])

// DELETE
await db.query('DELETE FROM users WHERE id = $1', [id])
```

---

## SSL

| Arquivo             | Descricao                           |
|---------------------|-------------------------------------|
| `ssl/server.crt`    | Certificado publico (auto-assinado) |
| `ssl/server.key`    | Chave privada                       |
| `generate-ssl.cmd`  | Script para (re)gerar os certs      |

Certificados tem validade de **10 anos**. Para regenerar:

```cmd
docker compose down
generate-ssl.cmd
docker compose up -d
```

---

## Scripts npm

```cmd
npm start          :: executa index.js
npm run dev        :: executa com nodemon (hot reload)
npm run db:up      :: sobe o container
npm run db:down    :: para o container
npm run db:logs    :: acompanha logs do postgres
```

---

## CLI (psql)

```cmd
:: Via connection string
psql "postgresql://Arcanautadb@localhost:5432/arcaappteste?sslmode=require"

:: Dentro do container
docker exec -it postgres psql -U Arcanautadb -d arcaappteste
```

---

## Comandos Docker

```cmd
docker compose up -d        :: subir
docker compose ps           :: status
docker logs -f postgres     :: logs em tempo real
docker compose down         :: parar (dados preservados)
docker compose down -v      :: parar e apagar volume
```

---

## Credenciais

Definidas em [.env](.env) - nunca versionar esse arquivo.

---

<div align="center">
  <sub>Ambiente de desenvolvimento local</sub>
</div>
