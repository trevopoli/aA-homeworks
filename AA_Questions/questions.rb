require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database
    include Singleton

    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end
end

class User
    def self.find_by_id(id)
        result = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
              *
            FROM
              users
            WHERE
              id = ?
        SQL
        return nil unless results.length > 0
        
        User.new(result.first)
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

end

class Questions

end

class QuestionFollow

end

class QuestionLike

end

class Reply

end