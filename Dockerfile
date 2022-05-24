# Dockerfile only for development purposes
# Note: It is not a best practice to have multiple dockerfiles for different environments
FROM ruby:3.1.1

EXPOSE 3000

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    bash \
    git \
    nodejs \
    npm \
    postgresql-client \
    tzdata

RUN npm install --global yarn

WORKDIR /app

COPY Gemfile Gemfile.lock ./

# This bundler version should always match the version the Gemfile.lock is bundled with
RUN gem install bundler -v$(tail -n1 Gemfile.lock)

RUN bundle install

COPY . ./


