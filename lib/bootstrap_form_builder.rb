# Generate Twitter Bootstrap-compatible forms.
class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  # Generate a text field for a form, with an associated label, contained in the
  # right markup to be styled with Twitter Bootstrap.
  [:text_field, :text_area, :select, :date_select].each do |selector|
    class_eval <<-RUBY, __FILE__, __LINE__
      def #{selector}(method, *args)
        options = args.extract_options!

        form_group do
          label(method) + control_div(method: method) do
            super(method, *args, { class: 'form-control' }.merge(options))
          end
        end
      end
    RUBY
  end

  def submit(options = {})
    cancel_path = options.delete(:cancel) || @template.polymorphic_path(object)
    form_group do
      control_div(offset: true) do
        submit = super(class: 'btn btn-primary')
        cancel = @template.link_to('Cancel', cancel_path, class: 'btn btn-default')

        submit + ' ' + cancel
      end
    end
  end

  def label(method, options = {})
    super method, { class: 'col-sm-2 control-label' }.merge(options)
  end

  private

  def form_group(&block)
    @template.content_tag :div, class: 'form-group', &block
  end

  def control_div(options = {}, &block)
    method = options.delete(:method)

    classes = ['col-sm-10']
    classes << 'col-sm-offset-2' if options[:offset]
    classes << 'has-error' if method.present? && object.errors[method].present?

    @template.content_tag(:div, class: classes.join(' '), &block)
  end
end

ActionView::Helpers::FormHelper.module_eval do
  # Generate a form for a model, with the right markup to be styled by Twitter
  # Bootstrap.
  def bootstrap_form_for(record, options = {}, &block)
    html_options = options.delete(:html) || {}
    form_for record, {
      builder: BootstrapFormBuilder,
      html: {
        class: 'form-horizontal',
        role: 'form'
      }.merge(html_options)
    }.merge(options), &block
  end
end
