#!/usr/bin/env bash

set -xe

# Install wordpress
if ! wp core is-installed
then
    wp core install \
        --url="https://spirithunt.win" \
        --title="Spirit Hunt"
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
