require 'zenweb'
require 'nokogiri'

class ZenwebAutolink
  VERSION = '1.0.0'
end

module Zenweb
  class Site

    # Returns all pages in the site that have a title
    # configured.
    def pages_with_titles
      html_pages.select {|page| page.config["title"] }
    end

    # Returns all the pages in the site that have a title
    # as an array of arrays, where each array's first 
    # element is a regular expression matching the page's
    # title and the second element is that page itself.
    # these are sorted so that the longest title is first
    # e.g., [[/\blong title/i,page1],[/\btitle\b/i,page2]]
    # FIXME: In the end may want to memoize this
    def pages_with_titles_as_sorted_regular_expressions
      pages_with_titles.sort_by do |page|
        page.title.size
      end.reverse.map do |page|
        [/\b#{Regexp.escape(page.title)}\b/i, page]
      end
    end
  end

  class Page
  
    # Autolinks any text in the page that matches the 
    # title of another page on the site
    def render_autolink page, content
      autolinked_html content
    end

    # Take the html and creates links to from any text
    # that matches a page's title to that page. Note that
    # it is reasonably intelligent and only makes the 
    # link if the text isn't already linked and is inside
    # a span, b, p or li element.
    # FIXME: Make it possible to override the elements
    # in which it is acceptable to autolink
    def autolinked_html(html)
      nodes = Nokogiri::HTML::fragment(html)
      acceptable_nodes_for_autolinking = %w{p li b em i}
        nodes.traverse do |node|
        next unless node.text?
        next unless acceptable_nodes_for_autolinking.include?(node.parent.name)
        node.replace(autolinked_html_fragment(node.text))
      end
      nodes.to_html
    end
    
    # Takes a fragment of text and creates links from any 
    # text that matches a page's title in that text. It 
    # matches the longest titles first.
    # FIXME: Need a way of dealing with duplicate titles
    def autolinked_html_fragment(text)
      links = []
      site.pages_with_titles_as_sorted_regular_expressions.each do |regexp,page|
        next if page == self
        next if page.title.length > text.length
        text.gsub!(regexp) do |match|
          links << "<a href='#{page.url}'>#{match}</a>"
          "%!#{links.size-1}!%"
        end
      end
      text.gsub!(/%!(\d+)!%/) do |match|
        links[$1.to_i]
      end
      text
    end
  end
end
