#!/usr/bin/env bash

# Get current dir
DIR=$(cd "$(dirname "$0")" && pwd)

# Go verbose
set -xe

# Install dependencies
composer global require wp-cli/wp-cli aaemnnosttv/wp-cli-dotenv-command

# Move to dir
cd "${DIR}"

# Create env file
if [ ! -f "${DIR}/.env" ]
then
    # Copy .env.example to .env
    cp "${DIR}/.env.example" "${DIR}/.env"
fi

# Create dotenv
wp dotenv salts regenerate

