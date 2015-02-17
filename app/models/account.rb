class Account < ActiveRecord::Base
  belongs_to :user
	
  validates :name, length: { minimum: 8 }, presence: true
  validates :password, presence: true

  paginates_per 25
end
