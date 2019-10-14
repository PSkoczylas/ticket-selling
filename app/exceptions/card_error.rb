class CardError < StandardError
  def initialize(msg="Something went wrong with your transaction.")
    super
  end
end
