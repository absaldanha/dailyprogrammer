class PatternFinder
  def initialize
    load_dictionary!
    @regex_pattern = nil
  end

  def find(pattern)
    build_regex(pattern)
    find_words
  end

  private

  def load_dictionary!
    @words = File.readlines("enable1.txt").map(&:chomp)
  end

  def build_regex(pattern)
    hash = {}
    backtrack_number = 0
    string_pattern = ""

    pattern.chars.each do |char|
      if hash.key?(char)
        string_pattern << "\\#{hash[char]}"
      else
        string_pattern << "(.)"
        hash[char] = backtrack_number += 1
      end
    end

    @regex_pattern = Regexp.new string_pattern
  end

  def find_words
    @words.select { |word| @regex_pattern =~ word }
  end
end
