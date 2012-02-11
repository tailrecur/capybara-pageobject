require "spec_helper"

def with_yaml page_data
  YAML.expects(:load_file).with('pages/pages.yml').returns(page_data)
end

describe "Website" do
  let(:website) { Capybara::PageObject::Website.new(capybara_page, self) }
  subject { website }

  describe "create getters" do
    before { with_yaml("home_page" => {}, "login_form" => {}) }
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
      with_yaml("home_page" => {"class" => "CustomPage"})
      website.home_page.class.should == CustomPage
    end

    it "should fail if custom class does not extend Page class" do
      with_yaml("home_page" => {"class" => "Object"})
      expect { Capybara::PageObject::Website.new(capybara_page, self) }.to raise_error(Exception, "Custom page class 'Object' should extend Capybara::PageObject::Page")
    end
  end

  describe "page block" do
    it "should evaluate calls within the block on page" do
      with_yaml("home_page" => {"url" => "/form", "attributes" => {"attribute" => "#attr1", "field" => "#hidden_field"}})
      website.home_page.visit
      website.home_page do
        attribute.should == "led zeppelin"
        field.should_not be_visible
      end
    end
  end
end