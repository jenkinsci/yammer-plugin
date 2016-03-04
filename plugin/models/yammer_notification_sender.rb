require_relative 'yammer_http_client'

class YammerNotificationSender

  def initialize(build, listener, params)
    @build = build
    @listener = listener
    @params = params
    @yammer_http_client = YammerHttpClient.new(@params.access_token)
  end

  def should_send_notification?
    (success? && @params.success) || (!success? && @params.failure)
  end

  def send_notification
    @yammer_http_client.post_message(group_id , body)
  end

  private

  def success?
    @build.native.getResult.to_s == 'SUCCESS'
  end

  def body
    message_info.message
  end

  def group_id
    puts message_info.group
    @yammer_http_client.find_group_id_by_name(message_info.group)
  end

  def message_info
    @message_info ||= success? ? @params.success : @params.failure
  end

end
