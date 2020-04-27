FROM ruby:2.3.8

RUN apt-get update -qq && apt-get install -y build-essential

# for postgres
RUN apt-get install -y libpq-dev

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# for capybara-webkit
RUN apt-get install -y libqtwebkit4 libqt4-dev xvfb

# for a JS runtime
RUN curl https://deb.nodesource.com/setup_12.x | bash
RUN apt-get update && apt-get install -y nodejs

# # install yarn?
# RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
# RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# RUN apt-get update && apt-get install -y yarn

# localorbit rails app lives in /localorbit
ENV APP_HOME /localorbit
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# package installer caches are maintained in a /persistent virtual volume
ENV BUNDLE_PATH /persistent/bundle
RUN npm config set cache /persistent/npm
RUN npm config set cache /persistent/npm --global

# copy the host's ./rails app-directory into /localorbit on virtual container
ADD rails $APP_HOME

# install third-party dependencies
RUN bundle
RUN npm install
