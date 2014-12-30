namespace :indicator do
  task :parser => :environment do
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
      sample_html_path = File.expand_path("sample_index.html", File.dirname(__FILE__))
      @@html = Nokogiri::HTML(File.read(sample_html_path))
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
    end

    indicator_parser = IndicatorParser.new
    indicator_parser.run

  end
end