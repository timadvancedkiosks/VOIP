require 'spec_helper'

describe ManagersController do

  let(:customer) { Customer.create!(secret: 'somesecretid') }

  describe '#edit' do
    describe "valid customer id" do

      before do 
        get :edit, secret: customer.secret
      end

      it { assigns(:manager).should_not be_nil }
      it { assigns(:secret).should_not be_nil }
    end

    describe "invalid customer secret" do

      it do 
        lambda { get :edit, secret: "karys" }.should \
          raise_error(ActionController::RoutingError)
      end
    end

    describe "no customer secret" do

      it do 
        lambda { get :edit }.should \
          raise_error(ActionController::RoutingError)
      end
    end
  end

  describe '#update' do

    describe "url valid" do

      let(:manager) { { url: "http://www.google.com" } }
      describe "valid customer" do

        before { post :update, id: customer.manager.id, manager: manager, secret: customer.secret }
        it { response.should redirect_to(root_path(secret: customer.secret)) }
        # TODO: it should also update settings
      end

      describe "invalid customer secret" do

        it do 
          lambda { post :update, id: customer.manager.id, manager: manager, secret: "karys" }.should \
            raise_error(ActionController::RoutingError)
        end
      end

      describe "no customer id" do

        it do 
          lambda { post :update }.should \
            raise_error(ActionController::RoutingError)
        end
      end
    end
  end
end