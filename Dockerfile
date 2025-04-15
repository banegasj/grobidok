FROM openjdk:11-jdk

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget unzip && \
    rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy the repo contents
COPY . /app

# Build the project
RUN ./gradlew clean install

# Expose GROBID port
EXPOSE 7080
EXPOSE $PORT

# Start GROBID
CMD ["./gradlew", "run", "-Dgrobid.port=$PORT"]

