# Use Python for parent image
FROM python:3.9-slim

# Set working directory in container
WORKDIR /usr/src/micro

# Copy current directory into container
COPY . .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Make port available to outside world
EXPOSE 5000

# Run application
CMD ["python", "micro.py"]

# Make sure to build and push the image.
#docker build -t inadev/micro:latest .
#docker push inadev/micro:latest