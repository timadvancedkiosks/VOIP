class WelcomeController < CustomersController

  before_filter :find_customer

  def index
  end
end