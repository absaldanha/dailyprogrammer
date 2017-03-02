require "rspec"
require_relative "./../element"

RSpec.describe Element do
  subject { described_class.new "Barium", "Ba", 137 }

  describe "#can_write?" do
    context "when the element can write the word" do
      it { expect(subject.can_write?("ba")).to eq true }
    end

    context "when the element cant write the word" do
      it { expect(subject.can_write?("bo")).to eq false }
    end
  end
end
