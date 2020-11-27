FROM golang:1.15.5-alpine AS builder

WORKDIR /go/src/hellogo

COPY hellogo/ .

RUN go build main.go

FROM alpine

WORKDIR /go/src/hellogo

COPY --from=builder /go/src/hellogo .

CMD ["/bin/sh"]
