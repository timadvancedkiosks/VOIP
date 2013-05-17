require 'spec_helper'

describe Manager do

  let(:customer) { Customer.create(id: "someid") }

  describe "can create" do
    let(:manager) { customer.managers.new }
    it { manager.should be_valid }
  end
end