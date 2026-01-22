# --- Étape 1 : Build ---
FROM node:22-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build -- --configuration production

# --- Étape 2 : Production avec l'image spéciale ---
# Cette image est conçue pour OpenShift (non-root)
FROM nginxinc/nginx-unprivileged:alpine

# Copie des fichiers buildés
# Attention au chemin : sur cette image c'est souvent /usr/share/nginx/html
COPY --from=build /app/dist/customer/browser /usr/share/nginx/html

# Pas besoin de modifier les ports ou les permissions,
# cette image est déjà réglée sur 8080 et /tmp

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
