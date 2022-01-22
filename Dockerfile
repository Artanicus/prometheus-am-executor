FROM golang:1.17-alpine as builder

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./
COPY chanmap ./chanmap
COPY countermap ./countermap
RUN go build

FROM alpine:latest
COPY --from=builder /app/prometheus-am-executor /prometheus-am-executor
EXPOSE 8080
ENTRYPOINT [ "/prometheus-am-executor" ]
