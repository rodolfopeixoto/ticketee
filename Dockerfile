FROM ruby:2.4.1
# ENV http_proxy "http://10.131.188.1:80" 
# ENV https_proxy "http://10.131.188.1:80"
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  xvfb \
  qt5-default \
  libqt5webkit5-dev \
  gstreamer1.0-plugins-base \
  gstreamer1.0-tools \
  gstreamer1.0-x

RUN apt-get install -yqq iceweasel

WORKDIR /ticketee 
COPY Gemfile* ./ 
RUN gem install capybara-webkit
RUN bundle install 
COPY . .
