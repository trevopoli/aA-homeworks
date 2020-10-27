class ShortenedUrl < ApplicationRecord
    validates :short_url, uniqueness: true, presence: true
    validates :long_url, presence: true
    validates :user_id, presence: true
    validate :no_spamming

    belongs_to(
        :submitter,
        class_name: 'User',
        foreign_key: :user_id,
        primary_key: :id
    )

    has_many(
        :visits,
        class_name: 'Visit',
        foreign_key: :shortened_url_id,
        primary_key: :id
    )

    has_many(
        :visitors,
        -> {distinct},
        through: :visits,
        source: :visitor
    )

    def self.random_code
        loop do
            random_code = SecureRandom.urlsafe_base64(16)
            return random_code unless ShortenedUrl.exists?(short_url: random_code)
        end
    end

    def self.create_for_user_and_long_url!(user, long_url)
        ShortenedUrl.create!(
            user_id: user.id,
            long_url: long_url,
            short_url: ShortenedUrl.random_code
        )
    end

    def num_clicks
        visits.count
    end

    def num_uniques
        visitors.count
    end

    def num_recent_uniques
        visits.select('user_id').where('created_at > ?', 10.minutes.ago).distinct.count
    end

    private

    def no_spamming
        last_minute_urls = ShortenedUrl
            .where('created_at >= ?', 1.minute.ago)
            .where(user_id: user_id)
            .length

        if last_minute_urls > 5
            errors[:maximum] << 'of five urls per minute'
        end
    end
end