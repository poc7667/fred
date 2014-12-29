require 'rails_helper'

RSpec.describe "indicators/show", :type => :view do
  before(:each) do
    @indicator = assign(:indicator, Indicator.create!(
      :id => "Id",
      :name => "Name",
      :category => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Id/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
