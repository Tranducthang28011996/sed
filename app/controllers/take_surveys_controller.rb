class TakeSurveysController < ApplicationController
  def index
#@take_surveys = TakeSurveys.all
  end

  def edit
#@take_surveys = TakeSurveys.find(params[:id])
  end

  def update
#@take_surveys = TakeSurveys.find(params[:id])
#if @take_surveys.update_attributes(params[:take_surveys])
#redirect_to take_surveys_url, :notice  => "Successfully updated take surveys."
#else
#render :action => 'edit'
#end
  end

  def destroy
#@take_surveys = TakeSurveys.find(params[:id])
#@take_surveys.destroy
#redirect_to take_surveys_url, :notice => "Successfully destroyed take surveys."
  end
end
