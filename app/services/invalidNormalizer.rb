require_relative 'payloadNormalizer'

class InvalidNormalizer < PayloadNormalizer
  def normalize
    {}
  end
end