FROM ruby:alpine

RUN apk update && apk add build-base git nodejs postgresql-dev postgresql-client

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs

COPY . .

RUN bundle exec rake assets:precompile

CMD sh wait-for-postgres.sh && \
  bundle exec rake db:create && \
  bundle exec rake db:migrate && \
  bundle exec puma -p 3000
