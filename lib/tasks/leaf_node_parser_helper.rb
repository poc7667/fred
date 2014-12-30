module LeafNodeParserHelper
  module ClassMethods
  end

  module InstanceMethods

    def get_name_and_updated_at_time(html, id)
      title = html.css("#content-2columns-main h1").first.text.strip
      subtitle, updated_at = html.css("div#recent-obs-table").first.next_element.text.strip.split(id)
      title += ", #{subtitle}"
      return title.strip, DateTime.strptime(updated_at.split("Updated:").last.strip, "%Y-%m-%d %H:%M %P %Z")
    end

    def get_tags(html)
      html.css("#tags.list-bullets.tag-tooltip-selector li a").collect do |tag|
        tag.text
      end      
    end

    def get_related_categories(html)
      html.css("ul.list-bullets  a").select do  | category |
        category['href'].include? 'categories'
      end.collect do |cate|
        cate.text
      end
    end
  end 

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end