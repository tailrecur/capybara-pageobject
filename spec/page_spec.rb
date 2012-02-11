require 'spec_helper'

describe "Page" do
  let(:page_data) { {"attributes" => {
      "attr1" => "#foo1",
      "attr2" => "#foo2",
      "field1" => "#bar1",
      "field2" => "#bar2"
  }} }

  describe "generated getters and setters" do
    before(:each) do
      @page = Capybara::PageObject::Page.new @capybara_page, page_data

    end
    let(:page) { @page }

    it "should create a getter for each attribute on the page" do
      capybara_page.visit("/")
      page.attr1.should == "led zeppelin"
      page.attr2.should == "the doors"
    end

    it "should be able to use getter to also set attribute value" do
      capybara_page.visit("/form")
      page.field1 "some_value"
      page.field1.should == "some_value"
    end
  end
end