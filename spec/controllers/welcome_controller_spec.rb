require 'spec_helper'

describe WelcomeController do

  describe "#index" do

    describe "valid customer id" do
      let(:customer) { Customer.create!(secret: "1someid") }

      before do 
        get :index, secret: customer.secret
      end

      it { response.should be_success }
    end

    describe "invalid customer id" do

      it do 
        lambda { get :index, secret: "karys" }.should \
          raise_error(ActionController::RoutingError)
      end
    end

    describe "no customer id" do

      it do 
        lambda { get :index }.should \
          raise_error(ActionController::RoutingError)
      end
    end
  end
end