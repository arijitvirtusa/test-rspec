# frozen_string_literal: true

class DobValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.present?
      now = Time.now.utc.to_date
      birthday = value
      age = now.year - birthday.year - (birthday.to_date.change(year: now.year) > now ? 1 : 0)
      if age < 18
        record.errors.add(attribute, options[:message] || 'can\'t be less than 18 years')
      end
    end
  end
end
