# npm install & build
FROM node:16-alpine AS builder

WORKDIR /app

COPY package.json .
RUN npm install

COPY . .
RUN npm run build
# /app/build from "npm run build" command

# start nginx
FROM nginx

# --from=<FROM AS name>
# /usr/share/nginx/html -> https://www.docker.com/blog/how-to-use-the-official-nginx-docker-image/
COPY --from=builder /app/build /usr/share/nginx/html
