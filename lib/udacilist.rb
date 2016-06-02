class UdaciList
  include Listable
  attr_reader :title, :items


  def initialize(options={})
    @title = options[:title]
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    case type
      when "todo"
        if options[:priority] == "low" || options[:priority] == "medium" || options[:priority] == "high" || options[:priority] == nil
        @items.push TodoItem.new(description, options)
        else
          raise UdaciListErrors::InvalidPriorityValue, "Invalid Priority Type"
        end
      when "event"
        if options[:priority] == "low" || options[:priority] == "medium" || options[:priority] == "high" || options[:priority] == nil
          @items.push EventItem.new(description, options)
        else
          raise UdaciListErrors::InvalidPriorityValue, "Invalid Priority Type"
        end
      when "link"
        if options[:priority] == "low" || options[:priority] == "medium" || options[:priority] == "high" || options[:priority] == nil
          @items.push LinkItem.new(description, options)
        else
          raise UdaciListErrors::InvalidPriorityValue, "Invalid Priority Type"
        end
      else
        raise UdaciListErrors::InvalidItemType, "Invalid Item Type"
    end
  end

  def delete(index)
    if index < @items.length
      @items.delete_at(index - 1)
    else
      raise UdaciListErrors::IndexExceedsListSize, "Index Exceeds List Size"
    end
  end
  
  def all
    rows = []
    rows << ["*" * @title.length]
    rows << [@title]
    rows << ["-" * @title.length]
    @items.each_with_index do |item, position|
      rows << ["#{position + 1} #{item.details}"]
    end
    table = Terminal::Table.new :rows => rows
    puts table
  end

end
