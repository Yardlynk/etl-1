require 'slack-notifier'

module ETL::Slack
  class Notifier 
    attr_accessor :attachments
    def initialize(webhook_url, channel, username)
      @notifier = Slack::Notifier.new(webhook_url, channel: channel, username: username)
      @attachments = []
    end

    def notify(message, icon_emoji: ":beetle:", attachments: @attachments)
      @notifier.ping message, icon_emoji: icon_emoji, attachments: attachments
    end

    def add_text_to_attachments(txt) 
      if @attachments.empty?
        @attachments = [{ "text": txt }] 
      else
        if @attachments[0].include? :text
          @attachments[0][:text] += "\n" + txt
        else
          @attachments[0][:text] = txt
        end
      end
    end
  end
end