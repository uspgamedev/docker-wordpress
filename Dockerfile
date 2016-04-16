FROM wordpress

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        patch \
        ssmtp \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /var/www/wp-content \
    && cp -a /usr/src/wordpress /var/www/wp-content

VOLUME ["/var/www/wp-content"]

# Add apache rules to redirect /wp-content
ADD wp-content.conf /etc/apache2/conf-available/wp-content.conf
RUN a2enconf wp-content.conf

# Apply our patches to the upstream entrypoint.sh
ADD entrypoint.patch /entrypoint.patch
RUN patch /entrypoint.sh /entrypoint.patch

