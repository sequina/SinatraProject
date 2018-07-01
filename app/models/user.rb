class User < ActiveRecord::Base
  has_many :todos
  has_secure_password
  # validates :email, :format => /@/

  def slug
    username.to_s.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    User.all.find{|user| user.slug == slug}
  end

end
