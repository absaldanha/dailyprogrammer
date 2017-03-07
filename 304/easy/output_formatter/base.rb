module OutputFormatter
  class Base
    attr_reader :entries, :grouped_entries, :start_account, :end_account
    attr_reader :start_period, :end_period

    def initialize(entries, args)
      @entries = entries
      @grouped_entries = entries.group_by { |entry| entry.account_number }
      @start_account = args[0]
      @end_account = args[1]
      @start_period = args[2]
      @end_period = args[3]
    end

    def call
      text = file_header
      text += table_header
      grouped_entries.each do |acc_entries|
        text += entries_output(*acc_entries)
      end
      text += total
    end

    private

    def entries_output(account_number, account_entries)
      debit = total_debit_for(account_entries)
      credit = total_credit_for(account_entries)
      balance = debit - credit
      account_label = account_entries.first.account_label

      entry_line(
        account_number.to_s,
        account_label,
        debit.to_s,
        credit.to_s,
        balance.to_s,
      )
    end

    def total
      debit = total_debit_for(entries)
      credit = total_credit_for(entries)
      balance = debit - credit

      total_line(debit, credit, balance)
    end

    def total_debit_for(entries)
      entries.reduce(0) { |sum, entry| sum + entry.debit }
    end

    def total_credit_for(entries)
      entries.reduce(0) { |sum, entry| sum + entry.credit }
    end
  end
end
