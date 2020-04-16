FROM ruby:2.6-alpine

RUN apk update && apk add \
	build-base \
	nodejs \
	tzdata

WORKDIR /app

COPY Gemfile* ./
RUN gem install bundler && bundle install

COPY . .

EXPOSE 3000

CMD [ "bundle", "exec", "rails", "s", "-p", "3000", "-b", "0.0.0.0" ]
