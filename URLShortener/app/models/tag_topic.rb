
class TagTopic < ApplicationRecord
    validates :name, presence: true

    has_many :taggings,
        primary_key: :id,
        foreign_key: :tag_topic_id,
        class_name: :Tagging,
        dependent: :destroy

    has_many :shortened_urls,
        through: :taggings,
        source: :shortened_url

    def popular_links
        
    end
end