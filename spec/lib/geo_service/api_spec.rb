# frozen_string_literal: true

RSpec.describe GeoService::Api do
  describe '.geocode' do
    context 'exists city name' do
      let(:city_name) { 'City name' }
      let(:coordinates) { [55.12, 45.82] }
      let(:response) { double(HTTParty::Response, :parsed_response => parsed_response, 'success?' => true) }

      let(:parsed_response) do
        {
          'result' => coordinates
        }
      end

      before do
        allow(GeoService::Api).to receive(:get).and_return(response)
      end

      it 'should return city coordinates' do
        result = GeoService::Api.geocode(city_name)

        expect(result).to eq(coordinates)
      end
    end

    context 'city not exists' do
      let(:city_name) { 'City not exists' }
      let(:response) { double(HTTParty::Response, :parsed_response => {}, 'success?' => false) }

      let(:parsed_response) do
        {
          'result' => nil
        }
      end

      before do
        allow(GeoService::Api).to receive(:get).and_return(response)
      end

      it 'should raise error ApiError' do
        result = GeoService::Api.geocode(city_name)

        expect(result).to be_nil
      end
    end

    context 'missing city name' do
      let(:city_name) { nil }
      let(:response) { double(HTTParty::Response, :parsed_response => {}, 'success?' => false) }

      let(:parsed_response) do
        {
          'result' => nil
        }
      end

      before do
        allow(GeoService::Api).to receive(:get).and_return(response)
      end

      it 'should raise error ApiError' do
        result = GeoService::Api.geocode(city_name)

        expect(result).to be_nil
      end
    end
  end
end
