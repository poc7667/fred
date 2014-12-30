require 'rails_helper'

RSpec.describe "indicators/new", :type => :view do
  before(:each) do
    assign(:indicator, Indicator.new(
      :id => "MyString",
      :name => "MyString",
      :category => "MyText"
    ))
  end

  it "renders new indicator form" do
    render

    assert_select "form[action=?][method=?]", indicators_path, "post" do

      assert_select "input#indicator_id[name=?]", "indicator[id]"

      assert_select "input#indicator_name[name=?]", "indicator[name]"

      assert_select "textarea#indicator_category[name=?]", "indicator[category]"
    end
  end
end
