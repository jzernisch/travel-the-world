#!/bin/bash

# TODO: add dockerize and wait for Postgres and Redis containers to be ready

if [[ "$1" = "test" ]]; then
    echo -e "Creating, migration and seeding the database\n"
    env RAILS_ENV=test bin/rake db:create db:schema:load db:migrate

    echo -e "Running tests\n"
    rails test
elif [[ "$1" = "shell" ]]; then
    echo -e "Running shell\n"
    /bin/bash
elif [[ "$1" = "console" ]]; then
    echo -e "Running Rails console\n"
    bundle exec rails console
else
    if [ -f tmp/pids/server.pid ]; then
      rm tmp/pids/server.pid
    fi

    echo -e "Creating, migration and seeding the database\n"
    bin/rake db:create db:schema:load db:migrate db:seed_fu

    echo -e "Starting development server\n"
    bundle exec rails server -p 3000 -b 0.0.0.0
fi
