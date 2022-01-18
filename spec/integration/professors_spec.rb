require 'swagger_helper'

describe 'Professors API' do

  path '/api/v1/professors' do

    post 'Creates a professor' do
      tags 'Professors'
      consumes 'application/json', 'application/xml'
      parameter name: :professor, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          mobile: { type: :string },
          designation: { type: :string },
          dob: { type: :date },
          joining_date: { type: :date },
          qualification: { type: :string }
        },
        required: [ 'name', 'email', 'designation', 'dob', 'joining_date', 'qualification' ]
      }

      response '201', 'professor created' do
        let(:professor) { { name: 'Dodo', email: 'dodo@gmail.com', mobile: '9874563210', designation: 'HOD', dob: '16/05/1989', joining_date: '27/12/2021', qualification: 'B.Tech' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:professor) { { name: 'Dodo', email: 'dodo@gmail.com', mobile: '9874563210', designation: 'HOD', dob: '16/05/1989', joining_date: '27/12/2021', qualification: 'B.Tech' } }
        run_test!
      end
    end
  end

  path '/api/v1/professors/{id}' do

    get 'Retrieves a professor' do
      tags 'Professors'
      produces 'application/json', 'application/xml'
      parameter name: :id, :in => :path, :type => :string

      response '200', 'name found' do
        schema type: :object,
          properties: {
            id: { type: :integer, },
            name: { type: :string },
            email: { type: :string },
            mobile: { type: :string },
            designation: { type: :string },
            dob: { type: :date },
            joining_date: { type: :date },
            qualification: { type: :string }
          },
          required: [ 'id', 'name', 'email', 'mobile', 'designation', 'dob', 'joining_date', 'qualification' ]

        let(:id) { Professor.create(name: 'Dodo', email: 'dodo@gmail.com', mobile: '9874563210', designation: 'HOD', dob: '16/05/1989', joining_date: '27/12/2021', qualification: 'B.Tech').id }
        run_test!
      end

      response '404', 'professor not found' do
        let(:id) { 'professor' }
        run_test!
      end
    end
  end
end