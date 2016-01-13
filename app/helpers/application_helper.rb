module ApplicationHelper

  def full_title(page_title = '')
    base_title = 'INiMei'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  class HTMLwithCodeRay < Redcarpet::Render::HTML
    def block_code(code, language)
      CodeRay.scan(code, language).div(:tab_width=>2)
    end
  end

  def markdown(text)
    options = {
        :autolink => true,
        :space_after_headers => true,
        :fenced_code_blocks => true,
        :no_intra_emphasis => true,
        :hard_wrap => true,
        :strikethrough =>true
    }
    markdown = Redcarpet::Markdown.new(HTMLwithCodeRay, options)
    markdown.render(h(text)).html_safe
  end

end
