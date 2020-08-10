# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :spreadsheets, only: [] do
        post :read
      end
    end
  end
end
