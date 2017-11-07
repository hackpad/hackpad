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
COPY infrastructure hackpad/infrastructure
COPY bin/build.sh exports.sh hackpad/bin/

RUN ./hackpad/bin/build.sh

# Copy start and run scripts
COPY bin/start.sh bin/run.sh hackpad/bin/

# Copy etherpad JS
COPY etherpad ./hackpad/etherpad

EXPOSE 9000

CMD '/home/hackpad/hackpad/bin/start.sh'
