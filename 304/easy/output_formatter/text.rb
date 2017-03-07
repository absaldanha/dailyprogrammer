module OutputFormatter
  class Text < Base
    private

    def file_header
      total_debit = JournalEntry.total_debit
      total_credit = JournalEntry.total_credit

      text = "Total Debit :#{total_debit} Total Credit :#{total_credit}\n"
      text += "Balance from account #{start_account} to #{end_account} " \
        "from period #{start_period} to #{end_period}\n\n"
    end

    def table_header
      text_header = "Balance:\n"

      text_header += ["ACCOUNT", "DESCRIPTION"].map do |header|
        "#{header.ljust(16)}|"
      end.join

      text_header += ["DEBIT", "CREDIT", "BALANCE"].map do |header|
        "#{header.rjust(16)}|"
      end.join

      text_header += "\n#{"-" * 85}\n"
    end

    def entry_line(*args)
      text_line = args.first(2).map { |arg| "#{arg.ljust(16)}|" }.join
      text_line += args.last(3).map { |arg| "#{arg.rjust(16)}|" }.join
      text_line += "\n"
    end

    def total_line(debit, credit, balance)
      "#{"TOTAL".ljust(16)}|#{" " * 16}|#{debit.to_s.rjust(16)}|" \
        "#{credit.to_s.rjust(16)}|#{balance.to_s.rjust(16)}|\n"
    end
  end
end
