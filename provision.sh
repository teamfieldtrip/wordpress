#!/usr/bin/env bash

if [ -z "$1" ]
then
    echo Please specify admin username as first argument
    exit 255
fi

if [ -z "$2" ]
then
    echo Please specify admin e-mail as second argument
    exit 255
fi

# Get verbose
set -xe

# Download WordPress
wp core download

# Install wordpress
if ! wp core is-installed
then
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

# Install vendor plugins
wp plugin install --activate wp-seo
wp plugin install --activate google-tag-manager

# Apply rewrite rules, updates .htaccess
wp rewrite structure '/%postname%/'
wp rewrite flush --hard
