# Usa una versión compatible de Node.js
FROM node:18

# Establece el directorio de trabajo
WORKDIR /usr/src/app/client

# Copia los archivos necesarios
COPY package*.json ./

# Limpia instalaciones previas y reinstala dependencias
RUN rm -rf node_modules package-lock.json && npm install

# Instala webpack explícitamente
RUN npm install --save-dev webpack webpack-cli

# Asegura permisos y ejecuta webpack directamente
RUN chmod -R +x node_modules/.bin && node_modules/.bin/webpack --mode production
