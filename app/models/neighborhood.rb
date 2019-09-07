class Neighborhood < ActiveRecord::Base
  has_many :venues, dependent: :destroy
  validates :name, presence: true, uniqueness: true
end
