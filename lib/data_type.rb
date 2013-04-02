class DataType
  TYPES = [:string, :text, :integer, :float, :image, :video, :audio]

  def self.formlize(form, type, name, options={})
    name = name.to_s.to_sym

    form.__send__(form_type(type), name, options)
  end

  private
  def self.form_type(type)
    case type
    when :string
      :text_field
    when :text
      :text_area
    when :integer
      :text_field
    when :float
      :text_field
    else
      nil
    end
  end
end
