module Merb::Helpers::SexyForm
  module Builder
    class Base < Merb::Helpers::Form::Builder::ResourcefulFormWithErrors
      def form(attrs = {}, &blk)
        ul_options = attrs.delete(:ul)
        super(attrs) do
          captured = @origin.capture(&blk)
          tag(:ul, captured, ul_options)
        end
      end

      def wrap_with_container(attrs = {}, content = "")
        li = attrs.delete(:li)
        container = attrs.delete(:container)

        first = attrs.delete(:first)
        method = attrs.delete(:method)

        if first && (attrs[:id] || method)
          if method
            id = method ? "#{@name}_#{method}" : attrs[:id]
          end
          label_id = "#{id}_#{first[:value]}"
        else
          label_id = attrs[:id]
        end

        label = attrs.delete(:label)
        if label && !label.is_a?(Hash)
          label = {:label => {:title => label}}
        end
        if label.is_a?(Hash)
          label[:label].merge!({:class => "main", :for => label_id})
        end
        label = label(label)

        if container == false
          content = label + content
        else
          content = label + tag(:div, content, container)
        end

        if li == false
          content
        else
          li = li || {}
          li.merge!(:id => "#{attrs[:id]}_container") if attrs[:id] and li[:id].blank?
          tag(:li, content, li)
        end
      end

      %w(text password file).each do |kind|
        self.class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def unbound_#{kind}_field(attrs = {})
            label = attrs.delete(:label)
            wrap_with_container(attrs.merge(:label => label), super(clean_args!(attrs)))
          end
        RUBY
      end

      def unbound_check_box(attrs = {})
        wrap_with_container(attrs.merge(:label => nil), super(clean_args!(attrs)))
      end

      def unbound_radio_button(attrs = {})
        wrap_with_container(attrs.merge(:label => nil), super(clean_args!(attrs)))
      end

      def bound_radio_group(method, arr, global_attrs = {})
        first = arr.first
        wrap_with_container(global_attrs.merge(:first => first, :method => method), super(method, arr))
      end

      def unbound_radio_group(arr, global_attrs = {})
        wrap_with_container(global_attrs, super(arr))
      end

      def unbound_select(attrs = {})
        wrap_with_container(attrs, super(clean_args!(attrs)))
      end

      def unbound_text_area(contents, attrs = {})
        label = attrs.delete(:label)
        wrap_with_container(attrs.merge(:label => label), super(clean_args!(attrs)))
      end

      def button(contents, attrs = {})
        wrap_with_container(attrs, super(contents, clean_args!(attrs)))
      end

      def submit(value, attrs = {})
        wrap_with_container(attrs, super(value, clean_args!(attrs)))
      end

      private
      def clean_args!(attrs)
        new_attrs = attrs.dup
        new_attrs.delete(:li)
        new_attrs.delete(:container)
        new_attrs
      end

      def radio_group_item(method, attrs)
        attrs.merge!(:checked => "checked") if attrs[:checked]
        attrs[:li] = false
        attrs[:container] = false
        super
      end

      def process_form_attrs(attrs)
        attrs[:id] = "#{@name}" unless attrs[:id] || @name.nil?

        if (@obj.respond_to?(:new_record?) && !@obj.new_record?) || (@obj.respond_to?(:new?) && !@obj.new?)
          add_css_class(attrs, "edit")
        else
          add_css_class(attrs, "new")
        end
        super(attrs)
      end
    end
  end
end