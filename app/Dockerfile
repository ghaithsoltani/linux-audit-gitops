FROM nginx:1.27-alpine AS validator

COPY nginx.conf /etc/nginx/nginx.conf

RUN nginx -t

FROM nginx:1.27-alpine AS production

LABEL maintainer="Ghaith <github.com/ghaithsoltani>"
LABEL version="1.0.0"
LABEL description="GitOps Pipeline Demo Application"

COPY nginx.conf /etc/nginx/nginx.conf
COPY html/ /usr/share/nginx/html/

RUN addgroup -g 1001 -S appgroup && \
    adduser -u 1001 -S appuser -G appgroup && \
    chown -R appuser:appgroup /usr/share/nginx/html && \
    chown -R appuser:appgroup /var/cache/nginx && \
    chown -R appuser:appgroup /var/log/nginx && \
    touch /tmp/nginx.pid && \
    chown appuser:appgroup /tmp/nginx.pid

HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=5 \
    CMD curl -f http://127.0.0.1/health || exit 1

EXPOSE 80

USER appuser

CMD ["nginx", "-g", "daemon off;"]
