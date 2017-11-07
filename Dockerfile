FROM williamyeh/scala:2.11.6
MAINTAINER Nikos Prodromidis <nikolaos.prodromidis@gmail.com>

RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -d /home/hackpad hackpad
RUN mkdir /home/hackpad
RUN chown hackpad:hackpad /home/hackpad

WORKDIR /home/hackpad

RUN mkdir -p lib/ data/logs/ hackpad/etherpad/

RUN wget https://cdn.mysql.com/archives/mysql-connector-java-5.1/mysql-connector-java-5.1.34.tar.gz && \
    tar -xzvf mysql-connector-java-5.1.34.tar.gz && \
    mv mysql-connector-java-5.1.34/mysql-connector-java-5.1.34-bin.jar lib/ && \
    rm mysql-connector-java-5.1.34.tar.gz && \
    rm -rf mysql-connector-java-5.1.34/

# Copy and build infrastructure
COPY bin hackpad/bin
COPY infrastructure hackpad/infrastructure
COPY exports.sh hackpad/bin/exports.sh

RUN ./hackpad/bin/build.sh

# Copy etherpad JS and star script
COPY etherpad ./hackpad/etherpad
COPY start.sh start.sh
RUN chmod +x start.sh

EXPOSE 9000

CMD '/home/hackpad/start.sh'
