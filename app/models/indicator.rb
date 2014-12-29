class Indicator
  include Mongoid::Document
  field :id, type: String
  field :name, type: String
  field :category, type: String
end
