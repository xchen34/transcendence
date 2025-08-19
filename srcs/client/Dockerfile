# Etape 1 : builder Node for Tailwind
FROM node:18-alpine AS builder

ARG GOOGLE_USER_ID
ENV GOOGLE_USER_ID=${GOOGLE_USER_ID}

WORKDIR /app

# Install tailwind and his dependances
COPY /files/pages/script/package.json /files/pages/script/postcss.config.js /files/pages/script/tailwind.config.js ./

RUN npm install

# Install TypeScript globally 
RUN npm install -g typescript

# Copy HTML/CSS/JS files
COPY ./files/pages ./files/pages
# COPY ./files/pages/fonts.css /var/www/html/css/

# Compile Tailwind
RUN npx tailwindcss -i ./files/pages/main.css -o ./files/pages/main.final.css --minify

RUN echo "const google_client_id: string = \"${GOOGLE_USER_ID}\";" > ./files/pages/script/env.ts

# Compile TypeScript 
RUN tsc --project ./files/pages/script/tsconfig.json && \
        find ./files/pages/script -name "*.ts" -not -name "*.d.ts" -delete

# Etape 2 : final image of Nginx
FROM debian:bullseye
# FROM ubuntu:22.04

ARG PRODUCTION=false
ENV PRODUCTION=${PRODUCTION}

RUN apt update -y && apt upgrade -y && apt install -y \
        curl \
        nginx 

RUN mkdir -p /etc/nginx/ssl

COPY ./certificat/. /etc/nginx/ssl/

RUN mkdir -p /var/www/html

EXPOSE 443

COPY ./conf/nginx.conf /etc/nginx/nginx.conf

COPY ./tool/ssl.sh /app/ssl.sh

COPY --from=builder /app/files/pages/main.final.css ./main.final.css

COPY --from=builder /app/files/pages/script/*.js /var/www/html/script/

COPY --from=builder /app/files/pages /var/www/html

RUN chmod -R 755 /var/www/html

RUN chown -R www-data:www-data /var/www/html

RUN [ "$PRODUCTION" = "true" ] && find /var/www/html/script -name "*.js" -exec sed -i 's/console\.log([^)]*);//g' {} \; || true

CMD ["nginx", "-g", "daemon off;"]