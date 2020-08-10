# frozen_string_literal: true

module Api
  module V1
    class SpreadsheetsController < ApplicationController
      def read
        response = ::ReadSpreadsheetService.new(params[:spreadsheet]).call

        unless response.success?
          return(
            render(
              json: { messages: response.messages },
              status: :internal_server_error
            )
          )
        end

        render(json: { data: response.data })
      end
    end
  end
end
