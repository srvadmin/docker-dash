FROM ubuntu:17.04
MAINTAINER Sadykh Sadykhov <sadykh.sadykhov@ya.ru>

RUN groupadd -r dash && useradd -r -m -g dash dash

ENV DASHD_VERSION	0.12.2.2
RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends dirmngr gosu gpg wget \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \

    && wget https://www.dash.org/binaries/dashcore-$DASHD_VERSION-linux64.tar.gz --no-check-certificate \ 
    && tar -zvxf dashcore-$DASHD_VERSION-linux64.tar.gz \
    && mv *-[0-9].[0-9][0-9].*/bin/* /usr/bin

# create data directory
ENV DASH_DATA /data
RUN mkdir $DASH_DATA \
  && chown -R dash:dash $DASH_DATA \
  && ln -sfn $DASH_DATA	 /home/dash/.dashcore \
  && chown -h dash:dash /home/dash/.dashcore

VOLUME /data

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod a+x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# Listen for connections on <port> (default: 9999 or testnet: 19999)
EXPOSE 9999 19999

# Listen for JSON-RPC connections on <port> (default: 9998 or testnet: 19998)
# custom port for rpc
EXPOSE 8999 19998
