module Api
  module V1
    class LabelController < ApplicationController
      def create
        local_shipment = Shipment.find_by_id(label_params[:shipment_id])
        unless local_shipment.nil?
          shipment = EasyPost::Shipment.retrieve(local_shipment.unique_id)
          shipment.buy(
            rate: shipment.lowest_rate(carriers = ['USPS'], services = ['First'])
          )
          render json: { label_link: shipment.postage_label.label_url }, status: :ok
      end

      private

      def label_params
        params.require(:label).permit(:shipment_id)
      end
    end
  end
end
