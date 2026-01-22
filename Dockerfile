FROM node:24.13.0 AS Builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN ["npm", "install"]
COPY . ./
RUN ["npm", "run", "build"]
FROM nginx:alpine As Executer
COPY --from=Builder /app/dist/customer/browser /usr/share/nginx/html
# On copie TA configuration personnalisée
COPY nginx.conf /etc/nginx/nginx.conf

# On donne les droits sur le dossier HTML (au cas où)
RUN chmod -R 777 /usr/share/nginx/html /var/cache/nginx /var/run /var/log/nginx

EXPOSE 8080
CMD  ["nginx", "-g", "daemon off;"]


