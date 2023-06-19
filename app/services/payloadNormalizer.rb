require_relative 'payload_helper'

class PayloadNormalizer
  include PayloadHelper
  attr_reader :payload

  def initialize(payload)
    @payload = payload
  end

  def normalize
    raise NotImplementedError, 'Subclasses must implement normalize method'
  end
end