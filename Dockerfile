FROM maven as build
WORKDIR /usr/app
COPY pom.xml ./pom.xml
RUN mvn dependency:go-offline -B
COPY /src ./src
RUN mvn package -DskipTests


FROM openjdk:alpine as deploy
COPY --from=build /usr/app/target/metadata-service.jar ./app.jar
EXPOSE 8080
CMD ["java","-jar","./app.jar"]