FROM node:latest as build-stage
WORKDIR /app

COPY package*.json ./
COPY quasar.conf.js ./
COPY ./ ./

RUN npm install
RUN npm install -g @vue/cli
RUN npm install -g @quasar/cli 
RUN quasar build

FROM nginx as production-stage
COPY --from=build-stage /app/dist/spa /usr/share/nginx/html
COPY /nginx/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80