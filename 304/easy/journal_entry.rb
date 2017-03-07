require_relative "data_concern"

class JournalEntry
  extend DataConcern

  def self.find_all(acc_number)
    load_data! if data_content.nil?

    data_content.find_all do |entry|
      entry[:account] == acc_number.to_i
    end.map { |entry| new entry.to_h }
  end

  def self.total_credit
    load_data! if data_content.nil?

    data_content.reduce(0) { |sum, entry| sum + entry[:credit] }
  end

  def self.total_debit
    load_data! if data_content.nil?

    data_content.reduce(0) { |sum, entry| sum + entry[:debit] }
  end

  attr_reader :account_number, :period, :debit, :credit

  def initialize(account:, period:, debit:, credit:)
    @account_number = account
    @period = Date.strptime(period, "%b-%y")
    @debit = debit
    @credit = credit
  end

  def period_between?(start_period, end_period)
    start_date = Date.strptime(start_period, "%b-%y")
    end_date = Date.strptime(end_period, "%b-%y")

    (start_date .. end_date).cover? period
  end

  def account_label
    account.label
  end

  def account
    @account ||= Account.find(@account_number)
  end
end
