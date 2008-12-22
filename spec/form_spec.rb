require File.dirname(__FILE__) + '/spec_helper'

describe "form" do

  before :each do
    @c = SexyFormSpecs.new(Merb::Request.new({}))
    @container = Merb::Plugins.config[:merb_sexy_forms][:container_tag]
  end

  it "should add containers" do
    ret = @c.render(:basic)
    ret.should have_selector("form #{@container} > label")
  end

  it "should add ul if container tag is li" do
    Merb::Plugins.config[:merb_sexy_forms][:container_tag] = "li"
    ret = @c.render(:basic)
    ret.should have_selector("form > ul")
  end

  it "should'nt add ul if container tag is not li" do
    Merb::Plugins.config[:merb_sexy_forms][:container_tag] = "div"
    ret = @c.render(:basic)
    ret.should_not have_selector("form > ul")
  end

  it "should add labels with field nested in container" do
    ret = @c.render(:with_labels)
    ret.should have_selector("form #{@container} > label")
    ret.should have_selector("form #{@container} > div > input")
  end

  it "should add 'choice' class to labels for checkboxes or radio buttons" do
    ret = @c.render(:label_choice_class)
    ret.should have_selector("form div label[for=checkbox].choice")
    ret.should have_selector("form div label[for=radio].choice")
  end

  it "should not add 'choice' class to main labels with checkboxes or radio buttons" do
    ret = @c.render(:label_choice_class)
    ret.should_not have_selector("form label.choice.main")
  end
end
