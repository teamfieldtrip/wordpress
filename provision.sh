#!/usr/bin/env bash

# Get verbose
set -xe

# Download WordPress
wp core download || true

# Install wordpress
if ! wp core is-installed
then
    if [ -z "$1" -o -z "$2" ]
    then
        echo Please specify admin username and e-mail as two arguments
        exit 255
    fi

    wp core install \
        --url="https://spirithunt.win" \
        --title="Spirit Hunt" \
        --admin_user="${1}" \
        --admin_email="${2}"
fi

# Options
wp option set blogtitle "Spirit Hunt"
wp option set blogdescription "The Game"

# Remove default plugins
wp plugin uninstall akismet --deactivate
wp plugin uninstall hello.php --deactivate

# Install plugins 
wp plugin install --activate jetpack
wp plugin install --activate use-any-font
wp plugin install --activate wordpress-seo

# Install themes
wp theme install --activate arcade-basic
wp theme install --activate argent

# Uninstall other themes
wp theme uninstall twentyfifteen
wp theme uninstall twentysixteen
wp theme uninstall twentyseventeen

# Apply rewrite rules, updates .htaccess
wp rewrite structure '/%postname%/'
wp rewrite flush --hard
