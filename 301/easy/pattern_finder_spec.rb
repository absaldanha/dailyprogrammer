require_relative "pattern_finder"
require "rspec"

RSpec.describe PatternFinder do
  subject { described_class.new }

  let(:input_1) { "XXYYZZ" }
  let(:input_2) { "XXYYX" }

  let(:output_1) do
    [ "bookkeeper", "bookkeepers", "bookkeeping", "bookkeepings" ]
  end
  let(:output_2) do
    [
      "addressees", "betweenness", "betweennesses", "colessees", "fricassees",
      "greenness", "greennesses", "heelless", "keelless", "keenness",
      "keennesses", "lessees", "wheelless"
    ]
  end

  it { expect(subject.find(input_1)).to eq output_1 }
  it { expect(subject.find(input_2)).to eq output_2 }
end
