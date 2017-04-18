class ReimplementEnumerable
  def initialize(collection)
    @collection = collection
  end

  def select
    result = []

    @collection.each do |element|
      should_select = yield(element)
      if should_select
        result << element
      end
    end

    return result
  end

  def find
    result = nil
    @collection.each do |element|
      should_find = yield(element)
      if should_find
        result = element
        break
      end
    end
    result
  end

  def count
    result = 0
    @collection.each do |element|
      count_it = yield(element)
      if count_it
        result += 1
      end
    end
    result
  end

  def all?
    result = []
    @collection.each do |element|
      item = yield(element)
      if item
        result << element
      end
    end
    result == @collection
  end

  def max_by
    result = nil
    new_max = nil
    @collection.each do |element|
      max = yield(element)
      while result.nil? || new_max < max
        new_max = max
        result = element
      end
    end
    result
  end
end
