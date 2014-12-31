module LeafNodeParser
  module ClassMethods
  end

  module InstanceMethods
    def parse_series_page(lnk)
      page_lnks = ([lnk] << get_remain_series_pages(lnk)).flatten
      page_lnks.each do |lnk|
        html = get_nokogiried_html(lnk)
        get_leaf_lnks(html).each do |leaf_lnk|
          next if duplicated_id?(leaf_lnk)
          parse_leaf_page(leaf_lnk)
        end
      end
    end

    def get_leaf_lnks(html)
      leaf_lnks = html.css("table  a").reject do |lnk|
        not (lnk['href'].include? 'series' )
      end
      leaf_lnks.collect do |lnk|
        lnk['href']
      end.uniq
    end

    def get_remain_series_pages(lnk)
      html = get_nokogiried_html(lnk)
      return html.css("p b").first.parent.css("a").collect do |lnk|
        lnk["href"]
      end
    end

    def parse_leaf_page(lnk)
      html = get_nokogiried_html(lnk)
      subtitle_html = html.css("#content-2columns-main h1").first.next_element
      id = lnk.split('/').last
      name, updated_at =  get_name_and_updated_at_time(html, id)
      tags = get_tags(html)
      categories = get_related_categories(html)
      date = get_date(subtitle_html)
      value = get_value(subtitle_html)
      begin
        ind = Indicator.create(
          id: id,
          name: name.split(",").join(','),
          categories: categories.join(','),
          tags: tags.join(','),
          value: value,
          date: date,
          updated_at: updated_at
          )
        p "Count: #{Indicator.all.count}  id:#{ind.name}"
      rescue Exception => e
        ap(e)
      end
    end

  end # end of

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
