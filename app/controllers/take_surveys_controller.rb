class TakeSurveysController < ApplicationController
  def new
    @survey = Survey.find(params[:id]) if params[:id]
  end

  def create
  end

  def show
  end
end
