FROM node:lts

WORKDIR /usr/src/app

COPY . .

RUN npm install

EXPOSE 3000

LABEL traefik.enable=true

LABEL traefik.http.routers.error-router.rule=HostRegexp(`{host:.+}`)
LABEL traefik.http.routers.error-router.priority=1
LABEL traefik.http.routers.error-router.entrypoints=https
LABEL traefik.http.routers.error-router.middlewares=error-pages-middleware
  
LABEL traefik.http.middlewares.error-pages-middleware.errors.status=400-599
LABEL traefik.http.middlewares.error-pages-middleware.errors.service=error-pages-service
LABEL traefik.http.middlewares.error-pages-middleware.errors.query=/{status}

LABEL traefik.http.services.error-pages-service.loadbalancer.server.port=3000

HEALTHCHECK --interval=30s --timeout=30s --start-period=10s \
    --retries=3 CMD [ "sh", "-c", "echo -n 'curl localhost:3000/200... '; \
    (\
        curl -sf localhost:3000/200 > /dev/null\
    ) && echo OK || (\
        echo Fail && exit 2\
    )"]

CMD [ "npm", "start" ]
