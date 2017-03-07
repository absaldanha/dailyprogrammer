require_relative "data_concern"

class Account
  extend DataConcern

  attr_reader :account, :label

  def self.find(id)
    load_data! if data_content.nil?

    account = data_content.find { |account| account[:account] == id.to_i }
    account && new(account.to_h)
  end

  def self.find_all_between(start_acc, end_acc)
    load_data! if data_content.nil?

    data_content.find_all do
      |account| account[:account].between?(start_acc, end_acc)
    end.map { |account| new account.to_h }
  end

  def initialize(account:, label:)
    @account = account
    @label = label
  end

  def filter_entries(start_period, end_period)
    entries.select { |entry| entry.period_between?(start_period, end_period) }
  end

  def entries
    @entries ||= JournalEntry.find_all(account)
  end
end
