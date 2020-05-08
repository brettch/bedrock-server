FROM alpine:3.11.6 AS build

ARG bedrockVersion=1.14.60.5
ARG elementZeroVersion=200501

ENV bedrockVersion=${bedrockVersion}
ENV elementZeroVersion=${elementZeroVersion}

RUN apk --no-cache add \
    curl \
    | true

RUN mkdir bedrock-server
RUN curl https://minecraft.azureedge.net/bin-win/bedrock-server-${bedrockVersion}.zip --output bedrock-server.zip
RUN unzip bedrock-server.zip -d bedrock-server

RUN curl -L https://github.com/Element-0/ElementZero/releases/download/${elementZeroVersion}/pkg.tar.xz --output elementZero.tar.xz

RUN tar xvf elementZero.tar.xz -C bedrock-server --strip 1

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
