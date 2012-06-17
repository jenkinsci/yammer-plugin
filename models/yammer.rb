require 'oauth'
require_relative 'buffered_io_patch'

class Yammer

  def initialize(client_key, client_secret, token_key, token_secret)
    check_required_fields client_key: client_key, client_secret: client_secret, token_key: token_key, token_secret: token_secret
    @client_key = client_key
    @client_secret = client_secret
    @token_key = token_key
    @token_secret = token_secret
  end

  def send_message(message, group_id)
    check_required_fields message: message, group_id: group_id
    consumer = OAuth::Consumer.new @client_key, @client_secret, :site => 'https://www.yammer.com'
    access_token = OAuth::AccessToken.from_hash consumer, :oauth_token => @token_key, :oauth_token_secret => @token_secret
    response = access_token.post 'https://www.yammer.com/api/v1/messages.json', {:body => message, :group_id => group_id}
    response.value
  end

  private

  def check_required_fields(fields)
    fields.each { |k, v| raise "#{k} cannot be blank." unless v.to_s.strip.length > 0 }
  end

end