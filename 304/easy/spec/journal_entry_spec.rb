require "rspec"
require_relative "./../journal_entry"

RSpec.describe JournalEntry do
  before { JournalEntry.data_path = "./../files/journal.csv" }

  describe ".find_all" do
    context "when it finds the entries for a given account" do
      it "return the entries" do
        entries = described_class.find_all(1110)

        expect(entries.size).to eq 2
        entries.each { |entry| expect(entry).to be_a(JournalEntry) }
      end
    end

    context "when it doesn't find entries for a given account" do
      it "returns an empty array" do
        expect(described_class.find_all(1)).to eq []
      end
    end
  end

  describe "#period_between?" do
    let(:entry) do
      described_class.new account: 1, period: "APR-16", debit: 1, credit: 1
    end

    context "when the period is between" do
      it { expect(entry.period_between?("MAR-16", "MAY-16")).to eq true }
    end

    context "when the period is not between" do
      it { expect(entry.period_between?("JUN-16", "JUL-16")).to eq false }
    end
  end
end
