# frozen_string_literal: true

RSpec.describe AuthService::Api do
  describe '.auth' do
    context 'valid token' do
      let(:token) { 'validtoken' }
      let(:response) { double(HTTParty::Response, :parsed_response => parsed_response, 'success?' => true) }

      let(:parsed_response) do
        { 'meta' => {
          'user_id' => '4'
        } }
      end

      before do
        allow(AuthService::Api).to receive(:post).and_return(response)
      end

      it 'should return user id' do
        result = AuthService::Api.auth(token)

        expect(result).to eq('4')
      end
    end

    context 'invalid token' do
      let(:token) { 'invalidtoken' }
      let(:response) { double(HTTParty::Response, :parsed_response => {}, 'success?' => false) }

      before do
        allow(AuthService::Api).to receive(:post).and_return(response)
      end

      it 'should raise error ApiError' do
        result = AuthService::Api.auth(token)

        expect(result).to be_nil
      end
    end

    context 'missing token' do
      let(:token) { nil }
      let(:response) { double(HTTParty::Response, :parsed_response => {}, 'success?' => false) }

      before do
        allow(AuthService::Api).to receive(:post).and_return(response)
      end

      it 'should raise error ApiError' do
        result = AuthService::Api.auth(token)

        expect(result).to be_nil
      end
    end
  end
end
