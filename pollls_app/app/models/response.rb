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
    validate :not_dupplicate_response, unless: -> {answer_choice.nil?}
    validate :respondent_is_not_poll_author, unless: -> {answer_choice.nil?}

    belongs_to :answer_choice,
        class_name: :AnswerChoice,
        foreign_key: :answer_choice_id,
        primary_key: :id

    belongs_to :respondent,
        class_name: :User,
        foreign_key: :respondent_id,
        primary_key: :id

    has_one :question,
        through: :answer_choice,
        source: :question

    def sibling_responses
        self.question.responses.where.not(id: self.id)
    end

    def respondent_already_answered?
        self.sibling_responses.exists?(respondent_id: self.respondent_id)
    end

    private

    def not_dupplicate_response
        if self.respondent_already_answered?
            errors[:respondent_id] << 'cannot vote multiple times'
        end
    end

    def respondent_is_not_poll_author
        if self.question.poll.user_id = self.respondent_id
            errors[:respondent_id] << 'cannot respond to your own poll'
        end
    end
end
