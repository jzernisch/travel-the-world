#!/bin/bash
set -e

rm -f tmp/pids/server.pid

echo Preparing databases
bin/rails db:setup

echo Executing command $@
exec "$@"
