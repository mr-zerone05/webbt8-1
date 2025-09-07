# --- STAGE 1: Build with Maven ---
FROM maven:3.9.8-eclipse-temurin-21 AS build

WORKDIR /app
COPY pom.xml .
RUN mvn -B dependency:go-offline
COPY src ./src
RUN mvn -B clean package -DskipTests

# --- STAGE 2: Run with Tomcat ---
FROM tomcat:11-jdk21-temurin
WORKDIR /usr/local/tomcat

# Xóa webapp mặc định
RUN rm -rf webapps/*

# Copy file WAR vào ROOT.war
COPY --from=build /app/target/*.war webapps/ROOT.war

# Disable shutdown port (ngăn log Invalid shutdown command)
RUN sed -i 's/port="8005"/port="-1"/' conf/server.xml

# Expose port 8080 cho Render
EXPOSE 8080

CMD ["catalina.sh", "run"]





