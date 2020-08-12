# frozen_string_literal: true

module AuthService
  class Api
    include HTTParty

    base_uri 'http://localhost:4000/v1/'

    def self.auth(token)
      options = { headers: {
        'AUTHORIZATION' => "Bearer #{token}"
      } }
      response = post('/auth', options)

      response.parsed_response.dig('meta', 'user_id') if response.success?
    end
  end
end

# token = "eyJhbGciOiJIUzI1NiJ9.eyJ1dWlkIjoiYWRkMWM5YTYtYjQ2Ni00NzUxLWFhZjItOGM5MWM2ODgwYzYwIn0.OLjM6wQu8V5RI9EicNg0f3Dvye-VqNu5fTUKf0Nv3N8"
