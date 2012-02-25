require 'redcarpet'
require 'albino'


class HTMLCustomRenderer < Redcarpet::Render::HTML
  attr_accessor :toc

  def initialize arg
    @toc = []
    super arg
  end

  def block_code(code, language)
    if language
      Albino.colorize(code, language)
    else
      "<pre>#{code}</pre>"
    end
  end

  def header(text, header_level)
    @toc << {:text => text, :level => header_level}
    slug = make_slug text
    return "<h#{header_level} id=\"#{slug}\">#{text} <a href=\"##{slug}\">»</a></h#{header_level}>"
  end

  def postprocess(full_document)
    # This is a mess. It should be rewritten using a correct data structure (nested
    # arrays) and maybe erb.
    if full_document.include? "{:toc}"
      @toc = @toc[1..-1]
      first_level = @toc.first[:level]
      depth = 0
      last_level = @toc.first[:level]

      toc_html = "<div class=\"toc\">"
      toc_html << "<ul>"

      @toc.each do |head|
        if head[:level] > last_level
          toc_html << "<li><ul>"
          depth += 1
        elsif head[:level] < last_level
          [head[:level]..first_level+depth].each do |x|
            toc_html << "</ul></li>"
          end
          depth -= head[:level] - first_level
        end

        toc_html << "<li><a href=\"##{make_slug head[:text]}\">#{head[:text]}</a></li>"
        last_level = head[:level]
      end

      puts depth
      [0...depth].each do |x|
        toc_html << "</ul></li>"
      end

      toc_html << "</ul></div>"

      full_document.gsub! "{:toc}", toc_html
    end
    full_document
  end

  protected

  def make_slug(str)
    str.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end
end
