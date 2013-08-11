require "sinatra"
require 'sinatra-websocket'
require "file-tail"
require 'yaml'

set :server, 'thin'
set :sockets, []

set :logmap, YAML.load_file("map.yml") || {}

def tail(filename, ws)
  File.open(settings.logmap[filename]) do |log|
    log.extend(File::Tail)
    log.interval = 10
    log.tail { |line| ws.send(line) }
  end
end

def allowed?(filename)
  settings.logmap.has_key?(filename)
end

get '/show/:name' do

  @log_name = params[:name]

  if allowed?(@log_name) && request.websocket?

    request.websocket do |ws|

      ws.onopen do
        settings.sockets.push(ws)
        tail(@log_name, ws)
      end

      ws.onmessage do |msg|
         # nop
      end

      ws.onclose do
        settings.sockets.delete(ws)
      end

    end

  else
    erb :no_log
  end

end


get '/log/:name' do

  @log_name = params[:name]
  if allowed?(@log_name)
    erb :log
  else
    erb :no_log
  end

end

get '/' do
  erb :no_log
end

