require 'spec_helper'

describe "Page" do
  let(:page_data) { {"attributes" => {
      "attr1" => "#attr1",
      "attr2" => "#hidden_attr",
      "field1" => "#field1",
      "field2" => "#hidden_field"
  }} }

  describe "generated getters and setters" do
    before(:each) do
      @page = Capybara::PageObject::Page.new @capybara_page, page_data
      capybara_page.visit("/form")
    end
    let(:page) { @page }
    subject { page }
    its(:attr1) { should == "led zeppelin" }
    its(:attr2) { should == "the doors" }

    it "should be able to use getter to also set attribute value" do
      page.field1 "some_value"
      page.field1.should == "some_value"
    end
  end
end