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
end