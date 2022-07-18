FROM node:12-alpine

EXPOSE 80

RUN mkdir /app
WORKDIR /app

COPY index.html package.json package-lock.json server.js flag.txt ./

RUN npm install

CMD node server.js