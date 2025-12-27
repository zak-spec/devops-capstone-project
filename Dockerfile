# Dockerfile for the accounts microservice
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the service package
COPY service ./service

# Create a non-root user and change ownership
RUN useradd --uid 1000 theia && \
    chown -R theia /app

# Switch to non-root user
USER theia

# Expose port 8080
EXPOSE 8080

# Run the application with gunicorn
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
