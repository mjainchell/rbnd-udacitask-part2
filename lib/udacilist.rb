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

  def filter(item_type)

    if item_type == "event"
      items = @items.select do |item|
        item.instance_of?(EventItem)
        end
      elsif item_type == "todo"
        items = @items.select do |item|
          item.instance_of?(TodoItem)
          end
      elsif item_type == "link"
        items = @items.select do |item|
          item.instance_of?(LinkItem)
          end
      else
        raise UdaciListErrors::NoneOfThatType, "No Items of That Type"
    end
    title1 = Artii::Base.new :font => 'slant'
    rows2 = []
    rows2 << ["*".colorize(:blue) * @title.length * 5]
    rows2 << [title1.asciify(@title)]
    rows2 << ["-".colorize(:blue) * @title.length * 5]
    items.each_with_index do |item, position|
      rows2 << ["#{position + 1} #{colorizer(item)} #{item.details}"]
    end
    table2 = Terminal::Table.new :rows => rows2
    puts table2

  end

  # NEW FEATURE colorizer method color codes the item types

  def colorizer(item)
    if item.instance_of?(TodoItem)
        item.type.colorize(:yellow)
      elsif item.instance_of?(EventItem)
        item.type.colorize(:green)
      elsif item.instance_of?(LinkItem)
        item.type.colorize(:red)
      else
        item.type.colorize(:black)
    end
  end

  # NEW FEATURE Artii is used to asciify the list titles


  def all
    title2 = Artii::Base.new :font => 'slant'
    rows = []
    rows << ["*".colorize(:blue) * @title.length * 5]
    rows << [title2.asciify(@title)]

    rows << ["-".colorize(:blue) * @title.length * 5]
    @items.each_with_index do |item, position|
    rows << ["#{position + 1} #{colorizer(item)} #{item.details}"]
    end
    table = Terminal::Table.new :rows => rows
    puts table

  end


end





