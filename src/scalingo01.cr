require "http/server"
require "option_parser"
require "ecr/macros"

bind = "0.0.0.0"
port = 3000

OptionParser.parse do |opts|
  opts.on("-p PORT", "--port PORT", "define port to run server") do |opt|
    port = opt.to_i
  end
end

server = HTTP::Server.new do |context|
  context.response.content_type = "text/html"
  io = IO::Memory.new
  ECR.embed "tpl/home.ecr", io
  context.response << io.to_s
end

address = server.bind_tcp bind, port
puts "Listening on http://#{address}"
server.listen
