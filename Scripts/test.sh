#!/usr/bin/env bash

set -exo pipefail

docker build -t titanurlencoded_test -f Dockerfile ./


set +e

docker run --rm  titanurlencoded_test \
  || (finish; set +x; echo -e "\033[0;31mTests exited with non-zero exit code\033[0m"; tput bel; exit 1 )
