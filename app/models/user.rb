class User < ActiveRecord::Base
  has_many :my_events

  validates(:name,     { :presence     => true })
  validates(:email,    { :uniqueness   => { case_sensitive: false }})
end
