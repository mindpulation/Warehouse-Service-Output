# docker-compose.yml References: https://docs.docker.com/engine/reference/builder/

# Start from the latest golang base image
FROM golang as builder

# Add Maintainer Info
LABEL maintainer="Muhammad Indrawan <me@aboutindra.com>"

# Set the Current Working Directory inside the container
WORKDIR /go/src/github.com/mindpulation/Warehouse-Service-Output

# Copy the source from the current directory to the Working Directory inside the container
COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix .

FROM alpine:latest
WORKDIR /app/
COPY --from=builder /go/src/github.com/mindpulation/Warehouse-Service-Output /app/Warehouse-Service-Output
WORKDIR "/app/Warehouse-Service-Output"
EXPOSE 9554
ENTRYPOINT ./woutput