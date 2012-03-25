require 'test_helper'

class TakeSurveysControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_edit
    get :edit, :id => TakeSurveys.first
    assert_template 'edit'
  end

  def test_update_invalid
    TakeSurveys.any_instance.stubs(:valid?).returns(false)
    put :update, :id => TakeSurveys.first
    assert_template 'edit'
  end

  def test_update_valid
    TakeSurveys.any_instance.stubs(:valid?).returns(true)
    put :update, :id => TakeSurveys.first
    assert_redirected_to take_surveys_url
  end

  def test_destroy
    take_surveys = TakeSurveys.first
    delete :destroy, :id => take_surveys
    assert_redirected_to take_surveys_url
    assert !TakeSurveys.exists?(take_surveys.id)
  end
end
