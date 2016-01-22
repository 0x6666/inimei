module ApplicationHelper
  include UilHelper

  def full_title(page_title = '')
    base_title = 'INiMei'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def blog_owner
    request.nil? ? nil : Blog::Setting.owner(request.subdomain)
  end

  def blog_setting
    request.nil? ? nil : Blog::Setting.setting(request.subdomain)
  end

  class HTMLwithCodeRay < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
      #CodeRay.scan(code, language).div(tab_width: 2)
    end
  end

  def markdown(text)
    text.gsub!(/\r\n/, "\n")
    options = {
        autolink: true,
        space_after_headers: true,
        fenced_code_blocks: true,
        no_intra_emphasis: true,
        hard_wrap: true,
        strikethrough: true,
        filter_html: true,
        lax_html_blocks: true,
        superscript: true
    }
    markdown = Redcarpet::Markdown.new(HTMLwithCodeRay, options)
    markdown.render(h(text)).html_safe
  end

end
