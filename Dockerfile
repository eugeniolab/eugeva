# Usa una imagen Node.js Alpine como base
FROM node:18-alpine

# Establece la carpeta raíz del contenedor
WORKDIR /usr/src/app

# Copia y configura las dependencias del cliente
WORKDIR /usr/src/app/client
COPY client/package*.json ./
RUN npm install --no-cache

# Asegura permisos ejecutables para los binarios locales
RUN chmod -R +x node_modules/.bin

# Copia el código fuente del cliente y construye la aplicación
COPY client/ ./
RUN npm run build

# Configura la carpeta raíz para el servidor
WORKDIR /usr/src/app/server

# Copia y configura las dependencias del servidor
COPY server/package*.json ./
RUN npm install --no-cache

# Copia el código fuente del servidor
COPY server/ ./

# Copia los archivos construidos del cliente al directorio público del servidor
RUN mkdir -p ./public && cp -R /usr/src/app/client/dist/* ./public/

# Expone el puerto del servidor
EXPOSE 5000

# Comando predeterminado para ejecutar el servidor
CMD ["npm", "start"]
