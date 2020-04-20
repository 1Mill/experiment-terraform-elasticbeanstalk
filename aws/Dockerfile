FROM ubuntu:18.04

RUN apt-get update && apt-get install --yes git unzip wget

RUN wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
RUN unzip awscli-exe-linux-x86_64.zip
RUN ./aws/install
RUN rm -rf aws awscli-exe-linux-x86_64.zip

WORKDIR /app
COPY entrypoint.sh ./

CMD [ "bash", "entrypoint.sh" ]
