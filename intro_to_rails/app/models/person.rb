
class Person < ApplicationRecord
    validates :name, presence: true

    belongs_to(
        :house,
        class_name: 'House',
        foreign_key: :house_id,ho
        primary_key: :id
    )

end
