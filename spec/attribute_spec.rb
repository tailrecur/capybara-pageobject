require 'spec_helper'

describe "Attribute" do
  def attribute(selector)
    Capybara::PageObject::Attribute.new(capybara_page, "attr", selector)
  end

  before(:each) do
    capybara_page.visit("/form")
  end

  describe "read value" do
    it { attribute("#attr1").should == "led zeppelin" }
    it { attribute("#field1").should == "Creedence Rlearwater Revival" }
  end

  describe "delegators" do
    subject { attribute("#field1") }
    it { should delegate(:include?).to(:element_value) }
    it { should delegate(:blank?).to(:element_value) }
    it { should delegate(:==).to(:element_value) }
    it { should delegate(:set).to(:element).with_arguments("foo.bar") }
  end

  describe "validation_error" do
    it "should extract validation error from form" do
      capybara_page.visit("/form_with_rails_validation_errors")
      attribute("#user_email").validation_error.should == "can't be blank"
    end
  end

  it { attribute("#attr1").to_s.should == "'attribute: attr'" }
end