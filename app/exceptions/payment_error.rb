class PaymentError < StandardError
  def initialize(msg="Your card has been declined")
    super
  end
end
