class User < ApplicationRecord
    validates :email, uniqueness: true, presence: true

    had_many(
        :submitted_urls
        class_name: 'ShortenedUrl',
        foreign_key: :user_id,
        primary_key: :id
    )
end