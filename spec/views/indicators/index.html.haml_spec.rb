require 'rails_helper'

RSpec.describe "indicators/index", :type => :view do
  before(:each) do
    assign(:indicators, [
      Indicator.create!(
        :id => "Id",
        :name => "Name",
        :category => "MyText"
      ),
      Indicator.create!(
        :id => "Id",
        :name => "Name",
        :category => "MyText"
      )
    ])
  end

  it "renders a list of indicators" do
    render
    assert_select "tr>td", :text => "Id".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
