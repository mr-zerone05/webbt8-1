# --- STAGE 1: Build with Maven ---
FROM maven:3.9.8-eclipse-temurin-19 AS build

WORKDIR /app

COPY pom.xml .
RUN mvn -B -q dependency:go-offline

COPY src ./src
RUN mvn -B -DskipTests package

# --- STAGE 2: Run on Tomcat 11 (JDK 19) ---
FROM tomcat:11-jdk19-temurin

WORKDIR /usr/local/tomcat

RUN rm -rf webapps/*

COPY --from=build /app/target/ch08_ex1_email.war webapps/ROOT.war

# Sửa cổng 8080 thành $PORT để Render mapping
RUN sed -i 's/port="8080"/port="${PORT}"/' conf/server.xml

EXPOSE 8080

CMD ["catalina.sh", "run"]

