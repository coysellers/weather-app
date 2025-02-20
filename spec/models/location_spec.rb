require 'rails_helper'

RSpec.describe Location, type: :model do
  describe "validations" do
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
  end

  describe "callbacks" do
    context "when address is changed" do
      let(:location) { Location.new(address: "123 Main St") }

      before do
        allow(location).to receive(:geocode_address).and_call_original
        location.valid?
      end

      it "calls geocode_address" do
        expect(location).to have_received(:geocode_address)
      end
    end
  end

  describe "#geocode_address" do
    let(:location) { Location.new(address: "123 Main St") }

    it "geocodes the address and sets latitude and longitude" do
      allow(location).to receive(:fetch_geocode_data).and_return({'latt' => '40.7128', 'longt' => '-74.0060'})
      
      location.send(:geocode_address)
      
      expect(location.latitude).to eq(40.7128)
      expect(location.longitude).to eq(-74.0060)
    end
  end

  # Add IP Address testing
end
