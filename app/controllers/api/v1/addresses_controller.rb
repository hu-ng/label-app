module Api
  module V1
    class AddressesController < ApplicationController
      before_action :authorize_access_request!

      def index
        @addresses = current_user.addresses
        render json: @addresses
      end

      def show
        @address = current_user.addresses.find_by_id(params[:id])
        render json: @address
      end

      def create
        address = EasyPost::Address.create(
          verify: ["delivery"],
          company: address_params[:company],
          street1: address_params[:street1],
          street2: address_params[:street2],
          city: address_params[:city],
          state: address_params[:state],
          zip: address_params[:zip],
          phone: address_params[:phone]
        )

        # If address is verified
        if address.verifications.delivery.success
          @address = current_user.addresses.build(unique_id: address.id, title: address_params[:title])
          if @address.save
            render json: @address, status: :created, location: api_v1_address_path(@address)
          else
            render json: @address.errors, status: :unprocessable_entity
          end
        else
          render json: address.verifications, status: :unprocessable_entity
        end
      end

      private

      def address_params
        params.require(:address).permit(:company, :street1, :street2, :city, :state, :zip, :phone, :title)
      end
    end
  end
end
