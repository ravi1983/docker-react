# Build phase
FROM node as builder
WORKDIR /home

COPY package.json .
RUN npm install
COPY . .

# Prod artifact will be created in /home/build of the container
RUN npm run build

# Run phase. Each from phase terminates previous block
FROM nginx

# Copy file fropm builder phase container to this container
COPY --from=builder /home/build /usr/share/nginx/html

# Default command for nginx container will start nginx. No need for exlicit start in this file.