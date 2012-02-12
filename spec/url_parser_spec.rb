require "spec_helper"

describe "UrlParser" do
  describe "format" do
    it "should return url if it is static" do
      Capybara::PageObject::UrlParser.new("/users/1").format({}).should == "/users/1"
    end

    it "should raise error if dynamic url is called without params" do
      expect { Capybara::PageObject::UrlParser.new("/users/:id").format({}) }.to raise_error(Exception, 'Please pass url parameters: [:id]')
    end

    it "should raise error if number of parameters does not match" do
      expect { Capybara::PageObject::UrlParser.new("/users/:user_id/actions/:id").format({id: 1}) }.to raise_error(Exception, 'Please pass url parameters: [:user_id, :id]')
    end

    it "should raise error if parameter names don't match" do
      expect { Capybara::PageObject::UrlParser.new("/users/:user_id").format({id: 1}) }.to raise_error(Exception, 'Please pass url parameters: [:user_id]')
    end

    it "should substitute url parameters" do
      Capybara::PageObject::UrlParser.new("/users/:id").format({id: 2}).should == "/users/2"
    end

    it "should substitute multiple url parameters and ignore order" do
      Capybara::PageObject::UrlParser.new("/users/:user_id/actions/:id").format({id: 2, user_id: 3}).should == "/users/3/actions/2"
    end

    it { expect { Capybara::PageObject::UrlParser.new(nil) }.to raise_error(Exception, 'url is not defined') }
    it { expect { Capybara::PageObject::UrlParser.new("") }.to raise_error(Exception, 'url is not defined') }
  end
end