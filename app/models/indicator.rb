class Indicator
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic
  field :id, type: String
  field :name, type: String
  field :categories, type: String
  field :tags, type: String
  field :value, type: String
  field :date, type: String
  field :updated_at, type: DateTime
end