# Etapa 1: Build con Node.js
FROM node:18-alpine AS build
WORKDIR /app

# Copiar archivos de configuración de npm
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar todo el código (incluyendo la carpeta src y public)
COPY . .

# Ejecutar el build de Vite para generar la carpeta /dist
RUN npm run build

# Etapa 2: Servir con Nginx
FROM nginx:stable-alpine

# Copiar los archivos construidos desde la etapa anterior
COPY --from=build /app/dist /usr/share/nginx/html

# Exponer el puerto estándar
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]