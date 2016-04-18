#/bin/bash
sed -i -e s/PHP_VERSION/${PHP_VERSION}/g module.yaml
sed -i -e s/PHP_VERSION/${PHP_VERSION}/g fpm/module.yaml
sed -i -e s/PHP_VERSION/${PHP_VERSION}/g wheezy/module.yaml
sed -i -e s/PHP_VERSION/${PHP_VERSION}/g wheezy/fpm/module.yaml
DR="--rm=true --pull=true --force-rm=true --no-cache=true"
PHP_FPM=true
if [[ "$PHP_FPM" = "true" ]]; then
    PHP_COMB="$PHP_VERSION-fpm"
else
    PHP_COMB="$PHP_VERSION"
fi;
if [[ $PHP_VERSION = '5.5' ]]; then
    if [[ "$PHP_FPM" = "true" ]]; then
        docker build $DR --tag=mygento/php:$PHP_VERSION-fpm wheezy/fpm
    else
        docker build $DR --tag=mygento/php:$PHP_VERSION wheezy
    fi;
fi;
if [[ $PHP_VERSION != '5.5' ]]; then
    if [[ "$PHP_FPM" = "true" ]]; then
        docker build $DR --tag=mygento/php:$PHP_VERSION-fpm fpm
    else
        docker build $DR --tag=mygento/php:$PHP_VERSION .
    fi
fi
