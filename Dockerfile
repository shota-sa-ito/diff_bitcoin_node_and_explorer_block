FROM ruby:2.6.0

# timezone変更
RUN rm /etc/localtime
RUN echo Asia/Tokyo > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

WORKDIR /usr/src

# rubyの設定
COPY Gemfile Gemfile.lock ./

RUN bundle install

ENV LANG C.UTF-8

COPY . .

# slackの接続先
ENV SLACK_WEBHOOK_URL "https://hooks.slack.com/services/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"

# crondの設定
COPY crontab /var/spool/cron/crontabs/root
RUN apt-get update && apt-get -y install busybox-static
CMD busybox crond -l 2 -L /dev/stderr -f