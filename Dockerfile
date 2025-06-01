# Use official Python 3.12 base image
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies needed for Poetry and building wheels
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry (latest stable)
RUN curl -sSL https://install.python-poetry.org | python3 -

# Add Poetry to PATH
ENV PATH="/root/.local/bin:$PATH"

# Copy project files
COPY pyproject.toml poetry.lock* /app/

# Install torch CPU manually from PyTorch official CPU wheel URL
RUN pip install --no-cache-dir torch==2.3.0+cpu -f https://download.pytorch.org/whl/cpu/torch_stable.html

# Install dependencies via Poetry (without installing torch again)
RUN poetry install --no-root --no-interaction --no-ansi

# Copy rest of your project files
COPY . /app

# Expose port if your app listens on one (example 8000)
EXPOSE 8000

# Command to run your app, change as needed
CMD ["poetry", "run", "python", "main.py"]
