class TakeSurveysController < ApplicationController
  def new
    @survey = Survey.find(params[:id]) if params[:id]
  end

  def create
    params.each do |key, value|
      if key =~ /^response\d+$/
        current_user.responses.new(:answer_id => value, :user_id => current_user.id)
      end
    end

    current_user.save
    if current_user.responses.any? { |response| response.errors.any? }
      flash.now[:error] = current_user.responses.reduce("") { |memo, r| memo << r.errors.full_messages.join(", ") }
    end
  end

  def show
  end
end
