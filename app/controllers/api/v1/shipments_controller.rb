module Api
  module V1
    class ShipmentsController < ApplicationController
      before_action :authorize_access_request!
      def index
        @shipments = current_user.shipments
        render json: @shipments
      end

      def show
        render json: @shipment
      end

      def create
        to_address = Address.find_by_id(shipment_params[:to_address_id])
        from_address = Address.find_by_id(shipment_params[:from_address_id])
        parcel = Parcel.find_by_id(shipment_params[:parcel_id])
        if to_address.nil? || from_address.nil? || parcel.nil?
          render json: { message: "No such address and/or parcel" }, status: :unprocessable_entity
        else
          shipment = EasyPost::Shipment.create(
            to_address: EasyPost::Address.retrieve(to_address.unique_id),
            from_address: EasyPost::Address.retrieve(from_address.unique_id),
            parcel: EasyPost::Parcel.retrieve(parcel.unique_id)
          )
          @shipment = current_user.shipments.build(unique_id: shipment.id,
                                                  to_address_id: shipment_params[:to_address_id],
                                                  from_address_id: shipment_params[:from_address_id],
                                                  parcel_id: shipment_params[:parcel_id])
          if @shipment.save
            render json: @shipment, status: :created, location: api_v1_shipment_path(@shipment)
          else
            render json: @shipment.errors, status: :unprocessable_entity
          end
        end
      end


      private

      def shipment_params
        params.require(:shipment).permit(:to_address_id, :from_address_id, :parcel_id)
      end
    end
  end
end
