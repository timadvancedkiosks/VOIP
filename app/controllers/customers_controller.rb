class CustomersController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    customer = Customer.new(secret: params[:secret])
    customer.save if customer.valid?
    respond_to do |format|
      if customer.valid?
        db_url = "#{ENV['CLOUDANT_URL']}/#{ENV['APP_NAME']}_#{params[:secret]}"
        format.json { render json: { success: true, database_uri: db_url }.to_json }
      else
        message = params[:secret].nil? \
          ? 'No secret specified' \
          : 'User plan already exists'
        format.json { render json: { success: false, message: message }.to_json }
      end
    end
  end

  protected

    def find_customer
      @secret = params[:secret]
      raise_not_found_if_nil(@secret)
      @customer = Customer.find_by_secret(@secret)
      raise_not_found_if_nil(@customer)
      @manager = @customer.manager
    end

  private

    def raise_not_found_if_nil(sth)
      raise ActionController::RoutingError.new('Not Found') \
        if sth.nil?
    end
end