require 'rails_helper'

RSpec.describe Indicator, :type => :model do

  describe "create something" do
    skip "insert new record" do
      Indicator.create id: "great123", name: "poc"
    end
  end

  describe "list all records" do
    it "list all stuff" do
      Indicator.where(:id.ne => nil).each {|x| 
        binding.pry
        p x
      }
    end
  end

end
