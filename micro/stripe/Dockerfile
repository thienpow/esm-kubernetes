FROM node:slim

COPY ./www /www
WORKDIR /www
RUN npm install --production

CMD ["node", "/www/index.js"]
EXPOSE 4242