FROM golang:1.19

WORKDIR /app

# Install go dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy all content to the image
COPY . .

# Build the service
RUN go build -o /service

# Install Python & jq
RUN apt-get update
RUN apt-get -y install python3 python3-setuptools python3-pip jq

# Install SmartSPEC dependencies
RUN python3 -m pip install numpy pandas matplotlib scikit-learn python-rapidjson tqdm ruptures mysql-connector-python

CMD [ "/service" ]
