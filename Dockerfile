FROM ruby:3.0.0
RUN apt-get update -qq && apt-get install -y nodejs libpq-dev postgresql-client
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .