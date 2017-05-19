## Guacamole Client Image

[![](https://images.microbadger.com/badges/image/khirin/guacamole-client.svg)](https://microbadger.com/images/khirin/mariadb "Get your own image badge on microbadger.com")

### Description
This is my minimal customized Guacamole Client image based on Alpine (with [my alpine image](https://hub.docker.com/r/khirin/alpine/)).
No root process.

### Guacamole Images
• Client Part : [khirin/guacamole-client](https://hub.docker.com/r/khirin/guacamole-client/)
• Server Part : [khirin/guacamole-server](https://hub.docker.com/r/khirin/guacamole-server/)
• DB Part : [khirin/guacamole-db](https://hub.docker.com/r/khirin/guacamole-db/)

### Packages
• Packages from [khirin/tomcat](https://hub.docker.com/r/khirin/tomcat/)
• guacamole-0.9.12-incubating.war
• guacamole-auth-jdbc-0.9.12-incubating.tar.gz
• mysql-connector-java-5.1.42.tar.gz

### Default Configuration
• Configuration from [khirin/tomcat](https://hub.docker.com/r/khirin/tomcat/)
• Default user (UID) : tomcat (2000)
• Default group (GID) : tomcat (2000)

### Default ENV / ARG
• Use a "guacamole" DB with user/password "guacamole/guacamole"
• All options can be modified at build/create time with --build-arg & --env.
**DB password must be set with [base64](https://www.base64encode.org/) coding.**

### Network
• guacamole-network : Network with only the guacamole-db container and the guacamole-client container.
```shell
docker network create -o "com.docker.network.bridge.name=guacamole" guacamole-network
```
### Usage
• Run : Will use the default configuration above.
• Build : Example of custom build. You can also directly modify the Dockerfile (I won't be mad, promis !)
• Create : Example of custom create. It is useless to publish the port, expose it is enough to other container(s) on the same network.

##### • Run
```shell
docker run --detach \
			--network guacamole-network \
			khirin/guacamole-client`
docker network connect bridge guacamole-client
```

##### • Build
```shell
/bin/docker build \
                --no-cache=true \
                --force-rm \
                --build-arg GUACAMOLE_HOME="/guacamole" \
                --build-arg GUACAMOLE_DB_SRV="guacamole-db" \
                --build-arg GUACAMOLE_DB_PORT="3306" \
                --build-arg GUACAMOLE_DB="guacamole" \
                --build-arg GUACAMOLE_DB_USER="guacamole" \
                --build-arg GUACAMOLE_DB_PASSWORD="Z3VhY2Ftb2xlCg==" \
                --build-arg GUACAMOLE_GUACD_SRV="guacamole-server" \
                --build-arg GUACAMOLE_GUACD_PORT="4822" \
                -t repo/guacamole-client .
```

##### • Create
```shell
docker create --hostname=guacamole-client \
                --name guacamole-client \
                -m 384M --memory-swap 512M \
                --network guacamole-network \
                repo/guacamole-client
docker network connect bridge guacamole-client
```

### Author
khirin : [DockerHub](https://hub.docker.com/u/khirin/), [GitHub](https://github.com/khirin?tab=repositories)

### Thanks
All my images are based on my personal knowledge and inspired by many projects of the Docker community.
If you recognize yourself in some working approaches, you might be one of my inspirations (Thanks!).

