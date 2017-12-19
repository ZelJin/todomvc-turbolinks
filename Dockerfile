FROM ruby:alpine

RUN apk update && apk add build-base git nodejs postgresql-dev

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs

COPY . .

CMD bundle exec rake db:create && \
  bundle exec rake db:migrate && \
  bundle exec rails s -p ${PORT}
