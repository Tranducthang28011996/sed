class ResponsesController < ApplicationController
  load_and_authorize_resource
  def index
    @responses = current_user.responses
    authorize! :index, Response
  end

  def show
    @response = current_user.responses.find(params[:id])
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
