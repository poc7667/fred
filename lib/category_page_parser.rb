module CategoryPageParser
  module ClassMethods
    
  end
  
  module InstanceMethods
    def get_categories(html)
      rtn_categories = {}
      html.css("div.fred-categories-group").each do |categories_group|
        parent_name = categories_group.css(".fred-categories-parent a strong").text
        rtn_categories[parent_name] = get_sub_categories(categories_group)
      end      
      rtn_categories
    end

    def get_sub_categories(categories_group)
      rtn_subcategories = []
      categories_group.css(".fred-categories-children").each do |children|
        children.css(".fred-categories-child").each do  |child|
          # count = child.search('.category-count').text.to_i
          # binding.pry
          child.search('.category-count').remove 
          link = child.css('a').first['href']
          child_nmae = child.text.strip
          rtn_subcategories << {name: child_nmae, link: link}
        end
      end
      rtn_subcategories
    end
    
    def crawl_categories(top_cates, server_host)
      top_cates.each do |top_cate_name, values|
        values.each do |value|
          html = Nokogiri::HTML(Curl.get(server_host+value[:link]).body_str)
          ap("#{value[:name]}:#{is_nested_a_categories(html)}")
        end
      end
    end

    def is_nested_a_categories(html)
      html.css('#content-2columns-main h2').each do |sub_html|
        return true if sub_html.text.strip == 'Categories'
      end
      return false
    end
    
  end
  
  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end