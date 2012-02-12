require "spec_helper"

describe "Capybara::PageObject" do
  describe "current_website" do
    it "should pass page file to the website constructor" do
      Capybara::PageObject.page_file = "foo.bar"
      YAML.expects(:load_file).with('foo.bar').returns({})
      Capybara::PageObject.current_website
    end

    it "should memoize website object" do
      Capybara::PageObject.current_website.should be_equal Capybara::PageObject.current_website
      Capybara::PageObject.current_website.should be_equal Capybara::PageObject.current_website
    end
  end

  describe "website_class" do
    before {
      Capybara::PageObject.page_file = "blah"
      YAML.stubs(:load_file).returns({})
    }

    it "should fail if website_class does not extend Website" do
      expect { Capybara::PageObject.website_class = Object }.to raise_error(Exception, "website class Object should extend Capybara::PageObject::Website")
    end

    it "should instantiate website class if provided" do
      class StubWebsite < Capybara::PageObject::Website
      end
      Capybara::PageObject.website_class = StubWebsite
      Capybara::PageObject.current_website.class.should == StubWebsite
    end

    it "should create website method in including class" do
      website.should be
    end
  end
end