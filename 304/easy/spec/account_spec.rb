require "rspec"
require_relative "./../account"

RSpec.describe Account do
  before { Account.data_path = "./../files/account_chart.csv" }

  describe ".find" do
    context "when it finds the account" do
      it do
        expect(described_class.find(1000)).to be_a(Account)
      end
    end

    context "when it doesn't find the account" do
      it do
        expect(described_class.find(9999)).to eq nil
      end
    end
  end

  describe ".find_all_between" do
    context "when it finds accounts in the range" do
      it "return the accounts" do
        accounts = described_class.find_all_between(1000, 1100)

        expect(accounts.size).to eq 3
        accounts.each { |acc| expect(acc).to be_a(Account) }
      end
    end

    context "when it doesn't find accounts in the range" do
      it "return an empty array" do
        expect(described_class.find_all_between(1, 2)).to eq []
      end
    end
  end

  describe "#filter_entries" do
    let(:account) { described_class.new account: 1000, label: "Test" }

    let(:entry_1) { double :entry_1 }
    let(:entry_2) { double :entry_2 }
    let(:entry_3) { double :entry_3 }

    let(:entries) { [entry_1, entry_2, entry_3] }

    before do
      allow(account).to receive(:entries).and_return(entries)
      allow(entry_1).to receive(:period_between?)
        .with("JAN-16", "JUL-16").and_return(true)
      allow(entry_2).to receive(:period_between?)
        .with("JAN-16", "JUL-16").and_return(false)
      allow(entry_3).to receive(:period_between?)
        .with("JAN-16", "JUL-16").and_return(true)
    end

    it "returns the entries filtered" do
      expect(account.filter_entries("JAN-16", "JUL-16"))
        .to eq [entry_1, entry_3]
    end
  end
end
