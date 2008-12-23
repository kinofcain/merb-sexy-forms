module Merb::Helpers::Form
  def sexy_form(attrs = {}, &blk)
    with_form_context_without_name(Merb::Helpers::SexyForm::Builder::Base) do
      current_form_context.form(attrs, &blk)
    end
  end

  def sexy_form_for(name, attrs = {}, &blk)
    with_form_context(name, Merb::Helpers::SexyForm::Builder::Base) do
      current_form_context.form(attrs, &blk)
    end
  end

  def with_form_context_without_name(builder)
    form_contexts.push((builder || self._default_builder).new(nil, nil, self))
    ret = yield
    form_contexts.pop
    ret
  end

  # monkey patching - need to do something about it
  %w(text_field password_field hidden_field file_field
  text_area select check_box radio_button radio_group).each do |kind|
    self.class_eval <<-RUBY, __FILE__, __LINE__ + 1
      def #{kind}(*args, &blk)
        if bound?(*args)
          current_form_context.bound_#{kind}(*args, &blk)
        else
          current_form_context.unbound_#{kind}(*args, &blk)
        end
      end
    RUBY
  end

  def submit(contents, attrs = {}, &blk)
    current_form_context.submit(contents, attrs, &blk)
  end

  def button(contents, attrs = {}, &blk)
    current_form_context.button(contents, attrs, &blk)
  end
end
