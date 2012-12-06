class Range
  def distance_to(value)
    return 0 if self.include?(value)

    if value > self.end
      value - self.end
    else
      value - self.begin
    end
  end
end