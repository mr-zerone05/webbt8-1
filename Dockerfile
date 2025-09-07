# --- STAGE 1: Build with Maven ---
FROM maven:3.9.8-eclipse-temurin-19 AS build

WORKDIR /app

# copy pom trước để cache deps
COPY pom.xml .
RUN mvn -B -q dependency:go-offline

# copy source
COPY src ./src

# build WAR
RUN mvn -B -DskipTests package


# --- STAGE 2: Run with Tomcat 11 on JDK 19 ---
FROM tomcat:11.0.0-M17-jdk19

WORKDIR /usr/local/tomcat

# Xóa apps mặc định
RUN rm -rf webapps/*

# Copy war thành ROOT.war
COPY --from=build /app/target/ch08_ex1_email.war webapps/ROOT.war

# Render set $PORT, ta sửa server.xml để Tomcat listen trên $PORT
RUN sed -i 's/port="8080"/port="${PORT}"/' conf/server.xml

EXPOSE 8080

CMD ["catalina.sh", "run"]
