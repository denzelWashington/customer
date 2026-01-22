FROM node:22-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --configuration production

# On utilise l'image Bitnami qui est la référence absolue pour OpenShift
FROM bitnami/nginx:latest
COPY --from=build /app/dist/customer/browser /app
# Bitnami utilise le port 8080 par défaut et est 100% non-root
EXPOSE 8080
