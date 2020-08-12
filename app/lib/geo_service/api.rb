# frozen_string_literal: true

module GeoService
  class Api
    include HTTParty

    base_uri 'http://localhost:5000/v1'

    def self.geocode(city)
      options = {
        query: {
          city: city
        }
      }
      response = get('/coordinates', options)

      response.parsed_response.dig('result') if response.success?
    end
  end
end
