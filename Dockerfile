# === Stage 1: Builder ===
FROM node:18-alpine AS builder
LABEL stage=builder
WORKDIR /app

# Install only dependencies if package files change
COPY package*.json ./
RUN npm ci

# Copy source and build
COPY . .
RUN npm run build



# === Stage 2: Production Image ===
FROM nginx:stable-alpine
LABEL maintainer="khaled khaled@example.com"
LABEL version="1.0.0"

# Optional: define environment variables for future dynamic behavior
ENV NODE_ENV=production

# Copy build output to NGINX html directory
COPY --from=builder /app/build /usr/share/nginx/html

# Optional healthcheck to ensure NGINX serves content
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget --spider --quiet http://localhost/ || exit 1

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
