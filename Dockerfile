FROM wordpress

RUN apt-get update \
    && apt-get install \
        patch \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ADD entrypoint.patch /entrypoint.patch
RUN patch /entrypoint.sh /entrypoint.patch

RUN mkdir /var/www/wp-content \
    && cp -a /usr/src/wordpress /var/www/wp-content

VOLUME ["/var/www/wp-content"]

ADD wp-content.conf /etc/apache2/conf-available/wp-content.conf
RUN a2enconf wp-content.conf
