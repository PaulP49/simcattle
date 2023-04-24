FROM node:16-alpine
ENV NODE_ENV development

WORKDIR /

COPY package.json package-lock.json /

RUN npm install

# Copy app files
COPY . .

# Start the app
CMD [ "npm", "start" ]