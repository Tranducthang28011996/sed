class SurveysController < ApplicationController
  require 'csv'
  load_and_authorize_resource

  def index
  end

  def show
  end

  #SPEC: 2.2.2: Adding a new Survey(form)
  def new
    3.times do
      question = @survey.questions.build
      4.times { question.answers.build }
    end
  end

  #SPEC: 2.2.5: Create a new Survey(form)
  def create
    if @survey.save
      redirect_to @survey, :notice => "Successfully created survey."
    else
      render :action => 'new'
    end
  end

  #SPEC: 2.2.4: Edit an existing Survey(form)
  def edit
  end

  #SPEC: 2.2.7: Update the DB with the new Survey(form)
  def update
    if @survey.update_attributes(params[:survey])
      redirect_to @survey
    else
      render :action => 'edit'
    end
  end

  #SPEC: 2.2.3: Removing an existing Survey(form)
  #SPEC: 2.2.9: Destroy an existing Survey(form)
  def destroy
    @survey.destroy
    redirect_to surveys_url, :notice => "Successfully destroyed survey."
  end

  #SPEC: 7.2.1: View the Report on a specified survey
  def report
    @survey = Survey.find(params[:id])
    respond_to do |format|
      format.html
      format.js
      format.csv do
        csv_string = CSV.generate do |csv|
          @survey.questions.each do |question|
            # header row
            csv << ["question", "question_id"]

            # data rows
            csv << [question.content, question.id]
            question.answers.each do |answer|
              # header row
              csv << ["answer", "answer_id", "responses_total"]
              # data rows
              csv << [answer.content, answer.id, Response.answers_total_count(answer.id)]
            end
          end
        end
        # send it to the browser
        send_data csv_string,
          :type => 'text/csv; charset=iso-8859-1; header=present',
          :disposition => "attachment; filename=report.csv"
      end
    end
  end
end
