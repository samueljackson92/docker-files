#!/bin/sh

# Handles setting up the target user (abc) and redirecting the command to be
# executed by them.
# This is all in aid of ensuring that permissions of filesystem mapped volumes
# function correctly and that the root user is not used within the container.

set -x

PUID=${PUID:-1000}
PGID=${PGID:-1000}

TARGET_USERNAME="jovyan"
TARGET_GROUP="users"

# Set target user's IDs to match that of the "external"/"host" user
groupmod --non-unique --gid ${PGID} ${TARGET_GROUP}
usermod --non-unique --uid ${PUID} ${TARGET_USERNAME}

# Run the supplied command as the target user
CMD=${1:-"bash"}
ARGS=""
runuser --command="${CMD} ${ARGS}" - ${TARGET_USERNAME}
