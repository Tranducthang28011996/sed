class TakeSurveysController < ApplicationController
  def new
    @survey = Survey.find(params[:id]) if params[:id]
    authorize! :take, :survey
  end

  def create
    params[:response].each do |question, answer|
      current_user.responses.create :question_id => question, :answer_id => answer, :user_id => current_user.id
    end

    if current_user.save
      flash[:info] = "Your survey has been submitted successfully!"
      redirect_to take_survey_path(Survey.find(params[:survey_id]))
    else
      flash.now[:error] = "There were problems with your survey submission."
      render :edit
    end
    authorize! :create, :survey
  end

  def edit
  end

  def show
    @survey = Survey.find(params[:id]) if params[:id]
    authorize! :show, :survey
  end
end
