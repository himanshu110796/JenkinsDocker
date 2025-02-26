# Use an official OpenJDK 17 runtime as a parent image
FROM openjdk:17-jdk

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file from your host to the container
COPY target/myapp.jar /app/myapp.jar

# Expose port 8050 (or the port your app runs on)
EXPOSE 8050

# Run the JAR file
ENTRYPOINT ["java", "-jar", "myapp.jar"]
