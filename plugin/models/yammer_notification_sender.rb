require 'yammer'


class YammerNotificationSender

  def initialize(build, listener, params)
    @build = build
    @listener = listener
    @params = params
  end

  def should_send_notification?
    (success? && @params.success) || (!success? && @params.failure)
  end

  def send_notification
    @yam = Yammer::Client.new(:access_token  => @params.access_token)
    @yam.create_message( body, :group_id => group_id )
  end

  private

  def success?
    @build.native.getResult.to_s == 'SUCCESS'
  end

  def body
    message_info.message
  end

  def group_id
    group_name = message_info.group
    #puts "Using YamWow! to retrieve ID for group named '#{group_name}'..."
    #f = YamWow::Facade.new @params.access_token
    #r = f.group_with_name group_name
    r = @yam.autocomplete(:prefix => group_name , :models => 'group:30')
    raise "  Yammer group '#{group_name}' does not exist." unless r.data
    id = r.data['group']['id']
    puts "  ID: #{id}"
    id
  end

  def message_info
    @message_info ||= success? ? @params.success : @params.failure
  end

end
