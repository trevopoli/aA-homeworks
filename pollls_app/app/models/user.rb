# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  username   :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_username  (username)
#
class User < ApplicationRecord
    has_many :authored_polls,
        class_name: :Poll,
        foreign_key: :user_id,
        primary_id: :id 

    has_many :responses,
        class_name: :Response,
        foreign_key: :respondent_id,
        primary_id: :id
end
