require_relative 'payloadNormalizer'

class PayloadANormalizer < PayloadNormalizer

    def normalize
        guest_details = getValueFromObject(payload, 'guest')
        {
            email: getValueFromObject(guest_details, 'email'),
            first_name: getValueFromObject(guest_details, 'first_name'),
            last_name: getValueFromObject(guest_details, 'last_name'),
            phone_numbers: getValueFromObject(guest_details, 'phone'),        
            start_date: getValueFromObject(payload, 'start_date'),
            end_date: getValueFromObject(payload, 'end_date'),
            nights: getValueFromObject(payload, 'nights'),
            guests: getValueFromObject(payload, 'guests'),
            status: getValueFromObject(payload, 'status'),
            currency: getValueFromObject(payload, 'currency'),
            payout_price: getValueFromObject(payload, 'payout_price'),
            security_price: getValueFromObject(payload, 'security_price'),
            total_price: getValueFromObject(payload, 'total_price'),        
            reservation_guest_detail_attributes: { 
                adults: getValueFromObject(payload, 'adults'),
                children: getValueFromObject(payload, 'children'),
                infants: getValueFromObject(payload, 'infants'),
                description: getValueFromObject(payload, 'description')
            },      
        }
    end
end