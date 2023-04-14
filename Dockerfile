# Build stage
FROM golang:1.19 AS builder

# Set destination for COPY
WORKDIR /app

# Download Go modules
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code. Note the slash at the end, as explained in
# https://docs.docker.com/engine/reference/builder/#copy
#TODO probably improve this and don't hardcode the directories
COPY *.go ./
COPY radius/*.go ./radius/
COPY server/*.go ./server/

# Build
RUN CGO_ENABLED=0 GOOS=linux go build -o /grp

# Second stage to reduce size of image
FROM alpine:latest
COPY --from=builder /grp /grp

EXPOSE 2083/tcp

# Run
ENTRYPOINT ["/grp"]
