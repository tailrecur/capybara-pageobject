require "spec_helper"

describe "Website" do
  let(:website) { Capybara::PageObject::Website.new(capybara_page) }
  subject { website }

  describe "create getters" do
    before { YAML.expects(:load_file).with('pages/pages.yml').returns({"home_page" => {}, "login_form" => {}}) }
    it { should respond_to :home_page }
    it { should respond_to :login_form }

    its(:home_page) { should be }
    its(:login_form) { should be }

    it "should pass page name in page_data hash" do
      website.home_page.instance_variable_get(:@page_data)["name"].should == "home_page"
    end
  end

  describe "custom page class" do
    it "should instantiate custom class if specified" do
      class CustomPage < Capybara::PageObject::Page; end
      YAML.expects(:load_file).with('pages/pages.yml').returns({"home_page" => {"class" => "CustomPage"}})
      website.home_page.class.should == CustomPage
    end

    it "should fail if custom class does not extend Page class" do
      YAML.expects(:load_file).with('pages/pages.yml').returns({"home_page" => {"class" => "Object"}})
      expect { Capybara::PageObject::Website.new(capybara_page) }.to raise_error(Exception, "Custom page class 'Object' should extend Capybara::PageObject::Page")
    end
  end
end