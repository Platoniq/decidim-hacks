EtiquetteValidator.class_eval do
  def validate_length(record, attribute, value)
    return if value.length > 5

    record.errors.add(attribute, options[:message] || :too_short)
  end
end