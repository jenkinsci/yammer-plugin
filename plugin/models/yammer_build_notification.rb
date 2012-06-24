require_relative 'yammer'
include Java
java_import org.jenkinsci.plugins.tokenmacro.TokenMacro

class YammerBuildNotification

  def initialize(build, listener, yammer_notification)
    @build = build
    @listener = listener
    @yammer_notification = yammer_notification
  end

  def should_send_notification?
    (success? && @yammer_notification.send_success_notifications) || (!success? && @yammer_notification.send_failure_notifications)
  end

  def send_notification
    message = success? ? success_message : failure_message
    group_id = success? ? success_group_id : failure_group_id
    yammer = Yammer.new client_key, client_secret, token_key, token_secret
    yammer.send_message message, group_id
  end

  private

  [:client_key, :client_secret, :token_key, :token_secret, :success_message, :success_group_id, :failure_message, :failure_group_id].each do |field|
    define_method(field) { expand_all field }
  end

  def expand_all(field)
    TokenMacro.expandAll @build.native, @listener.native, @yammer_notification.instance_variable_get("@#{field}")
  end

  def success?
    @build.native.getResult.to_s == 'SUCCESS'
  end

end