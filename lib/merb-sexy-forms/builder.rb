module Merb::Helpers::SexyForm
  module Builder
    class Base < Merb::Helpers::Form::Builder::ResourcefulFormWithErrors
      def form(attrs = {}, &blk)
        add_css_class(attrs, "sexy")
        super(attrs) do
          captured = @origin.capture(&blk)
          add_main_container(captured, attrs)
        end
      end

      def add_main_container(content, attrs)
        ul_options = attrs.delete(:ul)
        if Merb::Plugins.config[:merb_sexy_forms][:container_tag] == "li"
          tag(:ul, content, ul_options)
        else
          content
        end
      end

      def wrap_with_container(attrs = {}, content = "")
        content = add_html_to_field(content, attrs)
        content = add_field_wrapper(content, attrs)
        content = add_main_label(content, attrs)
        content = add_container(content, attrs)
      end


      %w(text password file).each do |kind|
        self.class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def unbound_#{kind}_field(attrs = {}, &blk)
            yield(attrs) if block_given?
            label = attrs.delete(:label)
            wrap_with_container(attrs.merge(:label => label), super(clean_args!(attrs)))
          end

          def bound_#{kind}_field(method, attrs = {}, &blk)
            yield(attrs) if block_given?
            super
          end
        RUBY
      end

      def unbound_check_box(attrs = {})
        yield(attrs) if block_given?
        update_label_options(attrs, "radio")
        wrap_with_container(attrs.merge(:label => nil),
            super(clean_args!(attrs)))
      end

      def bound_check_box(method, attrs = {}, &blk)
        yield(attrs) if block_given?
        super
      end

      def unbound_radio_button(attrs = {})
        yield(attrs) if block_given?
        update_label_options(attrs, "radio")
        wrap_with_container(attrs.merge(:label => nil),
            super(clean_args!(attrs)))
      end

      def bound_radio_button(method, attrs = {}, &blk)
        yield(attrs) if block_given?
        super
      end

      def bound_radio_group(method, arr, global_attrs = {})
        yield(attrs) if block_given?
        first = arr.first
        wrap_with_container(global_attrs.merge(:first => first, :method => method), super(method, arr))
      end

      def unbound_radio_group(arr, global_attrs = {})
        yield(attrs) if block_given?
        wrap_with_container(global_attrs, super(arr))
      end

      def unbound_select(attrs = {})
        yield(attrs) if block_given?
        wrap_with_container(attrs, super(clean_args!(attrs)))
      end

      def bound_select(method, attrs = {}, &blk)
        yield(attrs) if block_given?
        super
      end

      def unbound_text_area(contents, attrs = {})
        yield(attrs) if block_given?
        label = attrs.delete(:label)
        wrap_with_container(attrs.merge(:label => label), super(clean_args!(attrs)))
      end

      def bound_text_area(method, attrs = {}, &blk)
        yield(attrs) if block_given?
        super
      end

      def button(contents, attrs = {})
        yield(attrs) if block_given?
        wrap_with_container(attrs, super(contents, clean_args!(attrs)))
      end

      def submit(value, attrs = {})
        yield(attrs) if block_given?
        wrap_with_container(attrs, super(value, clean_args!(attrs)))
      end

      private
      def update_label_options(attrs, type)
        case type
        when "radio", "checkbox"
          if attrs[:label] && !attrs[:label].is_a?(Hash)
            attrs[:label] = {:title => attrs.delete(:label)}
            add_css_class(attrs[:label], "choice")
          end
        end
      end

      def clean_args!(attrs)
        new_attrs = attrs.dup
        new_attrs.delete(:wrapper)
        new_attrs.delete(:container)
        new_attrs.delete(:before)
        new_attrs.delete(:after)
        new_attrs
      end

      def radio_group_item(method, attrs)
        attrs.merge!(:checked => "checked") if attrs[:checked]
        attrs[:li] = false
        attrs[:container] = false
        super
      end

      def process_form_attrs(attrs)
        attrs[:id] = "#{@name}" unless attrs[:id] || @obj.nil?

        if @obj
          if (@obj.respond_to?(:new_record?) && !@obj.new_record?) || (@obj.respond_to?(:new?) && !@obj.new?)
            add_css_class(attrs, "edit")
          else
            add_css_class(attrs, "new")
          end
        end
        super(attrs)
      end

      def add_main_label(content, attrs)
        first = attrs.delete(:first)
        method = attrs.delete(:method)

        if first && (attrs[:id] || method)
          if method && @obj
            id = method ? "#{@name}_#{method}" : attrs[:id]
          end
          label_for = "#{id}_#{first[:value]}"
        else
          label_for = attrs[:id]
        end

        label = attrs.delete(:label)
        
        if label && !label.is_a?(Hash)
          label = {:label => {:title => label}}
        end

        if label.is_a?(Hash)
          label = label[:label]
          label.merge!({:class => "main", :for => label_for})
        end

        label = label(label)

        label + content
      end

      def add_container(content, attrs)
        container = attrs.delete(:container)

        if container == false
          content
        else
          container = container || {}
          container.merge!(:id => "#{attrs[:id]}_container") if attrs[:id] and container[:id].blank?
          container_tag = Merb::Plugins.config[:merb_sexy_forms][:container_tag]
          tag(container_tag, content, container)
        end
      end

      def add_field_wrapper(content, attrs)
        wrapper = attrs.delete(:wrapper)
        if wrapper == false
          content
        else
          tag(:div, content, wrapper)
        end
      end

      def add_html_to_field(content, attrs)
        before = attrs.delete(:before)
        after = attrs.delete(:after)

        if before
          content = before + content
        end
        if after
          content = content + after
        end
        content
      end
    end
  end
end
