#!/bin/bash
set -o errexit
set -o errtrace
set -o nounset

source .env

wp() {
    docker-compose run --rm wordpress-cli \
        wp --url='http://127.0.0.1:8000' "${@}"
}

printf "\e[1m\e[7m %-80s\e[0m\n" 'WP CLI info'
wp --info
echo

printf "\e[1m\e[7m %-80s\e[0m\n" 'Install WordPress'
if [[ -n "${WP_ADMIN_EMAIL}" ]] && [[ -n "${WP_ADMIN_EMAIL}" ]] \
    && [[ -n "${WP_ADMIN_EMAIL}" ]]
then
    echo "       admin email: ${WP_ADMIN_EMAIL}"
    echo "        admin user: ${WP_ADMIN_USER}"
    echo "    admin password: ${WP_ADMIN_PASS}"
else
    echo 'The following variables must be set in .env (see .env.example):'
    echo '    WP_ADMIN_EMAIL'
    echo '    WP_ADMIN_USER'
    echo '    WP_ADMIN_PASS'
fi
echo
if wp --no-color --quiet core is-installed &> /dev/null
then
    echo 'no-op: already installed'
else
    wp core install \
        --title='CC Dev' \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASS}" \
        --skip-email
fi
echo

printf "\e[1m\e[7m %-80s\e[0m\n" 'Enable post name permalinks'
# The following complex command includes `cat` due to an apparent bug in
# macOS grep
if wp --no-color --quiet rewrite list 2> /dev/null | cat \
    | grep -qF 'No rewrite rules.'
then
    wp rewrite structure --hard '/%postname%'
else
    echo 'no-op: rewrite rules exist'
fi
echo

printf "\e[1m\e[7m %-80s\e[0m\n" 'Activate CC site plugin'
plugin='wp-plugin-creativecommons-website'
if wp --no-color --quiet plugin is-active "${plugin}" &> /dev/null
then
    echo "no-op: ${plugin} is already active"
else
    wp plugin activate "${plugin}"
fi
unset plugin
echo

printf "\e[1m\e[7m %-80s\e[0m\n" 'Install WordPress Importer plugin'
plugin='wordpress-importer'
if wp --no-color --quiet plugin is-active "${plugin}" &> /dev/null
then
    echo "no-op: ${plugin} is already installed & active"
else
    wp plugin install --activate "${plugin}"
fi
unset plugin
echo

printf "\e[1m\e[7m %-80s\e[0m\n" 'Activate creativecommons.org Child theme'
theme="wp-theme-creativecommons.org"
if wp --no-color --quiet theme is-active "${theme}" &> /dev/null
then
    echo "no-op: ${theme} is already active"
else
    echo "theme: ${theme}"
    wp theme activate "${theme}"
fi
unset theme
echo

printf "\e[1m\e[7m %-80s\e[0m\n" 'Import content'
# Test the first and last wp:post_id from import file
# - excluding attachments, which don't seem to work
# - this is fragile and will probably break if the import file is updated
# - troubleshoot with:
#       wp post-type list
#       wp post list --post_type=attachment,nav_menu_item,page \
#           --fields=ID,post_type,post_title,post_name,post_date,post_status
if wp --no-color --quiet post exists 63046 &> /dev/null \
    && wp post --no-color --quiet exists 63038 &> /dev/null
then
    echo 'no-op: posts from import already exist'
else
    wp import content-import/staging-content-import.xml --authors=create
fi
echo

printf "\e[1m\e[7m %-80s\e[0m\n" 'Assign menu locations'
if wp --no-color --quiet menu list 2> /dev/null | grep -F cc \
        | grep -qF main-navigation \
    && wp --no-color --quiet menu list 2> /dev/null | grep -F cc \
        | grep -qF main-menu-mobile
then
    echo 'no-op: menu locations already assigned'
else
    wp menu location assign cc main-navigation
    wp menu location assign cc main-menu-mobile
fi
echo

printf "\e[1m\e[7m %-80s\e[0m\n" \
    'Show maintenance mode status to expose any PHP Warnings'
wp maintenance-mode status
