# --- STAGE 1: Build with Maven ---
FROM maven:3.9.8-eclipse-temurin-21 AS build

WORKDIR /app

# Copy pom.xml trước để cache dependency
COPY pom.xml .
RUN mvn -B dependency:go-offline

# Copy source code và build
COPY src ./src
RUN mvn -B clean package -DskipTests

# --- STAGE 2: Run with Tomcat ---
FROM tomcat:11-jdk21-temurin

WORKDIR /usr/local/tomcat

# Xóa webapp mặc định
RUN rm -rf webapps/*

# Copy war đã build vào ROOT.war
COPY --from=build /app/target/*.war webapps/ROOT.war

# Disable Tomcat shutdown port (fix Render warning logs)
RUN sed -i 's/port="8005"/port="-1"/' conf/server.xml

# Đổi port Tomcat để Render tự bind qua biến $PORT
RUN sed -i 's/port="8080"/port="${PORT}"/' conf/server.xml

EXPOSE 8080

CMD ["catalina.sh", "run"]



