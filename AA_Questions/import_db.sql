PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id integer PRIMARY KEY,
    fname character varying NOT NULL,
    lname character varying NOT NULL
);

CREATE TABLE questions (
    id integer PRIMARY KEY,
    title character varying,
    body character varying NOT NULL,
    author_id integer NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
    id integer PRIMARY KEY,
    question_id integer NOT NULL,
    follower_id integer NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (follower_id) REFERENCES users(id)
);

CREATE TABLE replies (
    id integer PRIMARY KEY,
    body character varying NOT NULL,
    question_id integer NOT NULL,
    parent_reply_id integer,
    user_id integer NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id)
);

CREATE TABLE question_likes (
    id integer PRIMARY KEY,
    question_id integer NOT NULL,
    user_id integer NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

INSERT INTO
    users (fname, lname)
VALUES
    ('Bob', 'Darling'),
    ('Cindy', 'Locks'),
    ('Jerry', 'Jones'),
    ('Robert', 'Red'),
    ('Amy', 'Black');

INSERT INTO
    questions (title, body, author_id)
VALUES
    ('My Question', 'Why do birds fly?', (SELECT id FROM users WHERE fname = 'Jerry' AND lname = 'Jones')),
    ('Cindy''s Question', 'What in the world?', (SELECT id FROM users WHERE fname = 'Cindy' AND lname = 'Locks'));

INSERT INTO
    question_follows (question_id, follower_id)
VALUES
    (1, (SELECT id FROM users WHERE fname = 'Cindy' AND lname = 'Locks')),
    (1, (SELECT id FROM users WHERE fname = 'Bob' AND lname = 'Darling')),
    (1, (SELECT id FROM users WHERE fname = 'Amy' AND lname = 'Black')),
    (2, (SELECT id FROM users WHERE fname = 'Jerry' AND lname = 'Jones')),
    (2, (SELECT id FROM users WHERE fname = 'Amy' AND lname = 'Black'));


