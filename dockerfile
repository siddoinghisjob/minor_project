# Use an official Python runtime as a parent image
FROM python:3.6-slim

USER 0

WORKDIR /app

RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    software-properties-common \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/siddoinghisjob/minor_project.git .

RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir -p /app/Uploaded_Resumes

RUN python -m spacy download en

EXPOSE 8501

HEALTHCHECK CMD curl --fail http://localhost:8501/_stcore/health

ENTRYPOINT ["streamlit", "run", "App.py", "--server.port=8501", "--server.address=0.0.0.0"]