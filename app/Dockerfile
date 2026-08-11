# app/Dockerfile
# Multi-stage build for production-grade Nginx container
# Stage 1: Build stage (validates our HTML/config)
# Stage 2: Production stage (minimal image)

# =============================================================================
# STAGE 1 — Validate
# =============================================================================
FROM nginx:1.27-alpine AS validator

# Copy configuration for validation
COPY nginx.conf /etc/nginx/nginx.conf

# Test nginx configuration syntax
# This catches configuration errors before we build the final image
RUN nginx -t

# =============================================================================
# STAGE 2 — Production
# =============================================================================
FROM nginx:1.27-alpine AS production

# Metadata labels - industry standard
LABEL maintainer="Ghaith <github.com/ghaithsoltani>"
LABEL version="1.0.0"
LABEL description="GitOps Pipeline Demo Application"

# Copy validated nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy web application files
COPY html/ /usr/share/nginx/html/

# Create non-root user for nginx workers
# The master process still needs root to bind port 80
# but worker processes run as this user
RUN addgroup -g 1001 -S appgroup && \
    adduser -u 1001 -S appuser -G appgroup && \
    chown -R appuser:appgroup /usr/share/nginx/html && \
    chown -R appuser:appgroup /var/cache/nginx && \
    chown -R appuser:appgroup /var/log/nginx && \
    touch /var/run/nginx.pid && \
    chown appuser:appgroup /var/run/nginx.pid

# Health check — Docker will monitor container health
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost/health || exit 1

# Expose port 80
EXPOSE 80

# Run as non-root
USER appuser

CMD ["nginx", "-g", "daemon off;"]
