require "rspec"
require_relative "./../composition"

RSpec.describe Composition do
  subject { described_class.new(element_1) }
  let(:element_1) { double :element_1, weight: 5, symbol: "Ba" }

  before { described_class.word = "banana" }

  describe "#weight" do
    let(:element_2) { double :element_2, weight: 5 }

    before { subject.insert(element_2) }

    it "returns the sum of the weights of the elements" do
      expect(subject.weight).to eq 10
    end
  end

  describe "#accepts?" do
    context "when it accepts the element to form the word" do
      let(:element_2) { double :element_2, symbol: "Na" }

      it do
        expect(subject.accepts?(element_2)).to eq true
      end
    end

    context "when it doesnt accept the element to form the word" do
      let(:element_2) { double :element_2, symbol: "Do" }

      it do
        expect(subject.accepts?(element_2)).to eq false
      end
    end
  end

  describe "#deep_dup" do
    let(:other_comp) { subject.deep_dup }

    it do
      expect(other_comp.elements.equal?(subject.elements)).to eq false
      expect(other_comp.equal?(subject)).to eq false
    end
  end
end
