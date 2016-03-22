class Song < ActiveRecord::Base
  belongs_to :user
  has_many :likes

  validates :title, :author, presence: true
  validate :url_checker, if: :url

  def url_checker
    errors.add(:url, "is not a valid url") unless url =~ URI::regexp or url == ""
  end
end
