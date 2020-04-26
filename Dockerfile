# Dockerfile - Development environment
FROM ruby:2.7.0
MAINTAINER maqsood.ulde@gmail.com

ARG USER_ID
ARG GROUP_ID

RUN addgroup --gid $GROUP_ID user
RUN adduser --disabled-password --gecos '' --uid $USER_ID --gid $GROUP_ID user

ENV INSTALL_PATH /opt/app
RUN mkdir -p $INSTALL_PATH

# nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg -o /root/yarn-pubkey.gpg && apt-key add /root/yarn-pubkey.gpg
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y --no-install-recommends nodejs yarn vim nano

# rails
RUN gem install rails bundler
COPY portal/Gemfile Gemfile
WORKDIR /opt/app/portal
#RUN bundle install

COPY portal/bin/start /usr/bin/
RUN chmod +x /usr/bin/start
ENTRYPOINT ["start"]

RUN chown -R user:user /usr/local/
RUN chown -R user:user /opt/app/portal
USER user

VOLUME ["$INSTALL_PATH/public"]
CMD bundle exec unicorn -c config/unicorn.rb
