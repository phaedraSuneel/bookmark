class Account < ActiveRecord::Base
	belongs_to :user
	
  validates :name, length: { minimum: 8 }, presence: true, uniqueness: {case_sensitive: false}, format: {with: /\w+/}
  validates :password, presence: true

  paginates_per 25

  def to_param
    self.name
  end
end
