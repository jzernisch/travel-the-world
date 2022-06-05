#!/bin/bash
set -e

HIGHLIGHT_COLOR='\033[1;35m'
NO_COLOR='\033[0m'

rm -f tmp/pids/server.pid

echo -e Executing command${HIGHLIGHT_COLOR} $@${NO_COLOR}
exec "$@"
