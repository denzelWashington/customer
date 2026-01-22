FROM node:22-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --configuration production

FROM nginx:alpine

# 1. On supprime les configs par défaut qui posent problème
RUN rm /etc/nginx/conf.d/default.conf

# 2. On copie ton site
COPY --from=build /app/dist/customer/browser /usr/share/nginx/html

# 3. On copie TA config qui utilise /tmp
COPY nginx.conf /etc/nginx/nginx.conf

# 4. On donne les droits totaux sur /tmp et le dossier web
RUN chmod -R 777 /tmp /usr/share/nginx/html /var/cache/nginx /var/log/nginx

# OpenShift utilise un utilisateur aléatoire, on lui donne l'accès
USER 1001

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
