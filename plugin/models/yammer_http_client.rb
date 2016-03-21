require 'java'
require 'json'

import 'org.apache.commons.httpclient.HttpClient'
import 'org.apache.commons.httpclient.methods.PostMethod'
import 'org.apache.commons.httpclient.methods.GetMethod'


class YammerHttpClient

  def initialize(access_token)
    @client = HttpClient.new
    @base_url = 'https://www.yammer.com/api/v1/'
    @access_token = access_token
  end

  def post_message(group_id , body)
    messages_url = 'messages'
    post = PostMethod.new("#{@base_url}#{messages_url}" )
    post.add_parameter 'group_id', group_id.to_s
    post.add_parameter 'body', body
    post.set_request_header 'Authorization' ,"Bearer #{@access_token}"
    @client.execute_method post
    post.release_connection
    case post.status_code
    when 201
      return
    when 401
      raise "Unauthorized'"
    when 404
      raise "Not Found"
    else
      raise "#{post.status_code} not handled'"
    end
  end

  def find_group_id_by_name(name)
    autocomplete_url = "autocomplete/ranked?prefix=#{name}&models=group:20"
    get = GetMethod.new("#{@base_url}#{autocomplete_url}")
    get.set_request_header 'Authorization' ,"Bearer #{@access_token}"
    @client.execute_method get
    result = get.getResponseBody().to_s

    puts result
    json = JSON.parse(result)

    group_id =  json["group"].first["id"]
    get.release_connection
    case get.status_code
    when 200
      return group_id
    when 201
      return group_id
    when 202
      return group_id
    when 401
      raise "Unauthorized'"
    when 404
      raise "Not Found"
    else
      raise "#{get.status_code} not handled'"
    end
  end
end
