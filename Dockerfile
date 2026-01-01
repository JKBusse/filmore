FROM python:3.11-slim

# Prevents Python from writing .pyc files to disc and buffers stdout/stderr
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    FLASK_ENV=production

WORKDIR /app

# System deps for Pillow or other packages (if needed). Keep minimal.
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy app code
COPY . /app

# Ensure instance and upload dirs exist
RUN mkdir -p /app/instance /app/static/uploads \
    && chown -R root:root /app

EXPOSE 5001
