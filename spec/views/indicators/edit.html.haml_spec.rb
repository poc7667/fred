require 'rails_helper'

RSpec.describe "indicators/edit", :type => :view do
  before(:each) do
    @indicator = assign(:indicator, Indicator.create!(
      :id => "MyString",
      :name => "MyString",
      :category => "MyText"
    ))
  end

  it "renders the edit indicator form" do
    render

    assert_select "form[action=?][method=?]", indicator_path(@indicator), "post" do

      assert_select "input#indicator_id[name=?]", "indicator[id]"

      assert_select "input#indicator_name[name=?]", "indicator[name]"

      assert_select "textarea#indicator_category[name=?]", "indicator[category]"
    end
  end
end
