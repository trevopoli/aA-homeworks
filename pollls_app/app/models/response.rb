# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  answer_choice_id :integer          not null
#  respondent_id    :integer          not null
#
# Indexes
#
#  index_responses_on_answer_choice_id  (answer_choice_id)
#  index_responses_on_respondent_id     (respondent_id)
#
class Response < ApplicationRecord

    belongs_to :answer_choice,
        class_name: :AnswerChoice,
        foreign_key: :answer_choice_id,
        primary_key: :id

    belongs_to :respondent,
        class_name: :User,
        foreign_key: :respondent_id,
        primary_key: :id
end
