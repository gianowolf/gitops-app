FROM alpine:latest

# Install base packages
RUN apk update && apk add --no-cache git libc-dev curl

# Install Go manually to get the desired version
ENV GO_VERSION 1.22.2
RUN curl -LO "https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz" \
    && tar -C /usr/local -xzf go${GO_VERSION}.linux-amd64.tar.gz \
    && rm go${GO_VERSION}.linux-amd64.tar.gz

# Set environment variables for Go
ENV PATH="/usr/local/go/bin:$PATH"

# Install Hugo from the Alpine edge community repository
RUN apk add --no-cache --repository=https://dl-cdn.alpinelinux.org/alpine/edge/community hugo

# Define the working directory inside the container
WORKDIR /app

COPY ./app /app

# Expose default Hugo port
EXPOSE 1313

# Set the container's default command
CMD ["hugo", "server", "--buildDrafts", "--disableFastRender", "--bind", "0.0.0.0"]

