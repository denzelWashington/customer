FROM node:24.13.0 AS Builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN ["npm", "install"]
COPY . ./
RUN ["npm", "run", "build"]
FROM nginx:alpine As Executer
COPY --from=Builder /app/dist/customer/browser /usr/share/nginx/html
# On donne les droits sur les dossiers de cache et de config
RUN chmod -R 777 /var/cache/nginx /var/run /var/log/nginx /etc/nginx/conf.d

# 3. On modifie la config Nginx par défaut pour écouter sur 8080
RUN sed -i 's/listen\(.*\)80;/listen 8080;/' /etc/nginx/conf.d/default.conf

# 4. On expose le port 8080
EXPOSE 8080
CMD  ["nginx", "-g", "daemon off;"]


