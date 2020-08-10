# frozen_string_literal: true

class ReadSpreadsheetService
  include ActiveModel::Validations

  def initialize(spreadsheet)
    @spreadsheet = spreadsheet
  end

  def call
    if invalid?
      return OpenStruct.new(success?: false, errors: errors.full_messages)
    end

    data = read_spreadsheet

    OpenStruct.new(success?: true, data: data)
  rescue StandardError => e
    Rails.logger.error(e.message)
    Rails.logger.error(e.full_message)
    Rails.logger.error(e.backtrace.join("\n"))

    OpenStruct.new(success?: false, messages: e.full_message)
  end

  private

  attr_reader :spreadsheet

  def read_spreadsheet
    xlsx = Roo::Spreadsheet.open(spreadsheet)
    header = xlsx.first

    (2..xlsx.last_row).map do |i|
      Hash[[header, xlsx.row(i)].transpose]
    end
  end
end
