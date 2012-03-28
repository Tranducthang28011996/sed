module SurveysHelper
  # pretty_dates and times MST
  def to_mst_pretty(survey)
    "#{survey.available_at.localtime.strftime("%d %B %Y at %I:%M:%S %p")} MST"
  end

  def date_pretty_mst(date)
    date.localtime.strftime("%d %B %Y ")
  end

  def date_time_pretty_mst(date)
    "#{date.localtime.strftime("%d %B %Y at %I:%M:%S %p")} MST"
  end
end
