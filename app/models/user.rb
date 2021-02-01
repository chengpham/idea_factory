class User < ApplicationRecord
    has_many :ideas, dependent: :nullify
    has_many :reivews, dependent: :nullify
    has_many :likes, dependent: :nullify
    has_many :liked_ideas, through: :likes, source: :idea

    has_secure_password
    validates :name, presence: {message: "should be present."}
    validates :email, presence: true, uniqueness: true

    def full_name
        "#{self.name}".strip.titleize
    end
end
