FROM golang
WORKDIR /go/src/hellogo
COPY hellogo/ .
CMD ["go","run","hellogo.go"]