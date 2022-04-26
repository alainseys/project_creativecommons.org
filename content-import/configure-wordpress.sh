#!/bin/bash
set -o errexit
set -o errtrace
set -o nounset

wpcli() {
    /usr/local/bin/wp --path=/var/www/html --url='http://127.0.0.1:8000' "${@}"
}

printf "\e[1m\e[7m %-80s\e[0m\n" 'WP CLI info'
wpcli --info
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
if wpcli --no-color --quiet core is-installed &> /dev/null
then
    echo 'no-op: already installed'
else
    wpcli core install \
        --title='CC Dev' \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASS}" \
        --skip-email
fi
echo

printf "\e[1m\e[7m %-80s\e[0m\n" 'Enable post name permalinks'
if wpcli --no-color --quiet rewrite list 2> /dev/null \
    | grep -qF 'page/?([0-9]{1,})/?$'
then
    echo 'no-op: rewrite rules exist'
else
    wpcli rewrite structure --hard '/%postname%'
fi
echo

printf "\e[1m\e[7m %-80s\e[0m\n" 'Activate CC site plugin'
plugin='wp-plugin-creativecommons-website'
if wpcli --no-color --quiet plugin is-active "${plugin}" &> /dev/null
then
    echo "no-op: ${plugin} is already active"
else
    wpcli plugin activate "${plugin}"
fi
unset plugin
echo

printf "\e[1m\e[7m %-80s\e[0m\n" 'Install WordPress Importer plugin'
plugin='wordpress-importer'
if wpcli --no-color --quiet plugin is-active "${plugin}" &> /dev/null
then
    echo "no-op: ${plugin} is already installed & active"
else
    wpcli plugin activate "${plugin}"
fi
unset plugin
echo

printf "\e[1m\e[7m %-80s\e[0m\n" 'Activate creativecommons.org Child theme'
theme="wp-theme-creativecommons.org"
if wpcli --no-color --quiet theme is-active "${theme}" &> /dev/null
then
    echo "no-op: ${theme} is already active"
else
    echo "theme: ${theme}"
    wpcli theme activate "${theme}"
fi
unset theme
echo

printf "\e[1m\e[7m %-80s\e[0m\n" 'Import content'
# Test for
# 1. about-cc category
# 2. CC Certificate page
# 2. Frequently Asked Questions page
#
# Troubleshoot with:
#       wpcli post list --post_type=attachment,nav_menu_item,page \
#           --fields=ID,post_type,post_title,post_name,post_date,post_status
if wpcli term get --by=slug category about-cc &> /dev/null \
    && wpcli post list --name=cc-certificate --post_type=page \
        | grep -qF 'CC Certificate' \
    && wpcli post list --name=faq --post_type=page \
        | grep -qF 'Frequently Asked Questions'
then
    echo 'no-op: content from import already exist'
else
    wpcli import content-import/staging-content-import.xml --authors=create
fi
echo

printf "\e[1m\e[7m %-80s\e[0m\n" 'Assign menu locations'
if wpcli --no-color --quiet menu list 2> /dev/null | grep -F cc \
        | grep -qF main-navigation \
    && wpcli --no-color --quiet menu list 2> /dev/null | grep -F cc \
        | grep -qF main-menu-mobile
then
    echo 'no-op: menu locations already assigned'
else
    wpcli menu location assign cc main-navigation
    wpcli menu location assign cc main-menu-mobile
fi
echo

printf "\e[1m\e[7m %-80s\e[0m\n" \
    'Show maintenance mode status to expose any PHP Warnings'
wpcli maintenance-mode status
