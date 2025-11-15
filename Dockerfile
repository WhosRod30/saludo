FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
#RUN mkdir -p /app/app/data

# Copiar todo el código fuente del proyecto
COPY . ./

# Construir proyecto
RUN mvn -B -DskipTests=true clean package

FROM eclipse-temurin:21-jre

# Copiar el archivo jar compilado
COPY --from=build /app/target/*.jar app.jar

CMD ["sh","-c","java -Dserver.port=${PORT:-4002} -jar /app/app.jar"]