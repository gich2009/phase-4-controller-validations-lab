class PostsController < ApplicationController
  wrap_parameters format: []
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found
  rescue_from ActiveRecord::RecordInvalid,  with: :render_unprocessable_entity

  def show
    post = find_post
    render json: post
  end


  def update
    post = find_post
    post.update!(post_params)
    render json: post, status: :ok
  end


  private

  def post_params
    params.permit(:category, :content, :title)
  end


  def find_post
    Post.find(params[:id])
  end


  def render_record_not_found exception
    render json: { error: "#{exception.model.underscore.humanize} not found" }, status: :not_found 
  end


  def render_unprocessable_entity exception
    render json: { errors: exception.record.errors }, status: :unprocessable_entity
  end
end
