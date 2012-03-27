module TakeSurveysHelper
  def survey_completed?(user, survey)
    # Given a user, determine if we've already completed all the questions
    # for this survey
    survey.my_questions.all? { |survey_question_ids| user.responses.map(&:question_id).include?(survey_question_ids) }
  end
end
