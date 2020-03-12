require 'rails_helper'

RSpec.describe Api::V1::AddressesController, type: :controller do
  let(:user) { create(:user) }

  let(:valid_attributes) {
    {
      :name => 'Dr. Steve Brule',
      :street1 => '179 N Harbor Dr',
      :city => 'Redondo Beach',
      :state => 'CA',
      :zip => '90277',
      :country => 'US',
      :phone => '310-808-5243',
      :title => "Home"
    }
  }

  let(:invalid_attributes) {
    {
      :name => 'abc',
      :street1 => 'abc',
      :city => 'abc',
      :state => 'abc',
      :zip => 'abc',
      :country => 'abc',
      :phone => 'abc',
      :title => "Home"
    }
  }

  before do
    sign_in_as(user)
  end

  describe 'GET #index' do
    let!(:address) { create(:address, user: user, title: "Home") }

    it 'returns a success response' do
      get :index
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq address.id
    end
  end

  describe 'GET #show' do
    let!(:address) { create(:address, user: user, title: "Home") }
    before { sign_in_as(user)}

    it 'returns a success response' do
      get :show, params: { id: address.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do

    context 'with valid params' do
      it 'creates a new address' do
        expect {
          post :create, params: { address: valid_attributes }
        }.to change(Address, :count).by(1)
      end

      it 'renders a JSON response with the new address' do
        post :create, params: { address: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(api_v1_address_path(Address.last))
      end

      it 'unauth without CSRF' do
        request.headers[JWTSessions.csrf_header] = nil
        post :create, params: { address: valid_attributes }
        expect(response).to have_http_status(401)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new address' do
        post :create, params: { address: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end
