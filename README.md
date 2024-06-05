# global_solution_devops
GLOBAL SOLUTION - DEVOPS TOOLS E CLOUD COMPUTING
Claro! Abaixo está o conteúdo do arquivo `README.md` com instruções detalhadas sobre como configurar e rodar o projeto:

---

# Flask To-Do List Application

## Visão Geral

Este projeto é uma aplicação web simples para gerenciar uma lista de tarefas (To-Do List), desenvolvida em Python utilizando o framework Flask e persistência de dados com MySQL. A aplicação é containerizada utilizando Docker e gerenciada com Docker Compose.

## Estrutura do Projeto

- **app.py**: Código principal da aplicação Flask.
- **requirements.txt**: Lista de dependências Python.
- **Dockerfile**: Definição do container Docker para a aplicação Flask.
- **docker-compose.yml**: Definição do Docker Compose para orquestrar os containers.
- **README.md**: Este arquivo com instruções detalhadas.

## Pré-requisitos

Antes de começar, certifique-se de ter o seguinte instalado em sua máquina:

- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Instruções para Configuração e Execução

### 1. Clonar o Repositório

Clone o repositório para sua máquina local:

```bash
git clone https://github.com/seu-usuario/flask-todo-app.git
cd flask-todo-app
```

### 2. Configurar as Variáveis de Ambiente

Crie um arquivo `.env` na raiz do projeto com o seguinte conteúdo:

```env
FLASK_ENV=development
DATABASE_URL=mysql+pymysql://user:password@mysql/tododb
```

### 3. Construir e Iniciar os Containers

Use o Docker Compose para construir as imagens e iniciar os containers:

```bash
docker-compose up --build
```

### 4. Acessar a Aplicação

A aplicação estará disponível em [http://localhost:5000](http://localhost:5000).

### 5. Endpoints da API

- **GET /tasks**: Retorna todas as tarefas.
- **POST /tasks**: Adiciona uma nova tarefa.
  - Corpo da requisição: `{ "title": "Task title", "description": "Task description" }`
- **PUT /tasks/{id}**: Atualiza uma tarefa existente.
  - Corpo da requisição: `{ "title": "Updated title", "description": "Updated description" }`
- **DELETE /tasks/{id}**: Deleta uma tarefa existente.

## Detalhes Técnicos

### Dockerfile

O `Dockerfile` define a imagem para a aplicação Flask:

```Dockerfile
# Utilizando uma imagem base do Python
FROM python:3.9-slim

# Definir o diretório de trabalho
WORKDIR /app

# Copiar os arquivos de requisitos
COPY requirements.txt requirements.txt

# Instalar as dependências
RUN pip install --no-cache-dir -r requirements.txt

# Copiar o código da aplicação
COPY . .

# Definir as variáveis de ambiente
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Definir o usuário não privilegiado
RUN useradd -m appuser
USER appuser

# Expor a porta da aplicação
EXPOSE 5000

# Comando para iniciar a aplicação
ENTRYPOINT ["flask", "run"]
```

### Docker Compose

O `docker-compose.yml` define os serviços necessários:

```yaml
version: '3.8'

services:
  mysql:
    image: mysql:8
    environment:
      MYSQL_ROOT_PASSWORD: rootpassword
      MYSQL_DATABASE: tododb
      MYSQL_USER: user
      MYSQL_PASSWORD: password
    volumes:
      - mysql-data:/var/lib/mysql

  app:
    build:
      context: .
      dockerfile: Dockerfile
    environment:
      FLASK_ENV: development
      DATABASE_URL: mysql+pymysql://user:password@mysql/tododb
    depends_on:
      - mysql
    ports:
      - "5000:5000"
    command: ["flask", "run"]

volumes:
  mysql-data:
```

## Persistência de Dados

Os dados são persistidos no banco de dados MySQL utilizando volumes do Docker, garantindo que os dados sejam mantidos mesmo após reiniciar os containers.

## Contribuições

Se você deseja contribuir com este projeto, por favor siga os passos abaixo:

1. Faça um fork do repositório.
2. Crie uma branch para sua feature (`git checkout -b feature/nova-feature`).
3. Commit suas alterações (`git commit -am 'Adiciona nova feature'`).
4. Envie para a branch (`git push origin feature/nova-feature`).
5. Abra um Pull Request.

## Licença

Este projeto está licenciado sob a Licença MIT. Consulte o arquivo LICENSE para mais detalhes.




