require_relative "account"
require_relative "journal_entry"
require_relative "output_formatter"

class Accountant
  def initialize
    Account.data_path = File.expand_path("files/account_chart.csv", "./../")
    JournalEntry.data_path = File.expand_path("files/journal.csv", "./../")
  end

  def make_accounts(input)
    args = parse_input(input)
    accounts = find_accounts args[0], args[1]
    valid_entries = find_entries accounts, args[2], args[3]
    build_output(valid_entries, args)
  end

  private

  def parse_input(input)
    input_values = input.split " "

    input_values.each_with_object([]).with_index do |(value, parsed), index|
      case index
      when 0, 1 then parsed << account_input(value, index)
      when 2, 3 then parsed << period_input(value, index)
      else parsed << value
      end
    end
  end

  def account_input(input, index)
    if input == "*"
      index == 0 ? 1000 : 9090
    else
      input += "0" while input.length < 4
      input.to_i
    end
  end

  def period_input(input, index)
    return input unless input == "*"
    index == 2 ? "JAN-16" : "JUL-16"
  end

  def find_accounts(start_account, end_account)
    Account.find_all_between(start_account, end_account)
  end

  def find_entries(accounts, start_period, end_period)
    accounts.each_with_object([]) do |account, entries|
      entries << account.filter_entries(start_period, end_period)
    end.flatten
  end

  def build_output(entries, args)
    if args[4] == "TEXT"
      text_formatter(entries, args).call
    elsif args[4] == "CSV"
      csv_formatter(entries, args).call
    end
  end

  def text_formatter(entries, args)
    OutputFormatter::Text.new entries, args
  end

  def csv_formatter(entries, args)
    OutputFormatter::CSV.new entries, args
  end

end
