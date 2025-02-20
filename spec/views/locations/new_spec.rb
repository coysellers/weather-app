require 'rails_helper'

RSpec.describe "locations/new.html.erb", type: :view do # alias these paths if there's enough time
  before do
    assign(:location, Location.new)
    render
  end

  it "displays the page title" do
    expect(rendered).to have_selector('h1', text: 'Add New Location')
  end

  it "displays the form" do
    expect(rendered).to have_selector('label', text: 'Address')
    expect(rendered).to have_selector('label', text: 'IP Address')
    expect(rendered).to have_button('Add Location')
  end

  # Could use Capybara to write more of an end to end test by adding into to the field and submitting form
end