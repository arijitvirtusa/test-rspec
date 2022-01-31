require 'rails_helper'

RSpec.describe Professor, type: :model do
  professor = described_class.new ({ name: 'Dodo',
    email: 'dodo@gmail.com',
    mobile: '9874563210',
    designation: 'HOD',
    dob: '16/05/1989',
    joining_date: '27/12/2021',
    qualification: 'B.Tech' 
  })

  it "is valid with valid attributes" do
    expect(professor).to be_valid
  end

  it "is not valid without a name" do
    
  end

  it "is not valid if name is less than 3 or greater than 100 characters" do
    
  end

  it "is not valid if name contains anything other than letters" do
    
  end

  it "is not valid without a email" do
    
  end

  it "is not valid if email is not unique" do
    
  end

  it "is not valid if email does not contain @ and a valid domain after @" do
    
  end

  it "is not valid if mobile is not of length 10" do
    
  end

  it "is not valid if mobile contains anything other than number" do
    
  end

  it "is not valid without a designation" do
    
  end

  it "is not valid if designation is not from list HOD, Senior, Junior, Trainee" do
    
  end

  it "is not valid without a joining_date" do
    
  end

  it "is not valid if joining_date is not in proper date format dd/mm/yyyy" do
    
  end

  it "is not valid if joining_date greater than today" do
    
  end

  it "is not valid without a dob" do
    
  end

  it "is not valid if dob is not in proper date format dd/mm/yyyy" do
    
  end

  it "is not valid if dob is 18 years or more from current date" do
    
  end

  it "is not valid without a qualification" do
    
  end
  
  it "is not valid if qualification is not alphanumeric and allowed special characters (@, &, -, . , _ , #)" do
    
  end

end
