require 'rails_helper'

RSpec.describe QueryController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
  end

  describe "Search for title " do
    it "returns title" do
      get :index, {
        title: "Railroad"
      }
    end

    it "find by id" do
      get :index, {
        id: "Q10099USQ144NNBR"
      }
    end   

    it "find by name"  do
      get :index, {
        name: "Total Number of Locomotives Assigned",
      }
    end


    it "find by tags"  do
      get :index, {
        tags: "fertilizers",
      }
    end

    it "find by multiple names" do
      get :index, {
        name: "Total Number of Locomotives Assigned,Automobile"
      }
    end

    it "find by multiple names and categories" do
      get :index,{
        categories: "Macrohistory",
        name: "Cotton,Gasoline"
      }
    end

  end



end
