FROM alpine:3.11.6 AS build

ARG bedrockVersion=1.14.60.5
ARG elementZeroVersion=200511

ENV bedrockVersion=${bedrockVersion}
ENV elementZeroVersion=${elementZeroVersion}

RUN apk --no-cache add \
    curl \
    zstd \
    | true

RUN mkdir bedrock-server
RUN curl --fail https://minecraft.azureedge.net/bin-win/bedrock-server-${bedrockVersion}.zip --output bedrock-server.zip
RUN unzip bedrock-server.zip -d bedrock-server

RUN curl -L --fail https://github.com/Element-0/ElementZero/releases/download/${elementZeroVersion}/ElementZero-${elementZeroVersion}-win64.tar.zst --output elementZero.tar.zst

RUN zstdcat elementZero.tar.zst | tar xvf - -C bedrock-server --strip-components 1

WORKDIR /bedrock-server

RUN mkdir config && \
    mv server.properties config && \
    mv permissions.json config && \
    mv whitelist.json config && \
    ln -s config/server.properties server.properties && \
    ln -s config/permissions.json permissions.json && \
    ln -s config/whitelist.json whitelist.json

FROM codehz/wine:bdlauncher-runtime

COPY --from=build /bedrock-server /data
