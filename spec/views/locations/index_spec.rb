require 'rails_helper'

RSpec.describe "locations/index.html.erb", type: :view do
  before do
    assign(:locations, locations)
    render
  end

  context "when locations are present" do
    let(:locations) do
      [
        Location.new(id: 1, address: "123 Main St", latitude: 40.7128, longitude: -74.0060),
        Location.new(id: 2, ip_address: "192.168.1.1", latitude: 34.0522, longitude: -118.2437)
      ]
    end

    it "displays the page title" do
      expect(rendered).to have_selector('h1', text: 'Weather Locations')
    end
  end

  context "when locations are present" do
    let(:locations) do
      []
    end

    it "displays the page title" do
      expect(rendered).to have_selector('h1', text: 'Weather Locations')
    end

    it "displays action prompt" do
      expect(rendered).to have_css('[data-testid="add-location"]')
      expect(rendered).to have_link('Add your first location', href: new_location_path)
    end
  end
end