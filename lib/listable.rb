module Listable
  def format_description(description)
    "#{description}".ljust(25)
  end

  # Date Methods Here
  def format_dates(start_date, end_date)
    dates = @start_date.strftime("%D") if @start_date
    dates << " -- " + @end_date.strftime("%D") if @end_date
    dates = "N/A" if !dates
    return dates
  end

  def due_date(due_date)
    @due ? @due.strftime("%D") : "No due date"
  end

  def format_priority(priority)
    value = " ⇧" if @priority == "high"
    value = " ⇨" if @priority == "medium"
    value = " ⇩" if @priority == "low"
    value = "" if !@priority
    return value
  end



end
