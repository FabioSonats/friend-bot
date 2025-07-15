# Etapa 1: build do Flutter Web
FROM dart:stable AS builder

WORKDIR /app

# Copia tudo (exceto .dockerignore)
COPY . .

# Instala Flutter
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /flutter
ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Aceita licenças automaticamente
RUN flutter doctor -v
RUN flutter config --enable-web
RUN flutter pub get
RUN flutter build web --release

# Etapa 2: servidor Nginx para servir os arquivos
FROM nginx:1-alpine-slim

COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
