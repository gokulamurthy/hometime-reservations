require_relative 'payloadNormalizer'

class PayloadBNormalizer < PayloadNormalizer
  def normalize
        reservation_details = getValueFromObject(payload, 'reservation')
        guest_details = getValueFromObject(reservation_details, 'guest_details')
        {
            email: getValueFromObject(reservation_details, 'guest_email'),
            first_name: getValueFromObject(reservation_details, 'guest_first_name'),
            last_name: getValueFromObject(reservation_details, 'guest_last_name'),
            phone_numbers: getValueFromObject(reservation_details, 'guest_phone_numbers'),        
            start_date: getValueFromObject(reservation_details, 'start_date'),
            end_date: getValueFromObject(reservation_details, 'end_date'),
            nights: getValueFromObject(reservation_details, 'nights'),
            guests: getValueFromObject(reservation_details, 'number_of_guests'),
            status: getValueFromObject(reservation_details, 'status_type'),
            currency: getValueFromObject(reservation_details, 'host_currency'),
            payout_price: getValueFromObject(reservation_details, 'expected_payout_amount'),
            security_price: getValueFromObject(reservation_details, 'listed_security_price_accurate'),
            total_price: getValueFromObject(reservation_details, 'total_paid_amount_accurate'),        
            reservation_guest_detail_attributes: {  
                adults: getValueFromObject(guest_details, 'number_of_adults'),
                children: getValueFromObject(guest_details, 'number_of_children'),
                infants: getValueFromObject(guest_details, 'number_of_infants'),
                description: getValueFromObject(guest_details, 'localized_description')
            },      
        }
  end
end