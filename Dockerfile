# ========================================================
# ETAPA 1: BUILD (Compilação usando o JDK)
# ========================================================
FROM maven:3.9-eclipse-temurin-17 AS build

# Define diretório de trabalho
WORKDIR /app

# Aplica as regras econômicas de memória já na fase de compilação
ENV JAVA_TOOL_OPTIONS="-XX:MaxRAMPercentage=60.0 -XX:TieredStopAtLevel=1"

# Copia os arquivos de configuração do Maven e o código fonte do seu PC
COPY .mvn .mvn
COPY mvnw mvnw
COPY pom.xml pom.xml
COPY src src

# Garante a permissão e compila gerando o .jar (pulando os testes para poupar RAM)
RUN chmod +x mvnw && ./mvnw clean package -DskipTests

# ========================================================
# ETAPA 2: RUN (Execução super leve usando apenas o JRE)
# ========================================================
FROM eclipse-temurin:21-jre-alpine

# Define diretório de trabalho
WORKDIR /app

# Otimiza a memória JRE para a execução final do Spring Boot
ENV JAVA_TOOL_OPTIONS="-XX:MaxRAMPercentage=60.0 -XX:TieredStopAtLevel=1"

# Copia o .jar gerado na Etapa 1 e joga no JRE leve
COPY --from=build /app/target/*.jar app.jar

# Expõe a porta padrão do Tomcat
EXPOSE 8080

# Inicia a API direto pelo JRE de forma automática
ENTRYPOINT ["java", "-jar", "app.jar"]
