FROM alpine:3.10

RUN apk add --no-cache git openssh-client rsync

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]

LABEL "com.github.actions.name"="Github Pages"
LABEL "com.github.actions.description"="Update Github Pages"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="blue"
