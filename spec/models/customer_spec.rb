require 'spec_helper'

describe Customer do
  
  describe "secret is required" do
    let(:customer) { Customer.create }
    it { customer.should_not be_valid }
  end

  describe "secret is unique" do
    let(:secret) { "5abc" }
    before { Customer.create(secret: secret) }
    let(:customer) { Customer.create(secret: secret) }
    it { customer.should_not be_valid }
  end
end