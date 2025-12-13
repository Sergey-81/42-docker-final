FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
COPY tracker.db ./
RUN go build -o tracker .

FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/tracker /app/tracker
COPY --from=builder /app/tracker.db /app/tracker.db
CMD ["./tracker"]