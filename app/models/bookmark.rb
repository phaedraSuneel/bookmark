class Bookmark < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :title, length: { minimum: 8 }, presence: true, uniqueness: {case_sensitive: false}, format: {with: /\w+/}
  validates :url, format: {with: Regexp.new(URI::regexp(%w(http https)))}, presence: true

  paginates_per 25

  def to_param
    self.title.parameterize
  end
end
