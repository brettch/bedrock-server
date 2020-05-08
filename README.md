# Minecraft Dedicated Server.

## Introduction

This Docker image exists because I wanted a way to run the Windows version of the [Bedrock Dedicated Server](https://www.minecraft.net/en-us/download/server/bedrock/) on Linux.  Why would I want to do this?  Because the Linux version has [truly awful performance](https://bugs.mojang.com/browse/BDS-2574).

The image is based on [Element Zero](https://github.com/Element-0/ElementZero) which does most of the heavy lifting with regards to making it work on Linux.  It also provides mod support which I don't really need but it doesn't get in the way either.

Element Zero provides instructions for running in Docker but it has a number of manual installation steps.  This image automates those steps and makes it easier to mount worlds and config into the image with some well-placed symlinks.

## Usage

Create a docker-compose.yaml file with the following contents.  Modify `/path/to/my` with the location you want to persist config and world data.

```yaml
version: '2.1'

services:
  minecraft:
    build: bretth/minecraft-bedrock-zero
    ports:
      - "19132:19132/udp"
    restart: always
    # allow attaching to container
    tty: true
    stdin_open: true
    volumes:
    - /path/to/my/config:/data/config
    - /path/to/my/worlds:/data/worlds
```

In the `/path/to/my/config` folder, place your `server.properties`, `whitelist.json`, and `permissions.json` files.  Original copies of these files can be found in the vanilla [Bedrock Dedicated Server Download](https://www.minecraft.net/en-us/download/server/bedrock/).  The files and directories must be owned by a user:group of 1000:1000.  This is a limitation of the base image that this image builds on.

Start the server via docker compose.

```bash
docker-compose up -d
```

Stop the server via docker compose.

```bash
docker-compose down
```


Attach to the running process for the purposes of running commands.

```bash
docker attach <container-id>
```

To detach from the process without exiting the container, use `Ctrl + p`, `Ctrl + q`.
