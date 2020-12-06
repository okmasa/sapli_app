FROM ruby:2.6.3 

#パッケージの取得
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       nodejs

# yarnパッケージ管理ツールインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs

RUN mkdir /sapli_app
WORKDIR /sapli_app

COPY Gemfile /sapli_app/Gemfile
COPY Gemfile.lock /sapli_app/Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY . /sapli_app

RUN mkdir -p tmp/sockets