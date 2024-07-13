
ARG OS=linux
ARG ARCH=amd64

# Builder
FROM golang:1.21.5-alpine3.17 as builder

WORKDIR /go/src/pihole-exporter
COPY . .

RUN apk --no-cache add git alpine-sdk 

RUN GO111MODULE=on go mod vendor
RUN CGO_ENABLED=0 GOOS=$OS GOARCH=$ARCH go build -ldflags '-s -w' -o binary ./

# Main image
# Using golang in case needed - can be switched to alpine if needed
FROM golang:1.21.5-alpine3.17

LABEL name="pihole-exporter"

RUN apk -U --no-cache upgrade \
    && apk add bind-tools

WORKDIR /root/
COPY --from=builder /go/src/pihole-exporter/binary pihole-exporter

COPY --chown=root:root entrypoint.sh /run.sh
ENTRYPOINT ["sh", "/run.sh"]
