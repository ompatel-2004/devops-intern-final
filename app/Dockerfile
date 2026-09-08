# syntax=docker/dockerfile:1

FROM nginx:1.27-alpine

ARG BUILD_SHA=unknown

LABEL org.opencontainers.image.source="https://github.com/ompatel-2004/devops-intern-final" \
      org.opencontainers.image.description="NGINX web application for the DevOps Intern Final Assessment" \
      org.opencontainers.image.licenses="MIT"

# Create an unprivileged user for the NGINX process.
RUN addgroup -S appgroup \
    && adduser -S appuser -G appgroup

# Use the repository's NGINX configuration and static page.
COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html/index.html

# Inject the build identifier into the page and NGINX response header.
RUN sed -i "s/__BUILD_SHA__/${BUILD_SHA}/g" /usr/share/nginx/html/index.html \
    && sed -i "s/__BUILD_SHA__/${BUILD_SHA}/g" /etc/nginx/nginx.conf

# NGINX normally expects some writable directories.
# Since the container runs as a non-root user, give that user ownership.
RUN mkdir -p \
        /tmp/client_temp \
        /tmp/proxy_temp \
        /tmp/fastcgi_temp \
        /tmp/uwsgi_temp \
        /tmp/scgi_temp \
    && chown -R appuser:appgroup \
        /usr/share/nginx/html \
        /etc/nginx \
        /tmp \
        /var/cache/nginx

USER appuser

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -qO- http://127.0.0.1:8080/healthz || exit 1

CMD ["nginx", "-g", "daemon off;"]
