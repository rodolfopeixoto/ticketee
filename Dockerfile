FROM ruby:2.3.1 
ENV http_proxy "http://10.131.188.1:80" 
ENV https_proxy "http://10.131.188.1:80" 
RUN apt-get update -yqq \ 
  && apt-get install -yqq --no-install-recommends \ 
    postgresql-client \ 
    nodejs \ 
    qt5-default \ 
    libqt5webkit5-dev \ 
  && apt-get -q clean \ 
  && rm -rf /var/lib/apt/lists
 
WORKDIR /codemca 
COPY Gemfile* ./ 
RUN bundle install 
COPY . . 

