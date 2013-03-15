require_relative 'buffered_io_patch'
require 'yam'
require 'yamwow'
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
    group_name = success? ? success_group_name : failure_group_name
    yam = Yam.new access_token, nil
    yam.post '/messages.json', :body => message, :group_id => group_id(group_name)
  end

  private

  [:access_token, :success_message, :success_group_name, :failure_message, :failure_group_name].each do |field|
    define_method(field) { expand_all field }
  end

  def expand_all(field)
    TokenMacro.expandAll @build.native, @listener.native, @yammer_notification.instance_variable_get("@#{field}")
  end

  def success?
    @build.native.getResult.to_s == 'SUCCESS'
  end

  def group_id(group_name)
    f = YamWow::Facade.new access_token
    r = f.group_with_name group_name
    raise "Yammer group '#{group_name}' does not exist." unless r.data
    r.data['id']
  end

end