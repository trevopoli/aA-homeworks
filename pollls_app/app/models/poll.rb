# == Schema Information
#
# Table name: polls
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_polls_on_user_id  (user_id)
#
class Poll < ApplicationRecord
    belongs_to :author,
        class_name: :User,
        foreign_key: :user_id,
        primary_key: :id

    has_many :questions,
        class_name: :Question,
        foreign_key: :poll_id,
        primary_key: :id
end
