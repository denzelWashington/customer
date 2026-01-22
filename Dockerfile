FROM node:24.13.0 AS Builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN ["npm", "install"]
COPY . ./
RUN ["npm", "run", "build"]
FROM nginx:alpine As Executer
COPY --from=Builder /app/dist/customer/browser /usr/share/nginx/html
CMD  ["nginx", "-g", "daemon off;"]


