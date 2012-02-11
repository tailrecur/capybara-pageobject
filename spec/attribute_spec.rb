require 'spec_helper'

describe "Attribute" do
  before(:each) do
    capybara_page.visit("/form")
  end

  describe "read value" do
    it "should read text value if attribute is a non-form field" do
      attribute = Capybara::PageObject::Attribute.new(capybara_page, "attr1", "#foo1")
      capybara_page.visit("/form")
      attribute.should == "led zeppelin"
    end

    it "should read value if attribute is a form field" do
      attribute = Capybara::PageObject::Attribute.new(capybara_page, "field1", "#bar1")
      capybara_page.visit("/form")
      attribute.should == "Creedence Rlearwater Revival"
    end
  end

  describe "delegators" do
    let(:attribute) { Capybara::PageObject::Attribute.new(capybara_page, "field1", "#bar1") }
    subject { attribute }
    it { should delegate(:include?).to(:element_value) }
    it { should delegate(:blank?).to(:element_value) }
    it { should delegate(:==).to(:element_value) }
    it { should delegate(:to_s).to(:element_value) }
    it { should delegate(:set).to(:element).with_arguments("foo.bar") }
  end
end