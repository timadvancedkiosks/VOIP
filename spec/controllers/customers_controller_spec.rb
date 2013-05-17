require 'spec_helper'

describe CustomersController do
  
  describe "#create" do
    
    let(:secret) { "sa123easdasd23" }

    describe "new id specified" do
      before do
        post :create, secret: secret, format: :json
      end
      it { response.body.should == { success: true, database_uri: "#{ENV['CLOUDANT_URL']}/#{ENV['APP_NAME']}_#{secret}" }.to_json }
      it { Customer.find_by_secret(secret).should_not == nil }
      it { Customer.find_by_secret(secret).manager.should_not be_nil }
    end

    describe "existing id specified" do
      before do
        Customer.create!(secret: secret)
      end
      it { expect { post :create, secret: secret, format: :json }.
        to change { Customer.count }.by(0) }
      it "should return false" do
        post :create, secret: secret, format: :json
        response.body.should == { success: false, message: 'User plan already exists' }.to_json
      end
    end

    describe "no id specified" do
      before { post :create, secret: nil, format: :json }
      it { response.body.should == { success: false, message: 'No secret specified' }.to_json }
      it { Customer.find_by_secret(secret).should == nil }
    end
  end  
end