require "csv"
require_relative "element"
require_relative "spelling"
require "pry"

class ChemistrySpeller
  attr_reader :elements

  def initialize
    @elements = []
    load_elements!
  end

  def spell(word)
    spellings = find_spellings(word)
    best_solution = spellings.max
    build_word best_solution.elements
  end

  private

  def find_spellings(word)
    chars = word.chars
    two_letters = chars.each_cons(2).map { |letters| letters.join }

    chars.zip(two_letters).each_with_object([]) do |possibilities, spellings|
      element1 = find_element(possibilities[0])
      element2 = find_element(possibilities[1])

      possible_spellings(spellings, element1, element2, word)
    end
  end

  def possible_spellings(spellings, element1, element2, word)
    return if element1.nil? && element2.nil?

    if spellings.empty?
      spellings << Spelling.new(element1, word) if element1
      spellings << Spelling.new(element2, word) if element2
    else
      spellings.each do |spelling|
        if spelling.accepts?(element1) && spelling.accepts?(element2)
          new_spelling = spelling.deep_dup
          spelling.insert(element1)
          new_spelling.insert(element2)
          spellings << new_spelling
        elsif spelling.accepts?(element1)
          spelling.insert(element1)
        elsif spelling.accepts?(element2)
          spelling.insert(element2)
        end
      end
    end
  end

  def find_element(value)
    return unless value
    elements.find { |element| element.can_write? value }
  end

  def build_word(elements)
    symbol_word = ""
    element_names = ""

    elements.each do |element|
      symbol_word << element.symbol
      element_names << " #{element.name}"
    end

    "#{symbol_word} (#{element_names.strip})"
  end

  def load_elements!
    csv_data = CSV.read("./../ptdata2.csv")
    csv_data.shift
    parse_csv(csv_data)
  end

  def parse_csv(elements_data)
    elements_data.each do |data|
      @elements << Element.new(data[2].strip, data[1].strip, data[3].strip.to_i)
    end
  end
end
