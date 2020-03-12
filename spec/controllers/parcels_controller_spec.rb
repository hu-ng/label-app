require 'rails_helper'

RSpec.describe Api::V1::ParcelsController, type: :controller do

  let(:user) { create(:user) }

  let(:valid_attributes) {
    {
      length: 10,
      width: 10,
      height: 10,
      weight: 10,
      title: "T-shirt"
    }
  }

  let(:invalid_attributes) {
    {
      length: 10,
      width: nil,
      height: 10,
      weight: nil,
      title: "T-shirt"
    }
  }

  before do
    sign_in_as(user)
  end

  describe 'GET #index' do
    let!(:parcel) { create(:parcel, user: user, title: "T-shirt") }

    it 'returns a success response' do
      get :index
      expect(response).to be_successful
      expect(response_json.size).to eq 1
      expect(response_json.first['id']).to eq parcel.id
    end
  end

  describe 'GET #show' do
    let!(:parcel) { create(:parcel, user: user, title: "T-shirt") }
    before { sign_in_as(user)}

    it 'returns a success response' do
      get :show, params: { id: parcel.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do

    context 'with valid params' do
      it 'creates a new parcel' do
        expect {
          post :create, params: { parcel: valid_attributes }
        }.to change(Parcel, :count).by(1)
      end

      it 'renders a JSON response with the new parcel' do
        post :create, params: { parcel: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(api_v1_parcel_path(Parcel.last))
      end

      it 'unauth without CSRF' do
        request.headers[JWTSessions.csrf_header] = nil
        post :create, params: { parcel: valid_attributes }
        expect(response).to have_http_status(401)
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new parcel' do
        post :create, params: { parcel: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end
