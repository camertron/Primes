FROM ruby:3.0-alpine3.13

RUN apk add build-base

WORKDIR /opt/app
COPY *.rb .

ENTRYPOINT [ "ruby", "--jit", "--jit-wait", "prime.rb" ]