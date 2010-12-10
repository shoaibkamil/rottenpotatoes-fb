module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    if count.odd?
      return "odd"
    else
      return "even"
    end
  end
  # Maintains a count while looping:
  def count_each(input)
    @count = 1
    input.each do |item|
      yield(item)
      @count += 1
    end
  end
end
