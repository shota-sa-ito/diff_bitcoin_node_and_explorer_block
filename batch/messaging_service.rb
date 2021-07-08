require 'bundler'
Bundler.require

class MessagingService
  attr_reader :client

  # 環境SLACK_WEBHOOK_URLにwebhook urlを格納
  WEBHOOK_URL = ENV['SLACK_WEBHOOK_URL']
  CHANNEL = "#test"
  USER_NAME = "test"

  def initialize(webhook_url=WEBHOOK_URL , channel=CHANNEL, user_name=USER_NAME)
    @notifier = Slack::Notifier.new webhook_url, channel: channel,
                                              username: user_name
  end

  def send(message)
    @notifier.ping(message)
  end
end