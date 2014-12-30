class Indicator
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic
  # include Mongoid::Search
  field :id, type: String
  field :name, type: String
  field :categories, type: String
  field :tags, type: String
  # search_in :tags, :category
end