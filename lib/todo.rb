class TodoItem
  include Listable
  attr_reader :description, :due, :priority, :type

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    @type = "Todo"
  end


  def details
    format_description(@description) + "due: " +
    due_date(@due) +
    format_priority(@priority)
  end
end
