require 'spec_helper'

def page_object(page_data)
  Capybara::PageObject::Page.new capybara_page, page_data
end

describe "Page" do
  describe "on form page" do
    let(:page_data) { {
        "url" => "/form",
        "attributes" => {
            "attr1" => "#attr1",
            "attr2" => "#hidden_attr",
            "field1" => "#field1",
            "field2" => "#hidden_field"
        },
        "actions" => {
            "action1" => "#register_submit",
            "action2" => "#disabled_button",
        }
    } }

    before { capybara_page.visit("/form") }
    let(:page) { page_object(page_data) }
    subject { page }

    describe "attributes" do
      its(:attr1) { should == "led zeppelin" }
      its(:attr2) { should == "the doors" }

      it "should be able to use getter to also set attribute value" do
        page.field1 "some_value"
        page.field1.should == "some_value"
      end
    end

    describe "actions" do
      its(:action1) { should be_visible }
      its(:action2) { should be_disabled }
    end

    describe "responds_to" do
      it { should respond_to(:attr1) }
      it { should respond_to(:field1) }
      it { should respond_to(:action1) }
      it { should respond_to(:action2) }
    end
  end

  describe "visit" do
    it "should go to page mentioned in url" do
      page_object({"url" => "/form_with_rails_validation_errors"}).visit
      capybara_page.should have_content "Email Address"
    end

    it "should fail if url is not specified" do
      expect { page_object({}).visit }.to raise_error(Exception, "url not defined for page")
    end
  end

  describe "visible?" do
    it "should return true if id element is visible" do
      page = page_object({"url" => "/form_with_rails_validation_errors", "id" => "#registration-form"})
      page.visit
      page.should be_visible
    end

    it "should return false if id element is not present" do
      page = page_object({"url" => "/form_with_rails_validation_errors", "id" => "#does-not-exist"})
      page.visit
      page.should_not be_visible
    end

    it "should fail if id is not specified" do
      expect { page_object({}).visible? }.to raise_error(Exception, "id not defined for page")
    end
  end

  describe "page_title" do
    it "should return page title if page has title in head" do
      page = page_object({"url" => "/form"})
      page.visit
      page.page_title.should == "Classic Rock"
    end

    it "should return empty if title is not defined" do
      page = page_object({"url" => "/div"})
      page.visit
      page.page_title.should be_empty
    end
  end
end