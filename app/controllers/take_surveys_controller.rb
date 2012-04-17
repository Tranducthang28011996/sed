class TakeSurveysController < ApplicationController
  #SPEC: 7.1: Adding TakeSurveysController
  #SPEC: 7.1.1: Adding New Action
  def new
    @survey = Survey.find(params[:id]) if params[:id]
    authorize! :take, :survey
    respond_to do |format|
      format.html
    end
  end

  #SPEC: 7.1.1.2: Adding Create action
  def create
    params[:response].each do |question, answer|
      current_user.responses.create :question_id => question, :answer_id => answer[:answer_id], :content => answer[:content],
        :user_id => current_user.id
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

  #SPEC: 7.1.1.3: Adding Edit action
  def edit
    @survey = Survey.find(params[:id]) if params[:id]
    authorize! :show, :survey
  end

  #SPEC: 7.1.1.4: Adding Show action
  def show
    @survey = Survey.find(params[:id]) if params[:id]
    authorize! :show, :survey
  end
end
