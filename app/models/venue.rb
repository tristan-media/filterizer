class Venue < ActiveRecord::Base
  belongs_to :neighborhood
  validates :neighborhood, :name, :address, :website, presence: true
  has_many :events, dependent: :destroy
end
