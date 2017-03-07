require "rspec"
require_relative "./../accountant"

RSpec.describe Accountant do
  let(:accountant) { described_class.new }

  describe "#make_accounts" do
    let(:output) { File.read(path) }

    context "text output" do
      let(:path) { "fixtures/txt_output.txt" }

      it "makes the right accounts" do
        expect(accountant.make_accounts("* 2 * FEB-16 TEXT"))
          .to eq(output)
      end
    end

    context "csv output" do
      let(:path) { "fixtures/csv_output.txt" }

      it "makes the right accounts" do
        expect(accountant.make_accounts("40 * MAR-16 * CSV"))
          .to eq(output)
      end
    end
  end
end
