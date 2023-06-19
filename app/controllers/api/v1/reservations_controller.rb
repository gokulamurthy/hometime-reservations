module Api
  module V1
    class ReservationsController < ApplicationController
      def create

        payload_type = params[:payload_type]
        payload = params[:payload]

        payload_normalizer = payload_normalizer_class(payload_type).new(payload)
        if payload_normalizer.payload.nil?
            render json: { errors: "Invalid payload type" }, status: :unprocessable_entity
            return
        end
        reservation_params = payload_normalizer.normalize
        guest = Guest.create_with(first_name: reservation_params[:first_name], last_name: reservation_params[:last_name], 
            phone_numbers: reservation_params[:phone]).find_or_create_by(email: reservation_params[:email])

        reservation_details = { guest: guest,
          start_date: reservation_params[:start_date],
          end_date: reservation_params[:end_date],
          nights: reservation_params[:nights],
          guests: reservation_params[:guests],
          status: reservation_params[:status],
          security_price: reservation_params[:security_price],
          payout_price: reservation_params[:payout_price],                                                  
          total_price: reservation_params[:total_price],          
          currency: reservation_params[:currency]
        }

        if params.include? :reservation_guest_detail_attributes
            reservation_details[:reservation_guest_detail_attributes] = reservation_guest_params
            reservation = Reservation.new( reservation_details )
        else
            reservation = Reservation.new( reservation_details )
        end

        if reservation.save
          render json: { message: 'Reservation created successfully' }, status: :created
        else
          render json: { errors: reservation.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        reservation = Reservation.find_by(id: params[:id])

        if reservation.nil?
          render json: { error: 'Reservation not found' }, status: :not_found
        elsif reservation.update(reservation_params)
          render json: { message: 'Reservation updated successfully' }, status: :ok
        else
          render json: { errors: reservation.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
      def show
        reservation = Reservation.find(params[:id])
        guest_detail = reservation.reservation_guest_detail

        render json: { reservation: reservation, guest_detail: guest_detail }
      end      

      private

      def reservation_params
        params.require(:reservation).permit(:email, :start_date, :end_date, :nights, :guests, :status, :security_price, :payout_price, :total_price, :currency)
      end

      def reservation_guest_params
        params.require(:reservation_guest_detail_attributes).permit(:adults, :children, :infants, :description)
      end      

      def payload_normalizer_class(payload_type)
        case payload_type
        when 'A'
            PayloadANormalizer
        when 'B'
            PayloadBNormalizer
        else
            InvalidNormalizer
        end
      end

    end
  end
end