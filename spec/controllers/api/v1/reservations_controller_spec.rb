require 'rails_helper'

RSpec.describe Api::V1::ReservationsController, type: :controller do
  describe 'POST #create' do
    let(:payload) { { payload_type: payload_type, payload: payload_data } }

    context 'when payload type is A' do
      let(:payload_type) { 'A' }
      let(:payload_data) { 
        {
            reservation_code: "YYY12345678",
            start_date: "2021-04-14",
            end_date: "2021-04-18",
            nights: 4,
            guests: 4,
            adults: 2,
            children: 2,
            infants: 0,
            status: "accepted",
            guest: {
                first_name: "Wayne",
                last_name: "Woodbridge",
                phone: "639123456789",
                email: "wayne_woodbridge@bnb.com"
            },
            currency: "AUD",
            payout_price: "4200.00",
            security_price: "500",
            total_price: "4700.00"
        } 
        }

      it 'creates a reservation with normalized valid payload' do
        post :create, params: payload
        expect(response).to have_http_status(:created)

        reservation = Reservation.last
        expect(reservation.guest.email).to eq(payload_data[:guest][:email])
        expect(reservation.start_date.to_s).to eq(payload_data[:start_date])
        expect(reservation.end_date.to_s).to eq(payload_data[:end_date])        
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['message']).to eq('Reservation created successfully')
      end

      it 'returns an error when end date is greater than start date' do
        payload_data[:end_date] = '2021-04-10'
        expect do
          post :create, params: payload
        end.not_to change(Reservation, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to include('End date must be after or equal to 2021-04-14')
      end

    end


    context 'when payload type is B' do
      let(:payload_type) { 'B' }
      let(:payload_data) { 
        {
            "reservation": {
                "code": "XXX12345678",
                "start_date": "2021-03-12",
                "end_date": "2021-03-16",
                "expected_payout_amount": "3800.00",
                "guest_details": {
                "localized_description": "4 guests",
                "number_of_adults": 2,
                "number_of_children": 2,
                "number_of_infants": 0
            },
            "guest_email": "wayne_woodbridge@bnb.com",
            "guest_first_name": "Wayne",
            "guest_last_name": "Woodbridge",
            "guest_phone_numbers": [
                "639123456789",
                "639123456789"
            ],
            "listing_security_price_accurate": "500.00",
            "host_currency": "AUD",
            "nights": 4,
            "number_of_guests": 4,
            "status_type": "accepted",
            "total_paid_amount_accurate": "4300.00"
            }
       }
    }

      it 'creates a reservation with normalized payload' do
        post :create, params: payload
        expect(response).to have_http_status(:created)

        reservation = Reservation.last
        expect(reservation.guest.email).to eq(payload_data[:reservation][:guest_email])
        expect(reservation.start_date.to_s).to eq(payload_data[:reservation][:start_date])
        expect(reservation.end_date.to_s).to eq(payload_data[:reservation][:end_date])        
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['message']).to eq('Reservation created successfully')
      end

      it 'returns an error when end date is lesser than start date' do
        payload_data[:reservation][:end_date] = '2021-03-10'
        expect do
          post :create, params: payload
        end.not_to change(Reservation, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to include('End date must be after or equal to 2021-03-12')
      end

    end

    context 'when payload type is invalid' do
      let(:payload_type) { 'C' }
      let(:payload_data) { {} }

      it 'returns an error response' do
        post :create, params: payload
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)['errors']).to include('Invalid payload type')
      end
    end
  end

  describe 'PATCH #update' do
    context 'when reservation exists' do
      let(:email) { 'john@example.com' }
      let(:start_date) { "2021-03-12" }
      let(:end_date) { "2021-03-16" }
      let(:nights) { 4 } 
      let(:guests) { 4 } 
      let(:status) { "accepted" }
      let(:security_price) { 100.00 }
      let(:payout_price) { 900.00 }      
      let(:total_price) { 1000.00 }
      let(:currency) { "AUD" }
      let(:reservation) { Reservation.create(start_date: start_date, end_date: end_date, nights: nights,
             guests: guests, status: status, security_price: security_price, payout_price: payout_price, total_price: total_price, currency: currency,
             guest: Guest.create(email: email)) }

      it 'updates the reservation' do
        patch :update, params: { id: reservation.id, reservation: { status: 'accepted', guests: 3 } }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['message']).to eq('Reservation updated successfully')

        reservation.reload
        expect(reservation.status).to eq('accepted')
        expect(reservation.guests).to eq(3)
      end
    end

    context 'when reservation does not exist' do
      it 'returns an error' do
        patch :update, params: { id: 123, reservation: { status: 'accepted' } }

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('Reservation not found')
      end
    end
  end  
end
