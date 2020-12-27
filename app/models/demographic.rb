class Demographic < ApplicationRecord
  belongs_to :tag

  has_many :titles, through: :tag

  validates :tag, uniqueness: true
end