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
end