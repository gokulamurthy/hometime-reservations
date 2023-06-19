module PayloadHelper
    def getValueFromObject(payload, key)
        if key.in?(payload)
            return payload[key].is_a?(Array) ? payload[key].join(',') : payload[key]
        else
            return ''
        end
    end
end