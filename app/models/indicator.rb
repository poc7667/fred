class Indicator
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic
  field :id, type: String
  field :name, type: String
  field :category, type: String
  field :tags, type: String
end