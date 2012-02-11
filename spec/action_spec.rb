require 'spec_helper'

describe "action" do
  def action(selector)
    Capybara::PageObject::Action.new(capybara_page, "action", selector)
  end

  before(:each) do
    capybara_page.visit("/form")
  end

  describe "delegators" do
    subject { action("#register_submit") }
    it { should delegate(:click).to(:element) }
  end

  it { action("#disabled_button").should be_disabled }
  it { action("#attr1").to_s.should == "'action: action'" }
end