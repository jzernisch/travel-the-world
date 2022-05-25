#!/bin/bash
set -e

rm -f tmp/pids/server.pid

echo Executing command $@
exec "$@"
