# frozen_string_literal: true

class Api::V1::ProfessorsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    professors = Professor.all
    render json: { message: 'Professors list', professors: professors }, status: 200
  end

  def create
    begin
      professor = Professor.new(professor_params)
      if professor&.save
        render json: { message: 'Professor Created Successfully', errors: nil }, status: 200
      else
        render json: { message: 'Failed To Create Professor', errors: professor&.errors&.messages }, status: 422
      end
    rescue ActiveRecord::ActiveRecordError
      render json: { message: 'Failed To Create Professor', errors: nil }, status: 422
    end
  end

  def show
    begin
      @professor = Professor.find(params[:id])
      if @professor
        render json: { professor: @professor, message: 'Professor details', errors: nil }, status: 200
      else
        render json: { message: 'Professor details not found', errors: nil }, status: 404
      end
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'Professor details not found', errors: nil }, status: 404
    end
  end

  private

  def professor_params
    params.permit(:name, :email, :mobile, :designation, :dob, :joining_date, :qualification)
  end
end
