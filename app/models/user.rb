# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  has_secure_password
  has_many :tickets
  has_many :events, through: :tickets


  validates(:name,     { :presence     => true })
  validates(:email,    { :uniqueness   => { case_sensitive: false }})
  validates :email, presence: true
end
