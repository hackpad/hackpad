FROM williamyeh/scala:2.11.6
MAINTAINER Nikos Prodromidis <nikolaos.prodromidis@gmail.com>

RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -d /home/hackpad hackpad
RUN mkdir /home/hackpad
RUN chown hackpad:hackpad /home/hackpad

WORKDIR /home/hackpad

ENV MYSQL_CONNECTOR mysql-connector-java-5.1.34
RUN mkdir -p lib/ && \
    wget -q https://cdn.mysql.com/archives/mysql-connector-java-5.1/$MYSQL_CONNECTOR.tar.gz -O - | \
    tar -C lib/ -xzvf - $MYSQL_CONNECTOR/$MYSQL_CONNECTOR-bin.jar --strip-components=1

# Copy and build infrastructure
COPY infrastructure infrastructure/
COPY bin/build.sh exports.sh bin/

RUN mkdir -p etherpad/ && bin/build.sh

# Copy start and run scripts
COPY bin/start.sh bin/run.sh bin/

# Copy etherpad JS
COPY etherpad etherpad/

EXPOSE 9000

CMD bin/start.sh
