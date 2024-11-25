# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  config.openapi_root = Rails.root.join('swagger').to_s

  config.openapi_specs = {
    'api/swagger.json' => {
      openapi: '3.0.1',
      info: {
        title: 'API',
        version: 'v1'
      },
      paths: {}
    }
  }

  config.openapi_format = :json
end
