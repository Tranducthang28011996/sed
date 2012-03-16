class SurveysController < ApplicationController
#before_filter :authorize
  load_and_authorize_resource
  def index
    @surveys = Survey.all
  end

  def show
    @survey = Survey.find(params[:id])
  end

  #SPEC: 2.2.2: Adding a new Survey(form)
  def new
    @survey = Survey.new
    3.times do
      question = @survey.questions.build
      4.times { question.answers.build }
    end
  end

  #SPEC: 2.2.5: Create a new Survey(form)
  def create
    @survey = Survey.new(params[:survey])
    if @survey.save
      redirect_to @survey, :notice => "Successfully created survey."
    else
      render :action => 'new'
    end
  end

  #SPEC: 2.2.4: Edit an existing Survey(form)
  def edit
    @survey = Survey.find(params[:id])
  end

  #SPEC: 2.2.7: Update the DB with the new Survey(form)
  def update
    @survey = Survey.find(params[:id])
    if @survey.update_attributes(params[:survey])
      redirect_to @survey, :notice  => "Successfully updated survey."
    else
      render :action => 'edit'
    end
  end

  #SPEC: 2.2.3: Removing an existing Survey(form)
  #SPEC: 2.2.9: Destroy an existing Survey(form)
  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy
    redirect_to surveys_url, :notice => "Successfully destroyed survey."
  end
end
