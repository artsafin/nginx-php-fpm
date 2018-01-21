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
docker run -d -v$PWD:/app -p80:80 -p443:443 artsafin/nginx-php-fpm:latest
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
        - 'WEBROOT=/app/web'
        - 'PHP_EXT=pcntl'
    volumes:
        - .:/app
```

## Configuration

### Configuration files

Docker allows replacing and adding new files via volumes.

The following files and directories are considered by nginx or php-fpm:

| Image destination path | Source | Description |
|-----------------------------------------------|--------------------------|-----------------------------------------------------|
| /etc/supervisord.conf | conf/supervisord.conf | Supervisord main config |
| /etc/supervisor/conf.d/ |  | Additional supervisord configuration files (*.conf) |
| /etc/nginx/nginx.conf | conf/nginx/nginx.conf | Nginx main config |
| /etc/nginx/conf.d/default-site.conf | conf/nginx/default-site.conf | Nginx default site config ([raw](https://raw.githubusercontent.com/artsafin/nginx-php-fpm/master/conf/nginx/default-site.conf)) |
| /etc/nginx/conf.d/ |  | Additional nginx configuration files (*.conf) |
| /usr/local/etc/php/conf.d/php-docker-vars.ini | conf/php-docker-vars.ini | php.ini overrides |
| /usr/local/etc/php/conf.d/ |  | Additional php configuration files (*.ini) |
| /usr/local/etc/php-fpm.d/php-fpm-pool.conf | conf/php-fpm-pool.conf | php-fpm pool config |
| /usr/local/etc/php-fpm.conf |  | Default php-fpm config |

### Environment variables

The following variables can be used to alter the behaviour of the built image.

Variables can be passed in two ways:
- as `docker run ... -e 'NAME=VALUE' artsafin/nginx-php-fpm`
- using `environment` section of `docker-compose.yml` file:

```
...
    environment:
        - NAME=VALUE
...

```

| Name | Description | Default | Examples |
|---------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------|----------------------------------------------------------------------------------------------------------------------------------|
| WEBROOT | Document root for the default nginx site.<br>Applied only if the image is run with default nginx site configuration. | /app | `WEBROOT=/app/public` |
| XDEBUG_CONFIG | Configuration for Xdebug.<br>Though xdebug extension is installed, it is not enabled for performance reasons unless XDEBUG_CONFIG is set.<br>The contents of XDEBUG_CONFIG variable are read by the xdebug extension itself, see [Xdebug documentation](https://xdebug.org/docs/remote#starting) for more info. | not set | `XDEBUG_CONFIG=remote_enable=1 remote_connect_back=1` |
| PHP_EXT | A list of PHP extensions that will be installed in addition to the preinstalled extensions. See [this link](https://github.com/php/php-src/tree/PHP-7.1.12/ext) for valid extension names. | not set | `PHP_EXT=pcntl bcmath` |
| PHP_IDE_SERVER_NAME | Server name needed to enable debugging in IDE.<br> Applied only if XDEBUG_CONFIG is set.<br> Unless PHP_IDE_CONFIG is set, this variable will be used to produce `PHP_IDE_CONFIG='serverName=PHP_IDE_SERVER_NAME'` | docker | `PHP_IDE_SERVER_NAME=site` |

### Links
- [Github](https://github.com/artsafin/nginx-php-fpm)
- [Docker hub](https://registry.hub.docker.com/u/artsafin/nginx-php-fpm/)
- [https://github.com/richarvey/nginx-php-fpm](https://github.com/richarvey/nginx-php-fpm)
