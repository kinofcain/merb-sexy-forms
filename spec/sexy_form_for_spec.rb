require File.dirname(__FILE__) + '/spec_helper'

describe "sexy_form_for" do

  before :each do
    @c = SexyFormForSpecs.new(Merb::Request.new({}))
    @c.instance_variable_set(:@obj, FakeModel.new)
    @container = Merb::Plugins.config[:merb_sexy_forms][:container_tag]
  end

  it "should allow to pass block to any field and set hash contents inside" do
    ret = @c.render(:blocks)
    ret.should have_selector("form input[type=text].text_class")
    ret.should have_selector("form input[type=submit].submit_class")
    ret.should have_selector("form button.button_class")
    ret.should have_selector("form input[type=radio].radio_class")
    ret.should have_selector("form input[type=checkbox].checkbox_class")
    ret.should have_selector("form select.select_class")
    ret.should have_selector("form textarea.textarea_class")
  end

  it "should insert some html after and before field" do
    ret = @c.render(:before_after_field)
    ret.should have_selector("form span.before")
    ret.should have_selector("form span.after")

    ret.should_not have_selector("*[after], *[before]")
  end

  it "should append attributes to field" do
    ret = @c.render(:append_attributes)
    ret.should have_selector("form input#id.class")
  end

  it "should not add options attrs" do
    ret = @c.render(:additional_options)
    ret.should_not have_selector("*[container], *[ul], *[wrapper]")
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

  it "should generate main labels if label option is provided" do
    ret = @c.render(:basic)
    ret.should have_selector("label.main[for=fake_model_foo]")
  end

  it "should generate textarea with given text" do
    ret = @c.render(:textarea)
    ret.should =~ /foowee/
    ret.should have_selector("form textarea")
  end

  it "should add label for select only once" do
    ret = @c.render(:select)
    @c.instance_variable_set(:@collection, [FakeModel.new, FakeModel.new(2)])
    ret.should_not have_selector("form div.field label")
    ret.should have_selector("form label.main")
  end

  it "should add field and wrapper classes to field div" do
    ret = @c.render(:basic)
    ret.should have_selector("form div.field.wrapper")
  end

  it "should add container class to container" do
    ret = @c.render(:basic)
    ret.should have_selector("form div.container#fake_model_foo_container")
  end
end


