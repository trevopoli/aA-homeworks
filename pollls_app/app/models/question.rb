# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  text       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  poll_id    :integer          not null
#
# Indexes
#
#  index_questions_on_poll_id  (poll_id)
#
class Question < ApplicationRecord
    validates :text, presence: true

    has_many :answer_choices,
        class_name: :AnswerChoice,
        foreign_key: :question_id,
        primary_key: :id

    belongs_to :poll,
        class_name: :Poll,
        foreign_key: :poll_id,
        primary_key: :id

    has_many :responses,
        through: :answer_choices,
        source: :responses

    def results
        choices = self.answer_choices
            .select("answer_choices.*, COUNT(responses.id) AS num_responses")
            .left_outer_joins(:responses)
            .group("answer_choices.id")

        choices.inject({}) do |results, choice|
            results[choice.text] = choice.num_responses; results
        end

    end
end
