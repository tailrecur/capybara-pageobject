require 'spec_helper'


describe "Element" do
  before(:each) do
    capybara_page.visit("/form")
  end

  def element(selector)
    Capybara::PageObject::Element.new(capybara_page, "attr", selector)
  end

  describe "visible?" do
    context "attribute" do
      it { element("#attr1").should be_visible }
      it { element("#hidden_attr").should_not be_visible }
      it { element("#does_not_exist").should_not be_visible }
    end

    context "field" do
      it { element("#field1").should be_visible }
      it { element("#hidden_field").should_not be_visible }
      it { element("#does_not_exist").should_not be_visible }
    end
  end
end