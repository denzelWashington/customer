FROM node:24.13.0 AS Builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN ["npm", "install"]
COPY . ./
RUN ["npm", "run", "build"]
FROM nginx:alpine As Executer
COPY --from=Builder /app/dist/customer/browser /usr/share/nginx/html
# Configuration pour tourner SANS les droits root :
# 1. On déplace les fichiers de PID et de cache vers /tmp (accessible à tous)
# 2. On change le port 80 par 8080 dans la config par défaut
RUN sed -i 's|/var/run/nginx.pid|/tmp/nginx.pid|g' /etc/nginx/nginx.conf && \
    sed -i 's|listen       80;|listen       8080;|g' /etc/nginx/conf.d/default.conf && \
    chmod -R 777 /var/cache/nginx /var/run /var/log/nginx /etc/nginx/conf.d

# On définit l'utilisateur non-root (optionnel mais recommandé pour la clarté)
USER 1001

EXPOSE 8080
CMD  ["nginx", "-g", "daemon off;"]


