# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount API => '/'

  # mount API Swagger documentation.
  mount GrapeSwaggerRails::Engine => '/swagger'
end
