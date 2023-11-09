module DateHelper
  def time_ago(date)
    if date > 1.hour.ago
      "#{time_ago_in_words(date)} ago"
    elsif date > 1.day.ago
      date.strftime("%l:%M %p")
    else
      date.strftime("%b %e %y %l:%M %p")
    end
  end
end
