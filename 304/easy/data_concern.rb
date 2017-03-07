require "csv"

module DataConcern
  @data_path = nil
  @data_content = nil

  def data_path=(path)
    fail Errno::ENOENT.new unless File.exist?(path)
    @data_path = path
  end

  def data_path
    @data_path
  end

  def data_content
    @data_content
  end

  private

  def load_data!
    fail StandardError.new "No data path" if data_path.nil?
    file_contents = File.read(data_path)
    @data_content = ::CSV.parse(
      file_contents,
      headers: true,
      col_sep: ";",
      header_converters: :symbol,
      converters: :all
    )
  end
end
