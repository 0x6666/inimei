class Visitor < ActiveRecord::Base
  has_many :blog_comments, :class_name => 'Blog::Comment'
  IP_REGEX = /((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]|[*])\.){3}(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]|[*])/

  validates :ip, presence: true,  format: {with: IP_REGEX}


  def self.get_or_create_visitor(ip)
    debugger
    return nil if ip.nil? || ip.empty?

    visitor = Visitor.find_by_ip ip
    return visitor unless visitor.nil?

    visitor = Visitor.new ip: ip
    visitor.save ? visitor : nil
  end

end
