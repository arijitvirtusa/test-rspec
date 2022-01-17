# frozen_string_literal: true

class Professor < ApplicationRecord
  DESIGNATION_OPTIONS = %w[HOD Senior Junior Trainee].freeze

  validates :name, presence: { message: 'Name cannot be blank' },
    length: {
      minimum: 3,
      maximum: 100,
      message: 'Name should be greater than or equal 3 characters and smaller than or equal 100 characters' 
    },
    format: {
        with: %r{/\A[a-zA-Z]+(?: [a-zA-Z]+)?\z/},
        message: 'Name should contain only letters.'
    }
  validates :email, presence: { message: 'Email cannot be blank' },
    uniqueness: { message: 'This email is already taken' },
    format: {
        with: %r{/^(.+)@(.+)$/},
        message: 'email should contain `@` symbol'
    }
  validates :mobile, format: { with: %r{/\A\d+\z/}, message: 'Mobile can contain only numbers' },
    length: { is: 10, message: 'Mobile number should be of length 10 digits' }, allow_blank: true
  validates :designation, presence: { message: 'Designation cannot be blank' },
    inclusion: { in: DESIGNATION_OPTIONS, message: 'Designation can only be values from list HOD, Senior, Junior, Trainee' }
  validates :joining_date, presence: { message: 'Joining date cannot be blank' },
    format: { with: %r{/\A\d{2}\/\d{2}\/\d{4}\Z/}, message: 'Joining date should be of format dd/mm/YYYY' },
    not_future: { message: 'Joining date can\'t be in the future' }
  validates :dob, presence: { message: 'DOB cannot be blank' },
    format: { with: %r{/\d{2}\/\d{2}\/\d{4}/}, message: 'DOB should be of format dd/mm/YYYY' },
    dob: { message: 'Age should be greater than 18' }
  validates :qualification, presence: { message: 'Qualification cannot be blank' }

end
