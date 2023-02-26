module Messageable
  extend ActiveSupport::Concern

  included do
    def messages
      [*(defined?(sent_messages) ? sent_messages : []), *received_messages]
    end

    def messages_from(user)
      Message.find_by(sender: user, receiver: self)
    end
  end
end
