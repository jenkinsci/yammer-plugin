require 'net/protocol'
require 'timeout'

# http://jira.codehaus.org/browse/JRUBY-6511
class Net::BufferedIO
  def rbuf_fill
    if IO.select [@io], [@io], nil, @read_timeout
      @io.sysread BUFSIZE, @rbuf
    else
      raise Timeout::Error.new 'execution expired'
    end
  end
end