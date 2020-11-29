# Usando a imagem Golang reduzida.
FROM golang:1.15.5-alpine AS builder
# Apk é gerenciador de pacotes do alpine dentro da imagem.

# A opção --no-cache permite não armazenar o índice em cache localmente,
# o que é útil para manter os contêineres pequenos.

# Upx usado para reduzir o tamanho dos arquivos de programas.
RUN apk update && apk add --no-cache git \
    build-base \ 
    upx

WORKDIR /go/src/hellogo

COPY hellogo/ .
# RUN CGO_ENABLED=0 GOOS=linux 

# Adiciona dependências ao módulo atual e as instala, 
# -v 'verbose' mostra os detalhes do progresso.
RUN go get -d -v 

# Compila pacotes e dependências, -o 'output',
# diretótorio e saída da compilação.
RUN go build -o /go/src/hellogo/main

# Comprime o binário 
RUN upx main

#imagem Linux reduzir, usada para montar o próprio sistema Linux
FROM scratch

WORKDIR /root/

COPY --from=builder /go/src/hellogo/ .

ENTRYPOINT ["./main"]
