require 'sinatra/base'
require 'rack'
require 'yaml'

class TestWebsite < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :static, true

  get '/' do
<<-BODY
<html>
<body>
  <p>Hello World!!</p>
  <div id="foo1">led zeppelin</div>
  <div id="foo2">the doors</div>
</body>
</html>
BODY
  end

  get '/foo' do
    'Another World'
  end

  get '/redirect' do
    redirect '/redirect_again'
  end

  get '/redirect_again' do
    redirect '/landed'
  end

  get '/referer_base' do
    '<a href="/get_referer">direct link</a>' +
    '<a href="/redirect_to_get_referer">link via redirect</a>' +
    '<form action="/get_referer" method="get"><input type="submit"></form>'
  end
end

if __FILE__ == $0
  Rack::Handler::WEBrick.run TestWebsite, :Port => 8070
end
