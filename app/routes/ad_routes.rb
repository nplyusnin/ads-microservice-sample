# frozen_string_literal: true

class AdRoutes < Application
  AUTH_TOKEN = /\ABearer (?<token>.+)\z/.freeze

  helpers PaginationLinks

  namespace '/v1' do
    get do
      page = params[:page].presence || 1
      ads = Ad.reverse_order(:updated_at)
      ads = ads.paginate(page.to_i, Settings.pagination.page_size)
      serializer = AdSerializer.new(ads.all, links: pagination_links(ads))

      json serializer.serializable_hash
    end

    post do
      ad_params = validate_with!(AdParamsContract)
      user_id = AuthService::Api.auth(matched_token)
      coordinates = GeoService::Api.geocode(ad_params[:ad][:city])

      result = Ads::CreateService.call(
        ad: ad_params[:ad],
        user_id: user_id,
        coordinates: coordinates
      )

      if result.success?
        serializer = AdSerializer.new(result.ad)

        status 201
        json serializer.serializable_hash
      else
        status 422
        error_response result.ad
      end
    end

    def matched_token
      result = auth_header&.match(AUTH_TOKEN)
      return if result.blank?

      result[:token]
    end

    def auth_header
      request.env['HTTP_AUTHORIZATION']
    end
  end
end
