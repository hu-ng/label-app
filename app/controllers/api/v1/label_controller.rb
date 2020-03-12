module Api
  module V1
    class LabelController < ApplicationController
      def create
        error = false
        begin
          shipment = EasyPost::Shipment.retrieve(label_params[:unique_id])
          shipment.buy(
            rate: shipment.lowest_rate(carriers = ['USPS'], services = ['First'])
          )
          render json: { label_link: shipment.postage_label.label_url }, status: :ok
        rescue EasyPost::Error => error
          render json: { error_code: error.code, error_http_status: error.http_status, error_message: error.message }, status: :unprocessable_entity
        end
      end

      private

      def label_params
        params.require(:label).permit(:unique_id)
      end
    end
  end
end
