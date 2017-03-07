module OutputFormatter
  class CSV < Base
    private

    def file_header
      total_debit = JournalEntry.total_debit
      total_credit = JournalEntry.total_credit

      text = "Total Debit :#{total_debit} Total Credit :#{total_credit}\n"
      text += "Balance from account #{start_account} to #{end_account} " \
        "from period #{start_period} to #{end_period}\n\n\n"
    end

    def table_header
      text_header = "Balance:\n"
      text_header += "ACCOUNT;DESCRIPTION;DEBIT;CREDIT;BALANCE;\n"
    end

    def entry_line(*args)
      text_line = args.map { |arg| "#{arg};" }.join
      text_line += "\n"
    end

    def total_line(debit, credit, balance)
      "TOTAL;;#{debit};#{credit};#{balance};\n"
    end
  end
end
