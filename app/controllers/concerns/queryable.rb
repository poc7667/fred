module Queryable
  extend ActiveSupport::Concern
  attr_accessor :q, :results, :fields

  def get_results
    setup
    if (fields & ["id"]).count == 1
      results << Indicator.where(id: q["id"])
    else
      fields.each {|f| query(f) if q.has_key?(f)} 
    end
    teardown
    results
  end

  def setup
    self.q = params
    self.fields = ["name", "tags", "categories"]
    self.results = []
  end

  def query(field)
    begin
      values = q[field].gsub(/"/, '').gsub(/'/, '').split(",")
      ap(values)
      values.each do |value|
        q_result = Indicator.only(:id, :name, :categories, :tags, :date, :value).where("#{field}"=>/.*#{value}.*/).to_a
        if q_result.count > 0
          ap(q_result)
          self.results << q_result 
        end
      end      
    rescue Exception => e
      binding.pry
      ap(e)
    end
  end

  def teardown
    host = "http://localhost:3000/"
    q_str = "#{host}?"+URI::unescape(q.to_query)    
    Rails.logger.debug(q_str)
  end

end