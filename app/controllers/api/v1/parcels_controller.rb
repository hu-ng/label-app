module Api
  module V1
    class ParcelsController < ApplicationController
      before_action :authorize_access_request!
      def index
        @parcels = current_user.parcels
        render json: @parcels
      end

      def show
        @parcel = current_user.parcels.find_by_id(params[:id])
        render json: @parcel
      end

      def create
        begin
          parcel = EasyPost::Parcel.create(
            length: parcel_params[:length],
            width: parcel_params[:width],
            height: parcel_params[:height],
            weight: parcel_params[:weight]
          )

          @parcel = current_user.parcels.build(unique_id: parcel.id, title: parcel_params[:title])
          if @parcel.save
            render json: @parcel, status: :created, location: api_v1_parcel_path(@parcel)
          else
            render json: @parcel.errors, status: :unprocessable_entity
          end

        rescue EasyPost::Error => error
          render json: { error_code: error.code }, status: :unprocessable_entity
        end
      end

      private

      def parcel_params
        params.require(:parcel).permit(:length, :width, :height, :weight, :title)
      end
    end
  end
end
