require "rspec"
require_relative "./../chemistry_speller"

RSpec.describe ChemistrySpeller do
  subject { described_class.new }

  describe "#spell" do
    let(:output_1) do
      "FUNCTiONS (Fluorine Uranium Nitrogen Carbon Titanium Oxygen " \
        "Nitrogen Sulfur)"
    end
    let(:output_2) { "BAcON (Boron Actinium Oxygen Nitrogen)" }
    let(:output_3) { "PoISON (Polonium Iodine Sulfur Oxygen Nitrogen)" }
    let(:output_4) do
      "SICKNEsS (Sulfur Iodine Carbon Potassium Nitrogen " \
        "Einsteinium Sulfur)"
    end
    let(:output_5) do "TiCKLiSH (Titanium Carbon Potassium Lithium " \
        "Sulfur Hydrogen)"
    end

    it "returns the word formed by elements (the heaviest composition)" do
      expect(subject.spell("functions")).to eq output_1
      expect(subject.spell("bacon")).to eq output_2
      expect(subject.spell("poison")).to eq output_3
      expect(subject.spell("sickness")).to eq output_4
      expect(subject.spell("ticklish")).to eq output_5
    end
  end
end
