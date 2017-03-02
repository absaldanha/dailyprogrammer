class Spelling
  include Comparable

  attr_reader :elements, :word

  def initialize(element, word)
    @word = word
    element.is_a?(Array) ? @elements = element : @elements = [element]
  end

  def accepts?(element)
    return false unless element
    word.include? (elements_word + element.symbol.downcase)
  end

  def insert(element)
    @elements << element
  end

  def deep_dup
    self.class.new Array.new(elements), word
  end

  def weight
    @weight ||= elements.reduce(0) { |sum, element| sum + element.weight }
  end

  def <=>(other)
    weight <=> other.weight
  end

  private

  def elements_word
    @elements.each_with_object("") do |element, string|
      string << element.symbol.downcase
    end
  end
end
