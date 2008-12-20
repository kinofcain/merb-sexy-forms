require File.dirname(__FILE__) + '/spec_helper'

Merb::Plugins.config[:helpers] = {
  :default_builder => Merb::Helpers::Form::Builder::FormWithErrors
}

describe "form" do

  before :each do
    @c = SexyFormSpecs.new(Merb::Request.new({}))
  end

  it "should add labels with field nested in container" do
    ret = @c.render(:with_labels)
    ret.should have_selector("form ul li label")
    ret.should have_selector("form ul li div input")
  end

  it "should add 'choice' class to labels for checkboxes or radio buttons" do
    ret = @c.render(:label_choice_class)
    ret.should have_selector("form div label[for=checkbox].choice")
    ret.should have_selector("form div label[for=radio].choice")
  end

  it "should not add 'choice' class to main labels" do
    ret = @c.render(:label_choice_class)
    ret.should_not have_selector("form label.choice.main")
  end
end