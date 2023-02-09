FROM ruby:2.6.8
LABEL maintainer="Stefan Eilers <se@intelligentmobiles.com>"


ENV RAILS_ROOT /usr/src/app
ENV RAILS_ENV production
ENV PORT 80
# TODO: Set admin password via environment variable..
# This is set via Kubernetes Deployment description: ENV RETHINKDB_HOST=admin:rethinkdb@rethinkdb-rethinkdb-proxy
# ENV BUNDLER_VERSION 2.1.4

# Set working directory, where the commands will be ran:
WORKDIR $RAILS_ROOT

RUN apt-get update
RUN apt-get install -y imagemagick
RUN apt-get install -y nginx passenger #libnginx-mod-http-passenger

RUN apt-get --assume-yes install apt-transport-https
RUN apt-get --assume-yes install nodejs

COPY Gemfile .

RUN gem install bundler
RUN bundle config set without 'test development'
RUN bundle install
COPY . .

RUN rails assets:precompile


EXPOSE 80 443

CMD ./docker_startup.sh