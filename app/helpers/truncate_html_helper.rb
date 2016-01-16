module TruncateHtmlHelper

  class INMString < TruncateHtml::HtmlString

    def initialize(original_html, escape_pre = false, real_len = -1)
      super(original_html)
      @escape_pre = escape_pre
    end

    def html_tokens
      if @escape_pre
        pre = 0
        scan(REGEX).map do | token |

          pre = pre + 1 if (!(token =~ /^<pre/).nil?)
          pre = pre - 1 if (token == '</pre>')

          r_len = -1
          token_tmp = token.gsub(/\s+/, ' ')
          if pre > 0
            r_len = token_tmp.length
            #Remove the end of line blanks
            token.gsub!(/(\s[^\n])+\n((\s[^\n])*)$/, "\n\\2")
          else
            token ||= token_tmp
          end

          INMString.new(token, @escape_pre, r_len)
        end
      else
        scan(REGEX).map do | token |
          INMString.new(token.gsub(/\s+/, ' '))
        end
      end
    end
  end

  def truncate_html_self(html, options={})
    return '' if html.nil?
    html_string = INMString.new(html, options.has_key?(:escape_pre) && options[:escape_pre])
    TruncateHtml::HtmlTruncator.new(html_string, options).truncate.html_safe
  end
end