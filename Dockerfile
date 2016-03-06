FROM wordpress
ADD entrypoint.patch /entrypoint.patch
RUN patch /entrypoint.sh /entrypoint.patch
