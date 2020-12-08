# Copies in DuetWebControl code and runs NPM build
FROM node:latest as build-stage
WORKDIR /app
RUN git clone --depth 1 --branch 2.1.7 https://github.com/Duet3D/DuetWebControl.git .
RUN npm install
RUN npm run build
RUN rm -f dist/*.zip

# Starts and Serves Web Page
FROM nginx:stable-alpine as production-stage
RUN mkdir /app
COPY --from=build-stage /app/dist /app
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
