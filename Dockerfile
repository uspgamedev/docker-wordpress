FROM wordpress
ADD custom_entrypoint.sh /custom_entrypoint.sh
ENTRYPOINT ["/custom_entrypoint.sh"]