FROM gradle:8.10.0-jdk21-alpine AS build

WORKDIR "/app"
COPY . .

RUN gradle clean build --no-daemon


FROM openjdk:21

WORKDIR "/app"

COPY --from=build /app/build/libs/*.jar /app/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
