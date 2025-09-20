# Stage 1: Build the React (Vite) app
FROM node:18-alpine AS builder

WORKDIR /app

# Copy dependency files
COPY package.json package-lock.json* ./

RUN npm ci

# Copy source code
COPY . .

# Build React app
RUN npm run build

# Stage 2: Serve static build with runtime config
FROM node:18-alpine AS runner

WORKDIR /app
ENV NODE_ENV=production

# Install serve
RUN npm install -g serve

# Copy build output
COPY --from=builder /app/dist ./dist

# Copy entrypoint script to inject runtime config
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 5173

# Run entrypoint (generates config.js before serving)
CMD ["/entrypoint.sh"]
