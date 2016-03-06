FROM wordpress

RUN apt-get update \
    && apt-get install \
        patch \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ADD entrypoint.patch /entrypoint.patch
RUN patch /entrypoint.sh /entrypoint.patch
