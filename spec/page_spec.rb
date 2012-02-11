require 'spec_helper'

describe "Page" do
  let(:page_data) { {"attributes" => {"attr1" => "#foo1", "attr2" => "#foo2"}} }
  
  describe "generated getters and setters" do
    before(:each) do
      Capybara.register_driver :schmoo do |app|
        Capybara::RackTest::Driver.new(app)
      end
      @capybara_page = Capybara::Session.new(:schmoo, TestWebsite)
      @page = Capybara::PageObject::Page.new @capybara_page, page_data
      @capybara_page.visit("/")
    end

    it "should create a getter for each attribute on the page" do
      @page.attr1.should == "led zeppelin"
      @page.attr2.should == "the doors"
    end

    #it "should create a setter for each attribute on the page" do
    #  capybara_page = mock()
    #  capybara_page.expects(:find).with("foo").returns(mock(:set => "foo1"))
    #
    #  page = Capybara::PageObject::Page.new capybara_page, page_data
    #
    #  page.attr1 = "foo2"
    #end
  end
end