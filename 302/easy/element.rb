class Element
  attr_reader :name, :symbol, :weight

  def initialize(name, symbol, weight)
    @symbol = symbol
    @name = name
    @weight = weight
  end

  def can_write?(letters)
    symbol.casecmp(letters).zero?
  end
end
