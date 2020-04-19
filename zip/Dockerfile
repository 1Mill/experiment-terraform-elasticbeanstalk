FROM alpine:3

RUN apk update && apk add zip

WORKDIR /app
COPY *.sh .

CMD [ "./entrypoint.sh" ]
