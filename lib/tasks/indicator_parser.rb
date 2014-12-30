require 'curb'
require 'nokogiri'
require 'date'
require 'pry'
require 'awesome_print'

require File.expand_path('leaf_node_parser', File.dirname(__FILE__))
require File.expand_path('leaf_node_parser_helper', File.dirname(__FILE__))
require File.expand_path('category_page_parser', File.dirname(__FILE__))
include LeafNodeParser
include LeafNodeParserHelper
include CategoryPageParser

MODE = :debug

@@host = 'http://research.stlouisfed.org'

if :debug == MODE
  @@html = Nokogiri::HTML(File.read("sample_index.html"))
else
  http = Curl.get("#{@@host}/fred2/categories")
  @@html = Nokogiri::HTML(http.body_str)
end

# fred-categories-group
class IndicatorParser
  def initialize
    # @categories = get_categories
    cates = get_categories(@@html)
    # ap(cates)
    crawl_categories(cates, @@host)
    binding.pry
    leaf
  end

  def get_nokogiried_html(link)
    Nokogiri::HTML(Curl.get(@@host+link).body_str)
  end  

  def run    
  end # end of parse
end

indicator_parser = IndicatorParser.new
indicator_parser.run