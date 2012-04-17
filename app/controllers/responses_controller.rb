class ResponsesController < ApplicationController
  load_and_authorize_resource
  def index
    @student = User.find(params[:user_id])
    authorize! :read, @student, :id => @student.id
    @responses = Response.not_anonymous.where(:user_id => @student.id)
    authorize! :index, Response, :user_id => current_user.id
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
