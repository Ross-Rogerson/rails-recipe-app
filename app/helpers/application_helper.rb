module ApplicationHelper
  def formatted_post_date(time)
    today = Date.current
    date = time.to_date

    case
    when date == today
      "Today at #{time.strftime("%H:%M")}"
    when date == today - 1
      "Yesterday"
    when date > today - 7
      date.strftime("%A") # e.g., "Monday", "Tuesday"
    when date > today - 30
      weeks_ago = ((today - date).to_i / 7).to_i
      "#{weeks_ago} #{'week'.pluralize(weeks_ago)} ago"
    when date.year == today.year
      months_ago = ((today - date).to_i / 30).to_i
      "#{months_ago} #{'month'.pluralize(months_ago)} ago"
    else
      years_ago = today.year - date.year
      "#{years_ago} #{'year'.pluralize(years_ago)} ago"
    end
  end

  def own_profile?(user)
    user == current_user
  end
end
