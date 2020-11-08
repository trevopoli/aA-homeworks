# == Schema Information
#
# Table name: answer_choices
#
#  id          :bigint           not null, primary key
#  text        :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  question_id :integer          not null
#
# Indexes
#
#  index_answer_choices_on_question_id  (question_id)
#
class AnswerChoice < ApplicationRecord

    belongs_to :question,
        class_name: :Question,
        foreign_key: :question_id,
        primary_key: :id

    has_many :responses,
        class_name: :Response,
        foreign_key: :answer_choice_id,
        primary_key: :id
end
