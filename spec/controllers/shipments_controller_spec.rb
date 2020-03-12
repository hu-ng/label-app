# require 'rails_helper'
#
# RSpec.describe Api::V1::ShipmentsController, type: :controller do
#   let(:user) { create(:user) }
#
#   before do
#     sign_in_as(user)
#   end
#
#   let(:parcel) { create(:parcel, user: user)}
#   let(:from_address) { create(:address, user: user)}
#   let(:to_address) { create(:address, user: user)}
#
#   let(:valid_params_to_address) {
#     {
#       :name => 'Dr. Steve Brule',
#       :street1 => '179 N Harbor Dr',
#       :city => 'Redondo Beach',
#       :state => 'CA',
#       :zip => '90277',
#       :country => 'US',
#       :phone => '310-808-5243'
#     }
#   }
#
#   let(:valid_params_from_address) {
#     {
#       :company => 'EasyPost',
#       :street1 => '118 2nd Street',
#       :street2 => '4th Floor',
#       :city => 'San Francisco',
#       :state => 'CA',
#       :zip => '94105',
#       :phone => '415-456-7890'
#     }
#   }
#
#   let(:invalid_params_address) {
#     {
#       :name => 'abc',
#       :street1 => 'abc',
#       :city => 'abc',
#       :state => 'abc',
#       :zip => 'abc',
#       :country => 'abc',
#       :phone => 'abc'
#     }
#   }
#
#   let(:valid_params_parcel) {
#     {
#       length: 10,
#       width: 10,
#       height: 10,
#       weight: 10
#     }
#   }
#
#
#
#   describe 'GET #index' do
#     let!(:shipment) { create(:shipment, user: user,
#                                         to_address_id: to_address.id,
#                                         from_address_id: from_address.id,
#                                         parcel_id: parcel.id) }
#
#     it 'returns a success response' do
#       get :index
#       expect(response).to be_successful
#       expect(response_json.size).to eq 1
#       expect(response_json.first['id']).to eq shipment.id
#     end
#   end
#
#   describe 'GET #show' do
#     let!(:shipment) { create(:shipment, user: user,
#                                         to_address_id: to_address.id,
#                                         from_address_id: from_address.id,
#                                         parcel_id: parcel.id) }
#     before { sign_in_as(user)}
#
#     it 'returns a success response' do
#       get :show, params: { id: shipment.id }
#       expect(response).to be_successful
#     end
#   end
#
#   describe 'POST #create' do
#
#     context 'with valid params' do
#
#       let(:valid_params_shipment) {
#         {
#           from_address_id: 1,
#           to_address_id: 2,
#           parcel_id: 1
#         }
#       }
#
#       let(:invalid_params_shipment) {
#         {
#           from_address_id: 2,
#           to_address_id: 3,
#           parcel_id: 4
#         }
#       }
#
#       before do
#         post :create, params: { address: valid_params_to_address }
#         post :create, params: { address: valid_params_from_address }
#         post :create, params: { parcel: valid_params_parcel }
#       end
#
#       it 'creates a new shipment' do
#         expect {
#           p valid_params_shipment
#           post :create, params: { shipment: valid_params_shipment }
#         }.to change(Shipment, :count).by(1)
#       end
#
#       it 'renders a JSON response with the new address' do
#         post :create, params: { shipment: valid_params_shipment }
#         expect(response).to have_http_status(:created)
#         expect(response.content_type).to eq('application/json')
#         expect(response.location).to eq(api_v1_shipment_path(Shipment.last))
#       end
#
#       it 'unauth without CSRF' do
#         request.headers[JWTSessions.csrf_header] = nil
#         post :create, params: { shipment: valid_params_shipment }
#         expect(response).to have_http_status(401)
#       end
#     end
#
#     context 'with invalid params' do
#       it 'renders a JSON response with errors for the new address' do
#         post :create, params: { shipment: invalid_params_shipment }
#         expect(response).to have_http_status(:unprocessable_entity)
#         expect(response.content_type).to eq('application/json')
#       end
#     end
#   end
# end
