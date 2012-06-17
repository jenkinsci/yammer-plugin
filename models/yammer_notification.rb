require_relative 'yammer_build_notification'

class YammerNotification < Jenkins::Tasks::Publisher

  attr_reader :client_key, :client_secret, :token_key, :token_secret,
              :send_success_notifications, :success_message, :success_group_id,
              :send_failure_notifications, :failure_message, :failure_group_id

  display_name 'Yammer Notification'

  def initialize(attrs)
    attrs.each { |k, v| instance_variable_set "@#{k}", v }
  end

  def perform(build, launcher, listener)
    n = YammerBuildNotification.new build, listener, self
    return unless n.should_send_notification?
    listener.info 'Sending Yammer notification...'
    begin
      n.send_notification
      listener.info 'Yammer notification sent.'
    rescue => e
      listener.error ['An error occurred while sending the Yammer notification.', e.message, e.backtrace] * "\n"
    end
  end

end