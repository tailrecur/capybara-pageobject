require 'sinatra/base'
require 'rack'
require 'yaml'

class TestWebsite < Sinatra::Base
  set :root, File.dirname(__FILE__)
  set :static, true

  def page_with
    <<-BODY
<html>
<body>
  <p>Hello World!!</p>
  #{yield}
</body>
</html>
    BODY
  end

  get '/' do
    page_with { '<div id="foo1">led zeppelin</div><div id="foo2">the doors</div>' }
  end

  get '/form' do
    page_with do
      <<-FORM
<div id="attr1">led zeppelin</div>
<div id="hidden_attr" style="display:none">the doors</div>
<form>
  <input type="text" id="field1" value="Creedence Rlearwater Revival"/>
  <input type="text" id="hidden_field" style="display:none"/>
<form>
      FORM
    end
  end

  get '/form_with_rails_validation_errors' do
    page_with do
      <<-FORM
<form accept-charset="UTF-8" action="/users" class="standard-form" id="registration-form" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" />
  <input name="authenticity_token" type="hidden" value="xi5eg4oEiv3mng8ISy0qyYf/nB49pv0heJ93h3SrNtE=" /></div>
    <ol>
        <li class="text">
            <div class="field_with_errors"><label for="user_email">Email Address</label></div>
            <div class="field_with_errors"><input id="user_email" name="user[email]" size="30" title="Will be used as your username" type="text" value="" /><span class="error_message">can't be blank</span></div>
						<span class="required">*</span>
        </li>
        <li class="text">
            <div class="field_with_errors"><label for="user_password">Password</label></div>
            <div class="field_with_errors"><input id="user_password" name="user[password]" size="30" title="At least 8 characters" type="password" /><span class="error_message">doesn't match confirmation</span></div><span class="required">*</span>
        </li>
        <li class="submit"><input id="register_submit" name="commit" type="submit" value="Register" /></li>
    </ol>
</form>
      FORM
    end
  end
end

if __FILE__ == $0
  Rack::Handler::WEBrick.run TestWebsite, :Port => 8070
end
