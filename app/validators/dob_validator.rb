class DobValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        if value.present?
            now = Time.now.utc.to_date
            birthday = value
            age = now.year - birthday.year - (birthday.to_date.change(:year => now.year) > now ? 1 : 0)
            puts age
        end
    end
end