FROM --platform=${BUILDPLATFORM:-linux/amd64} golang:1.20 as builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH
ENV GOPROXY=https://goproxy.cn,direct

WORKDIR /app/
ADD . .
RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -ldflags="-w -s" -o hello main.go

FROM --platform=${TARGETPLATFORM:-linux/amd64} alpine:3.17
WORKDIR /app/
COPY --from=builder /app/hello /app/hello
ENTRYPOINT ["/app/hello"]
