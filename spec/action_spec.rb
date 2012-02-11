require 'spec_helper'

def action(selector)
  Capybara::PageObject::Action.new(capybara_page, "action", selector)
end

describe "action" do
  before(:each) do
    capybara_page.visit("/form")
  end

  describe "delegators" do
    subject { action("#register_submit") }
    it { should delegate(:click).to(:element) }
  end

  it { action("#disabled_button").should be_disabled }
end