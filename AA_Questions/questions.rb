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
    attr_accessor :id, :fname, :lname

    def self.find_by_id(id)
        results = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
              *
            FROM
              users
            WHERE
              id = ?
        SQL
        return nil unless results.length > 0
        
        User.new(results.first)
    end

    def self.find_by_name(fname, lname)
        results = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
            SELECT
                *
            FROM
                users
            WHERE
                fname = ? AND lname = ?
        SQL
        return nil unless results.length > 0

        User.new(results.first)
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def authored_questions
        return nil unless @id
        Question.find_by_author_id(@id)
    end

    def authored_replies
        return nil unless @id
        Reply.find_by_author_id(@id)
    end

    def followed_questions
        QuestionFollow.followed_questions_for_user_id(self.id)
    end

    def liked_questions
        QuestionLike.liked_questions_for_user_id(self.id)
    end
end

class Question
    attr_accessor :id, :title, :body, :author_id

    def self.find_by_id(id)
        results = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
              *
            FROM
              questions
            WHERE
              id = ?
        SQL
        return nil unless results.length > 0

        Question.new(results.first)
    end

    def self.find_by_author_id(author_id)
        results = QuestionsDatabase.instance.execute(<<-SQL, author_id)
            SELECT
                *
            FROM
                questions
            WHERE
                author_id = ?
        SQL
        return nil unless results.length > 0

        results.map {|result| Question.new(result)}
    end

    def self.most_followed(n)
        QuestionFollow.most_followed_questions(n)
    end

    def initialize(options)
        @id = options['id']
        @title = options['title']
        @body = options['body']
        @author_id = options['author_id']
    end

    def followers
        QuestionFollow.followers_for_question_id(self.id)
    end

    def likers
        QuestionLike.likers_for_question_id(self.id)
    end

    def num_likes
        QuestionLike.num_likes_for_question_id(self.id)
    end

    def most_liked(n)
        QuestionLike.most_liked_questions(n)
    end
end

class QuestionFollow
attr_accessor :id, :question_id, :follower_id

    def self.find_by_id(id)
        results = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_follows
            WHERE
                id = ?
        SQL
        return nil unless results.length > 0

        QuestionFollow.new(results.first)
    end

    def self.followers_for_question_id(questions_id)
        followers = QuestionsDatabase.instance.execute(<<-SQL, questions_id)
            SELECT
                users.*
            FROM
                users
            JOIN
                question_follows ON question_follows.follower_id = users.id
            WHERE
                question_id = ?
        SQL
        return nil unless followers.length > 0

        followers.map {|follower| User.new(follower)}
    end

    def self.followed_questions_for_user_id(user_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                questions.*
            FROM
                questions
            JOIN
                question_follows ON question_follows.question_id = questions.id
            WHERE
                question_follows.follower_id = ?
        SQL
        return nil unless questions.length > 0 

        questions.map {|question| Question.new(question)}
    end

    def self.most_followed_questions(n)
        questions = QuestionsDatabase.instance.execute(<<-SQL, n)
            SELECT
                questions.*
            FROM
                questions
            JOIN
                question_follows ON question_follows.question_id = questions.id
            GROUP BY
                question_follows.question_id
            ORDER BY COUNT(question_follows.follower_id) DESC LIMIT ?
        SQL
        return nil unless questions.length > 0

        questions.map {|question| Question.new(question)}
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['question_id']
        @follower_id = options['follower_id']
    end
end

class QuestionLike
attr_accessor :id, :question_id, :user_id

    def self.find_by_id(id)
        results = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                question_likes
            WHERE
                id = ?
        SQL
        return nil unless results.length > 0

        QuestionLike.new(results.first)
    end

    def self.likers_for_question_id(question_id)
        likers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                users.*
            FROM
                users
            JOIN
                question_likes ON question_likes.user_id = users.id
            WHERE
                question_likes.question_id = ?
        SQL
        return nil unless likers.length > 0

        likers.map {|liker| User.new(liker)}
    end

    def self.num_likes_for_question_id(question_id)
        num_likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                COUNT(users.id)
            FROM
                users
            JOIN
                question_likes ON question_likes.user_id = users.id
            WHERE
                question_likes.question_id = ?
            GROUP BY 
                question_likes.question_id
        SQL

        num_likes.first.values.first
    end

    def self.liked_questions_for_user_id(user_id)
        questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                questions.*
            FROM
                questions
            JOIN
                question_likes ON question_likes.question_id = questions.id
            WHERE
                question_likes.user_id = ?
        SQL
        return nil unless questions.length > 0

        questions.map {|question| Question.new(question)}
    end

    def self.most_liked_questions(n)
        questions = QuestionsDatabase.instance.execute(<<-SQL, n)
            SELECT
                questions.*
            FROM
                questions
            JOIN
                question_likes ON question_likes.question_id = questions.id
            GROUP BY 
                question_likes.question_id
            ORDER BY COUNT(question_likes.user_id) DESC LIMIT ?
        SQL
        return nil unless questions.length > 0
            
        questions.map {|question| Question.new(question)}
    end

    def initialize(options)
        @id = options['id']
        @question_id = options['user_id']
        @user_id = options['user_id']
    end
end

class Reply
    attr_accessor :id, :body, :question_id, :parent_reply_id, :user_id
    
    def self.find_by_id(id)
        results = QuestionsDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM
                replies
            WHERE
                id = ?
        SQL
        return nil unless results.length > 0

        Reply.new(results.first)
    end

    def self.find_by_user_id(user_id)
        results = QuestionsDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                *
            FROM
                replies
            WHERE
                user_id = ?
        SQL
        return nil unless results.length > 0

        results.map {|result| Reply.new(result)}
    end

    def self.find_by_question_id(question_id)
        results = QuestionsDatabase.instance.execute(<<-SQL, question_id)
            SELECT
                *
            FROM
                replies
            WHERE
                question_id = ?
        SQL
        return nil unless results.length > 0

        result.map {|result| Reply.new(result)}
    end

    def initialize(options)
        @id = options['id']
        @body = options['body']
        @question_id = options['question_id']
        @parent_reply_id = options['parent_reply_id']
        @user_id = options['user_id']
    end

    def author
        User.find_by_id(@user_id)    
    end

    def question
        Question.find_by_id(@question_id)
    end

    def parent_reply
        Reply.find_by_id(@parent_reply_id)
    end

    def child_replies
        child_replies = QuestionsDatabase.instance.execute(<<-SQL, self.id)
            SELECT
                *
            FROM
                replies
            WHERE
                parent_reply_id = ?
        SQL
        return nil unless child_replies.length > 0

        child_replies.map {|reply| Reply.new(reply)}
    end
end