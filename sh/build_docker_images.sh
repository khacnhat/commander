#!/bin/bash
set -e

readonly CONTEXT_DIR="$( cd "$( dirname "${0}" )" && cd .. && pwd )"

docker build \
  --tag=khacnhat/commander-dojo \
  --file="${CONTEXT_DIR}/Dockerfile" \
  "${CONTEXT_DIR}"
