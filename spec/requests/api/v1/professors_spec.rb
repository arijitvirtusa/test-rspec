require 'rails_helper'

RSpec.describe "Api::V1::Professors", type: :request do
  describe 'When we want to create Professor' do
    let(:request_params) do
      {
        name: 'Dodo',
        email: 'dodo@gmail.com',
        mobile: '9874563210',
        designation: 'HOD',
        dob: '16/05/1989',
        joining_date: '27/12/2021',
        qualification: 'B.Tech'
      }
    end

    let(:fail_request_params) do
      {
        name: 'Dodo',
        email: 'dodogmail.com',
        designation: 'HOD',
        dob: '16/05/1989',
        joining_date: '27/12/2021',
        qualification: 'B.Tech'
      }
    end

    context 'We provide valid params for professor' do
      before do
        post '/api/v1/professors', params: request_params, as: :json
      end
      it "should return success status" do
        expect(response).to have_http_status(201)
      end

      it "should have success message" do
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq("Professor Created Successfully")
      end
    end

    context 'For general failure' do
      before do
        post '/api/v1/professors', params: fail_request_params, as: :json
      end

      it "should return failure status" do
        expect(response).to have_http_status(422)
      end

      it "should have failure message" do
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq("Failed To Create Professor")
      end

      it "should contain errors" do
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).not_to be_nil
      end
    end

    context 'For name presence check failed' do
      before do
        request_params[:name] = nil
        post '/api/v1/professors', params: request_params, as: :json
      end

      it "should return failure status" do
        expect(response).to have_http_status(422)
      end

      it "should have failure message" do
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq("Failed To Create Professor")
      end

      it "should contain errors" do
        json_response = JSON.parse(response.body)
        expect(json_response['errors']['name'][0]).to eq('Name cannot be blank')
      end
    end

    context 'For name length check failed' do
      before do
        request_params[:name] = 'B'
        post '/api/v1/professors', params: request_params, as: :json
      end

      it "should return failure status" do
        expect(response).to have_http_status(422)
      end

      it "should have failure message" do
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq("Failed To Create Professor")
      end

      it "should contain errors" do
        json_response = JSON.parse(response.body)
        expect(json_response['errors']['name'][0]).to eq('Name should be greater than or equal 3 characters and smaller than or equal 100 characters')
      end
    end

    context 'For name contain only character check failed' do
      before do
        request_params[:name] = 'B@@#'
        post '/api/v1/professors', params: request_params, as: :json
      end

      it "should return failure status" do
        expect(response).to have_http_status(422)
      end

      it "should have failure message" do
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq("Failed To Create Professor")
      end

      it "should contain errors" do
        json_response = JSON.parse(response.body)
        expect(json_response['errors']['name'][0]).to eq('Name should contain only letters.')
      end
    end

    context 'For email presence check failed' do
      before do
        request_params[:email] = nil
        post '/api/v1/professors', params: request_params, as: :json
      end

      it "should return failure status" do
        expect(response).to have_http_status(422)
      end

      it "should have failure message" do
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq("Failed To Create Professor")
      end

      it "should contain errors" do
        json_response = JSON.parse(response.body)
        expect(json_response['errors']['email'][0]).to eq('Email cannot be blank')
      end
    end

    context 'For email correct format check failed' do
      before do
        request_params[:email] = 'agssg@hhh'
        post '/api/v1/professors', params: request_params, as: :json
      end

      it "should return failure status" do
        expect(response).to have_http_status(422)
      end

      it "should have failure message" do
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq("Failed To Create Professor")
      end

      it "should contain errors" do
        json_response = JSON.parse(response.body)
        expect(json_response['errors']['email'][0]).to eq('email should contain `@` symbol and valid domain after `@`')
      end
    end

    context 'For email uniqueness check failed' do
      before do
        existed_user =  Professor.find_by(email: "dodo@gmail.com")
        post '/api/v1/professors', params: request_params, as: :json
      end

      it "should return failure status" do
        expect(response).to have_http_status(422)
      end

      it "should have failure message" do
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq("Failed To Create Professor")
      end

      it "should contain errors" do
        json_response = JSON.parse(response.body)
        expect(json_response['errors']['email'][0]).to eq('email should contain `@` symbol and valid domain after `@`')
      end
    end

    context 'For designation presence check failed' do
      before do
        request_params[:designation] = nil
        post '/api/v1/professors', params: request_params, as: :json
      end

      it "should return failure status" do
        expect(response).to have_http_status(422)
      end

      it "should have failure message" do
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq("Failed To Create Professor")
      end

      it "should contain errors" do
        json_response = JSON.parse(response.body)
        expect(json_response['errors']['designation'][0]).to eq('Designation cannot be blank')
      end
    end

    context 'For designation in acceptable values check failed' do
      before do
        request_params[:designation] = 'test'
        post '/api/v1/professors', params: request_params, as: :json
      end

      it "should return failure status" do
        expect(response).to have_http_status(422)
      end

      it "should have failure message" do
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq("Failed To Create Professor")
      end

      it "should contain errors" do
        json_response = JSON.parse(response.body)
        expect(json_response['errors']['designation'][0]).to eq('Designation can only be values from list HOD, Senior, Junior, Trainee')
      end
    end

    context 'For Joining date presence check failed' do
      before do
        request_params[:joining_date] = nil
        post '/api/v1/professors', params: request_params, as: :json
      end

      it "should return failure status" do
        expect(response).to have_http_status(422)
      end

      it "should have failure message" do
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq("Failed To Create Professor")
      end

      it "should contain errors" do
        json_response = JSON.parse(response.body)
        expect(json_response['errors']['joining_date'][0]).to eq('Joining date cannot be blank')
      end
    end

    context 'For Joining date proper date format check failed' do
      before do
        request_params[:joining_date] = '11/22/2111'
        puts request_params
        post '/api/v1/professors', params: request_params, as: :json
      end

      it "should return failure status" do
        expect(response).to have_http_status(422)
      end

      it "should have failure message" do
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq("Failed To Create Professor")
      end

      it "should contain errors" do
        json_response = JSON.parse(response.body)
        expect(json_response['errors']['joining_date'][0]).to eq('Joining date should be of format dd/mm/YYYY')
      end
    end

    context 'For Joining date valid date check failed' do
      before do
        request_params[:joining_date] = '21/01/2022'
        post '/api/v1/professors', params: request_params, as: :json
      end

      it "should return failure status" do
        expect(response).to have_http_status(422)
      end

      it "should have failure message" do
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq("Failed To Create Professor")
      end

      it "should contain errors" do
        json_response = JSON.parse(response.body)
        expect(json_response['errors']['joining_date'][0]).to eq('Joining date can\'t be in the future')
      end
    end

    context 'For dob presence check failed' do
      before do
        request_params[:dob] = nil
        post '/api/v1/professors', params: request_params, as: :json
      end

      it "should return failure status" do
        expect(response).to have_http_status(422)
      end

      it "should have failure message" do
        json_response = JSON.parse(response.body)
        expect(json_response['message']).to eq("Failed To Create Professor")
      end

      it "should contain errors" do
        json_response = JSON.parse(response.body)
        expect(json_response['errors']['dob'][0]).to eq('DOB cannot be blank')
      end
    end

  end
end
