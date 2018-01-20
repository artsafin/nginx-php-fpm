![docker hub](https://img.shields.io/docker/pulls/artsafin/nginx-php-fpm.svg?style=flat-square)
![docker hub](https://img.shields.io/docker/stars/artsafin/nginx-php-fpm.svg?style=flat-square)

## Overview
A minimal image with php-fpm and nginx fitting perfectly for development.
The image installs only necessary software and fully configurable (see below).

The list of software:
- nginx 1.13
- php 7.1
- PHP extensions: pdo_mysql pdo_sqlite mysqli mcrypt gd exif intl xsl json soap dom zip opcache
- composer

Based on [https://github.com/richarvey/nginx-php-fpm](https://github.com/richarvey/nginx-php-fpm)

## Quick Start
To pull from docker hub:
```
docker pull artsafin/nginx-php-fpm:latest
```

### Running standalone image
To simply run the container:
```
docker run -d -v<FILES>:/app -p80:80 -p443:443 artsafin/nginx-php-fpm
```

### Running image as part of docker-compose

Create a docker-compose.yml file with the following contents:

```
version: '3'

services:
  nginx-php-fpm:
    image: artsafin/nginx-php-fpm:latest
    restart: always
    environment:
    volumes:
        -<FILES>:/app
```

## Configuration

### Configuration files

Docker allows replacing and adding new files via volumes.

The following files and directories are considered by nginx or php-fpm:

| Image destination path | Source | Description |
|-----------------------------------------------|--------------------------|-----------------------------------------------------|
| /etc/supervisord.conf | conf/supervisord.conf | Supervisord main config |
| /etc/supervisor/conf.d/ |  | Additional supervisord configuration files (*.conf) |
| /etc/nginx/nginx.conf | conf/nginx.conf | Nginx main config |
| /etc/nginx/conf.d/default-site.conf | conf/default-site.conf | Nginx default site config |
| /etc/nginx/conf.d/ |  | Additional nginx configuration files (*.conf) |
| /usr/local/etc/php/conf.d/php-docker-vars.ini | conf/php-docker-vars.ini | php.ini overrides |
| /usr/local/etc/php/conf.d/ |  | Additional php configuration files (*.ini) |
| /usr/local/etc/php-fpm.d/php-fpm-pool.conf | conf/php-fpm-pool.conf | php-fpm pool config |
| /usr/local/etc/php-fpm.conf |  | Default php-fpm config |

### Environment variables

The following variables can be passed either as `docker run ... -e 'NAME=VALUE' artsafin/nginx-php-fpm` or using `docker-compose.yml`'s `environment` section:
```
...
    environment:
        - NAME=VALUE
...

```

| Name | Description | Default | Example |
|---------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------|----------------------------------------------------------------------------------------------------------------------------------|
| WEBROOT | Document root for the default nginx site.<br>Applied only if the image is run with default nginx site configuration. | /app | `-e 'WEBROOT=/app/public'`<br>`environment:<br>     - 'WEBROOT=/app/public'` |
| XDEBUG_CONFIG | Configuration for Xdebug.<br>Though xdebug extension is installed, it is not enabled for performance reasons unless XDEBUG_CONFIG is set.<br>The contents of XDEBUG_CONFIG variable are read by the xdebug extension itself, see [Xdebug documentation](https://xdebug.org/docs/remote#starting) for more info. | not set | `-e 'XDEBUG_CONFIG=remote_enable=1 remote_connect_back=1'`<br>`environment:<br>    - 'XDEBUG_CONFIG=remote_enable=1 remote_connect_back=1'` |
| PHP_IDE_SERVER_NAME | Server name needed to enable debugging in IDE.<br> Applied only if XDEBUG_CONFIG is set.<br> Unless PHP_IDE_CONFIG is set, this variable will be used to produce `PHP_IDE_CONFIG='serverName=PHP_IDE_SERVER_NAME'` | docker | `-e 'PHP_IDE_SERVER_NAME=site'`<br> `environment:<br>    - 'PHP_IDE_SERVER_NAME=site'` |

### Links
- [Github](https://github.com/artsafin/nginx-php-fpm)
- [Docker hub](https://registry.hub.docker.com/u/richarvey/nginx-php-fpm/)
- [https://github.com/richarvey/nginx-php-fpm](https://github.com/richarvey/nginx-php-fpm)
