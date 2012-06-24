require 'xmlrpc/client'

class Confluence

  def post(content, page, space, user, pass, server)
    confluence = XMLRPC::Client.new2 "https://#{user}:#{pass}@#{server}/rpc/xmlrpc"
    confluence.instance_variable_get(:@http).instance_variable_set(:@verify_mode, OpenSSL::SSL::VERIFY_NONE)
    confluence = confluence.proxy 'confluence1'
    page = confluence.getPage '', space, page
    page['content'] = content
    confluence.storePage '', page
  end

end