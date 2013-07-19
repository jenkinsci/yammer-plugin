require_relative 'buffered_io_patch' # don't move this
require_relative 'yammer_notification_performer'

class YammerNotification < Jenkins::Tasks::Publisher

  attr_reader :access_token,
              :send_success_notifications, :success_message, :success_group_name,
              :send_failure_notifications, :failure_message, :failure_group_name,
              :config_file

  display_name 'Yammer Notification'

  def initialize(attrs)
    attrs.each { |k, v| instance_variable_set "@#{k}", v }
  end

  def perform(build, launcher, listener)
    performer = YammerNotificationPerformer.new self, build, listener
    performer.perform
  end

end