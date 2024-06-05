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
