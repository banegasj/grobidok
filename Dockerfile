# Use the openjdk base image (GROBID requires Java 11)
FROM openjdk:11-jdk

# Install dependencies (like wget and unzip)
RUN apt-get update && \
    apt-get install -y wget unzip && \
    rm -rf /var/lib/apt/lists/*

# Create app directory inside the container
WORKDIR /app

# Copy all the files from your repo into the container
COPY . /app

# Make the Gradle wrapper executable
RUN chmod +x ./gradlew

# Build the project
RUN ./gradlew clean install

# Expose the GROBID port (Render will handle dynamic port assignment)
EXPOSE 7080

# Start the GROBID application using the dynamically assigned port from Render
CMD ["./gradlew", "run", "--args=-p $PORT"]


