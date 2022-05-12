# Travel The World

## Needed dependencies

1. Ruby 3
1. NodeJS (latest stable)
1. PostgreSQL (latest)
1. Redis (latest)

## Create database

`rails db:create`

## Start development server

`bin/dev`

### Local development in Docker

One can spin up a complete development environment in Docker Compose. With VSCode or RubyMine there
is an option to connect into this environment via remote interpreter option. This setup syncs your
local project folder with the one in Docker environment, which means one shouldn't rebuild image
each time code changes (but one must do that when Gemfiles are updated).

To build the environment (feel free to set up aliases in case you work a lot with this repo):

```bash
docker-compose -f docker-compose.dev.yml build
```

To start Rails development server:

```bash
docker-compose -f docker-compose.dev.yml up
```

To run tests:

```bash
docker-compose -f docker-compose.dev.yml run app test
```

To run Bash shell:

```bash
docker-compose -f docker-compose.dev.yml run app shell
```

To start Rails console:

```bash
docker-compose -f docker-compose.dev.yml run app console
```

To stop development server and clean up everything:

```bash
docker-compose -f docker-compose.dev.yml down --remove-orphans
```
