FROM golang:1.19

WORKDIR /app

# Install go dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy all content to the image
COPY . .

# Build the service
RUN go build -o /service

CMD [ "/service" ]
