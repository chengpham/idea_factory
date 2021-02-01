class Idea < ApplicationRecord
    belongs_to :user, optional: true
    has_many :reviews, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes, source: :user

    validates :title, presence: {message: 'must be provided'}, uniqueness: true
    validates :description, presence: true
end
