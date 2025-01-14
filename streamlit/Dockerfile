FROM python:3.12-slim

WORKDIR /app

# install requirements
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# generate secrets.toml file
COPY generate_secrets.sh ./
ARG DB_NAME
ARG DB_USER
ARG DB_PASSWORD
RUN sh generate_secrets.sh

# copy files
COPY app.py ./

# run Streamlit
CMD ["streamlit", "run", "app.py", "--server.port=8501", "--server.address=0.0.0.0"]