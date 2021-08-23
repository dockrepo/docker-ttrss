#!/bin/sh

echo "Start Running...";
cat /__version__

sed -i "s/initialize.php/initialize.php \&\& sh \/add_custom_config\.sh/" /docker-entrypoint.sh
# sed -e "s/initialize.php/initialize.php \&\& sh \/add_custom_config\.sh/" /docker-entrypoint.sh

sh /docker-entrypoint.sh