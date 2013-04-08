# coding: utf-8

Freesia::App.helpers do
  def set_form_errors(item)
    errors = item.errors.map {|message| content_tag :li, message}.join('')
    errors = "<ul>#{errors}</li>" unless errors.blank?

    if flash[:error].blank?
      flash[:error] = errors
    else
      flash[:error] += errors
    end

    return errors
  end
end
