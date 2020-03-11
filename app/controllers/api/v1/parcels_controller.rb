module Api
  module V1
    class ParcelsController < ApplicationController
      before_action :authorize_access_request!
      def index
        @parcels = current_user.parcels
        render json: @parcels
      end

      def show
        render json: @parcel
      end

      def create
        error = false

        begin
          parcel = EasyPost::Parcel.create(
            length: parcel_params[:length],
            width: parcel_params[:width],
            height: parcel_params[:height],
            weight: parcel_params[:weight]
          )
        rescue EasyPost::Error => error
          puts "#{error.code} (#{error.http_status}): #{error.message}"
          render json: { error_code: error.code }, status: :unprocessable_entity
        end

        unless error
          @parcel = current_user.parcels.build(unique_id: parcel.id)
          if @parcel.save
            render json: @parcel, status: :created, location: api_v1_parcel_path(@parcel)
          else
            render json: @parcel.errors, status: :unprocessable_entity
          end
        end
      end

      private

      def parcel_params
        params.require(:parcel).permit(:length, :width, :height, :weight)
      end
    end
  end
end
