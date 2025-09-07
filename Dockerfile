# --- STAGE 1: Build with Maven ---
# Dùng JDK 21 thay cho 19 vì Maven chính thức không build JDK 19
FROM maven:3.9.8-eclipse-temurin-21 AS build

WORKDIR /app

# Copy pom.xml và tải dependency
COPY pom.xml .
RUN mvn -B dependency:go-offline

# Copy source code
COPY src ./src

# Build project -> ra file .war trong target/
RUN mvn -B clean package -DskipTests

# --- STAGE 2: Run on Tomcat ---
FROM tomcat:11-jdk21-temurin

WORKDIR /usr/local/tomcat

# Xóa webapp mặc định
RUN rm -rf webapps/*

# Copy file WAR vào Tomcat
COPY --from=build /app/target/*.war webapps/ROOT.war

# Đổi cổng theo Render
RUN sed -i 's/port="8080"/port="${PORT}"/' conf/server.xml

EXPOSE 8080

CMD ["catalina.sh", "run"]


