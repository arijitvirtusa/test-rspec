require 'rails_helper'

RSpec.describe "Api::V1::Professors", type: :request do
  describe 'Create Professor' do
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

    context 'For Success' do
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
        request_params[:email] = nil
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

  end
end
