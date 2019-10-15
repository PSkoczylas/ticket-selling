class RequestedAmountError < StandardError
  def initialize(msg="Requested quantity is more than available")
    super
  end
end
