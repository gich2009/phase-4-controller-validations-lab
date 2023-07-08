class AuthorsController < ApplicationController
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
  
  def show
    author = find_author
    render json: author
  end


  def create
    author = Author.create!(author_params)
    render json: author, status: :created
  end



  private
  
  def author_params
    params.permit(:email, :name)
  end


  def find_author
    Author.find(params[:id])
  end


  def render_record_not_found exception
    render json: { error: "#{exception.model.underscore.humanize} not found" }, status: :not_found
  end


  def render_unprocessable_entity exception
    render json: {errors: exception.record.errors}, status: :unprocessable_entity
  end
  
end