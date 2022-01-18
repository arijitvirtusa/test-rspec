# frozen_string_literal: true

class ValidDateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
      Date.parse(value.to_s)
    rescue ArgumentError
      record.errors.add(attribute, options[:message] || 'not a valid date')
    end
  end
end
