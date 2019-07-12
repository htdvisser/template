FROM golang:1.12

ENV GO111MODULE="on" GOPROXY="https://proxy.golang.org" GOSUMDB="sum.golang.org"

RUN go get github.com/gohugoio/hugo@v0.55.6

ENTRYPOINT ["/go/bin/hugo"]

LABEL "com.github.actions.name"="Hugo"
LABEL "com.github.actions.description"="Make Hugo build a static site"
LABEL "com.github.actions.icon"="printer"
LABEL "com.github.actions.color"="orange"
