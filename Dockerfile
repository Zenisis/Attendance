FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV FLASK_APP=main.py
ENV FLASK_ENV=production
ENV DATABASE_URL=sqlite:////attendance.db

EXPOSE 5000

CMD flask db upgrade && gunicorn --bind 0.0.0.0:5000 main:app