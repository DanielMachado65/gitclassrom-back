FROM ruby:2.6.5-stretch

EXPOSE 3000
# throw errors if Gemfile has been modified since Gemfile.lock
RUN apt-get update && apt-get install -y build-essential libpq-dev
RUN bundle config --delete frozen
WORKDIR /app
ADD Gemfile /app/Gemfile
COPY Gemfile /app/Gemfile.lock
COPY . /app
RUN bundle install --binstubs
