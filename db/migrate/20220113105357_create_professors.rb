class CreateProfessors < ActiveRecord::Migration[6.1]
  def change
    create_table :professors do |t|
      t.string :name
      t.string :email, index: { unique: true, name: 'unique_emails' }
      t.string :designation  
      t.date :joining_date
      t.string :mobile
      t.date :dob
      t.string :qualification
      t.timestamps
    end
  end
end
