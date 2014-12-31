class QueryController < ApplicationController
  include Queryable
  respond_to :json
  def index
    @errors = []
    begin
      render json: Oj.dump(get_results, mode: :compat)
    rescue Exception => e
      render json: { :errors => "#{e.to_s}" }
    end
  end
end
