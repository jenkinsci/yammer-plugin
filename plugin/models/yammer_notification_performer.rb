require 'hashie'
require 'json'
require_relative 'yammer_notification_sender'
include Java
java_import org.jenkinsci.plugins.tokenmacro.TokenMacro

class YammerNotificationPerformer

  def initialize(task, build, listener)
    @task = task
    @build = build
    @listener = listener
  end

  def perform
    sender = YammerNotificationSender.new @build, @listener, params
    return unless sender.should_send_notification?
    @listener.info 'Sending Yammer notification...'
    begin
      sender.send_notification
      @listener.info 'Yammer notification sent.'
    rescue => e
      @listener.error ['An error occurred while sending the Yammer notification.', e.message, e.backtrace] * "\n"
    end
  end

  private

  [:access_token, :success_message, :success_group_name, :failure_message, :failure_group_name, :config_file].each do |field|
    define_method field do
      expand_field field
    end
  end

  def expand_field(field)
    puts "Using TokenMacro to expand field '#{field}'..."
    value = @task.instance_variable_get "@#{field}"
    puts "  Value: #{value}"
    expanded_value = TokenMacro.expandAll @build.native, @listener.native, value
    puts "  Expanded value: #{expanded_value}"
    expanded_value
  end

  def params
    p = Hashie::Mash.new
    p[:access_token] = access_token
    p[:success] = {message: success_message, group: success_group_name} if @task.send_success_notifications
    p[:failure] = {message: failure_message, group: failure_group_name} if @task.send_failure_notifications
    p.merge! params_from_file if params_file_exists?
    p
  end

  def params_from_file
    hash = JSON.parse params_file_contents
    Hashie::Mash.new hash
  end

  def params_file_exists?
    config_file && File.exist?(params_file)
  end

  def params_file_contents
    File.read params_file
  end

  def params_file
    File.join workspace_path, config_file
  end

  def workspace_path
    @build.workspace.to_s
  end

end