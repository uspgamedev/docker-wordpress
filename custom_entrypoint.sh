#!/bin/bash

set -e

/entrypoint.sh

if ! grep -q WP_HOME wp-config.php; then
    mv wp-config.php wp-config_underwork.php
    awk '/^\/\*.*stop editing.*\*\/$/ && c == 0 { c = 1; system("cat") } { print }' wp-config_underwork.php > wp-config.php <<'EOPHP'
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO'])) {
	define('WP_HOME', $_SERVER['HTTP_X_FORWARDED_PROTO'] . '//' . $_SERVER['HTTP_HOST'] . $_SERVER['HTTP_X_PROXY_PATH']);
    define('WP_SITEURL', $_SERVER['HTTP_X_FORWARDED_PROTO'] . '//' . $_SERVER['HTTP_HOST'] . $_SERVER['HTTP_X_PROXY_PATH']);
}
EOPHP
	chown www-data:www-data wp-config.php
    rm wp-config_underwork.php
fi