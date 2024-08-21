# Use the official Ubuntu base image
FROM python:3.10
# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    gnupg \
    tar \
    && rm -rf /var/lib/apt/lists/*
# Set working directory
WORKDIR /app

# Download and extract the tar.gz file from GitHub
RUN curl https://github.com/hemsakatu/animated-winner/raw/main/train.zip -L -O -J

RUN unzip train.zip


# Install Node.js dependencies
# Expose the port the app runs on (if applicable, change if needed)
EXPOSE 3000
# Run the application
CMD ["python", "app.py"]
