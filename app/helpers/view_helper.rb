# coding: utf-8

Freesia::App.helpers do
  def button_link(str, url, options={})
    default_confirm_message = '実行しますか？'
    attributes = {
      href: url
    }
    attributes[:class] = "btn #{options[:button_class]}"
    attributes[:'data-method'] = "#{options[:method].nil? ? :get : options[:method]}"
    attributes[:disabled] = true if options[:disabled]
    attributes[:'data-confirm'] = options[:confirm_message] || default_confirm_message if options[:confirm]

    options[:icon] = 'icon-'+options[:icon] unless options[:icon].blank?

    haml = <<EOS
%a{attributes}
  %i{:class=>'#{options[:icon]}'}
  #{str}
EOS

    Haml::Engine.new(haml).render(Object.new, :attributes=>attributes)
  end
end
