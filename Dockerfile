FROM openjdk:8u232

USER root

WORKDIR /ontop

# get ontop executable
RUN wget https://github.com/ontop/ontop/releases/download/ontop-3.0.1/ontop-cli-3.0.1.zip
RUN unzip ontop-cli-3.0.1.zip
RUN rm ontop-cli-3.0.1.zip

# get jdbc connector
RUN wget https://downloads.mysql.com/archives/get/p/3/file/mysql-connector-java-8.0.19.tar.gz -P /tartmp
RUN tar -C /tartmp -zxvf /tartmp/mysql-connector-java-8.0.19.tar.gz
RUN cp /tartmp/mysql-connector-java-8.0.19/mysql-connector-java-8.0.19.jar ./jdbc
RUN rm -rf /tartmp

COPY start.sh start.sh
RUN chmod +x start.sh

VOLUME /ontop/input

EXPOSE 8080

CMD ["./start.sh"]