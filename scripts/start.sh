#!/bin/bash

if [[ -f $CONF_NGINX_SITE ]]; then
  WEBROOT=${WEBROOT:-/app}

  # Set webroot for a default site
  sed -i "s@##WEBROOT##@${WEBROOT}@g" $CONF_NGINX_SITE

  echo Webroot is set to ${WEBROOT} in ${CONF_NGINX_SITE}
  echo
fi

if [[ ! -z "$XDEBUG_CONFIG" ]]; then
  echo Enabling Xdebug

  if php -i | grep -i "xdebug support" > /dev/null; then
    echo Xdebug is already enabled, the following configuration will be applied: ${XDEBUG_CONFIG}
  else
    if docker-php-ext-enable xdebug; then
      echo Xdebug enabled, the following configuration will be applied: ${XDEBUG_CONFIG}
    else
      echo "Error enabling xdebug (docker-php-ext-enable xdebug failed)"
    fi
  fi

  if [[ -z "$PHP_IDE_CONFIG" ]]; then
    PHP_IDE_SERVER_NAME=${PHP_IDE_SERVER_NAME:-docker}
    
    echo Applying PHP_IDE_CONFIG with server name ${PHP_IDE_SERVER_NAME}
    export PHP_IDE_CONFIG="serverName=${PHP_IDE_SERVER_NAME}"
  fi

  echo
else
  echo "Skipping Xdebug configuration (pass XDEBUG_CONFIG environment variable to enable)"
  echo
fi

# Start supervisord and services
exec /usr/bin/supervisord -n -c $CONF_SUPERVISORD
