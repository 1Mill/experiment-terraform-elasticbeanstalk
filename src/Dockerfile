FROM ruby:2.6-alpine

RUN apk update && apk add \
	build-base \
	nodejs \
	postgresql-dev \
	tzdata

WORKDIR /app

COPY Gemfile* ./
RUN gem install bundler -v "~> 2.1.4" && bundle install

COPY . .

ENV DATABASE_HOST	${DATABASE_HOST}
ENV DATABASE_PASSWORD	${DATABASE_PASSWORD}
ENV DATABASE_PORT	${DATABASE_PORT}
ENV DATABASE_USERNAME	${DATABASE_USERNAME}

EXPOSE 3000

CMD [ "bundle", "exec", "rails", "s", "-p", "3000", "-b", "0.0.0.0" ]
