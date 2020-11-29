FROM golang:1.15.5-alpine AS builder

RUN apk update && apk add --no-cache git \
    build-base \ 
    upx

WORKDIR /go/src/hellogo

COPY hellogo/ .
#RUN CGO_ENABLED=0 GOOS=linux 
RUN go get -d -v 
RUN go build -o /go/src/hellogo/main
RUN upx main

FROM scratch

WORKDIR /root/
# Copy our static executable.
COPY --from=builder /go/src/hellogo/ .
# Run the hello binary.
ENTRYPOINT ["./main"]
