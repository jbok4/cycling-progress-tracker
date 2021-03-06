class Cyclist < ActiveRecord::Base
  has_many :rides
  validates_presence_of :username, :email, :password
  has_secure_password

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    Cyclist.all.find{|cyclist| cyclist.slug == slug}
  end

end