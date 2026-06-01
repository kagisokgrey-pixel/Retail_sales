-- Databricks notebook source
-- Table 1: users
CREATE TABLE users (
    user_id     INT PRIMARY KEY,
    user_name   VARCHAR(100),
    country     VARCHAR(100)
);

-- Table 2: plans
CREATE TABLE plans (
    plan_id       INT PRIMARY KEY,
    plan_name     VARCHAR(100),
    monthly_price DECIMAL(10, 2)
);

-- Table 3: subscriptions
CREATE TABLE subscriptions (
    subscription_id INT PRIMARY KEY,
    user_id         INT,
    plan_id         INT,
    start_date      DATE,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (plan_id) REFERENCES plans(plan_id)
);
-- Table 4: shows
CREATE TABLE shows (
    show_id     INT PRIMARY KEY,
    show_title  VARCHAR(100),
    genre       VARCHAR(100)
);

-- Table 5: viewing_sessions
CREATE TABLE viewing_sessions (
    session_id    INT PRIMARY KEY,
    user_id       INT,
    show_id       INT,
    watch_minutes INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (show_id) REFERENCES shows(show_id)
);

--INSERTING VALUES INTO EACH TAB
-- Insert users
INSERT INTO users VALUES (1, 'Nomvula', 'Johannesburg');
INSERT INTO users VALUES (2, 'David', 'Cape Town');
INSERT INTO users VALUES (3, 'Anele', 'Durban');
INSERT INTO users VALUES (4, 'Kabelo', 'Pretoria');
INSERT INTO users VALUES (5, 'Lerato', 'Port Elizabeth');

-- Insert plans
INSERT INTO plans VALUES (10, 'Basic', 75);
INSERT INTO plans VALUES (11, 'Standard', 129);
INSERT INTO plans VALUES (12, 'Premium', 199);
INSERT INTO plans VALUES (13, 'Family', 249);
INSERT INTO plans VALUES (14, 'Mobile', 55);

-- Insert subscriptions
INSERT INTO subscriptions VALUES (501, 1, 10, '2026-01-15');
INSERT INTO subscriptions VALUES (502, 2, 11, '2026-02-01');
INSERT INTO subscriptions VALUES (503, 1, 12, '2026-03-10');
INSERT INTO subscriptions VALUES (504, 6, 11, '2026-03-20');
INSERT INTO subscriptions VALUES (505, 3, 13, '2026-04-05');
-- Insert shows
INSERT INTO shows VALUES (701, 'Comedy Hour', 'Comedy');
INSERT INTO shows VALUES (702, 'Crime Time', 'Drama');
INSERT INTO shows VALUES (703, 'Tech Tales', 'Documentary');
INSERT INTO shows VALUES (704, 'Cooking Lab', 'Lifestyle');
INSERT INTO shows VALUES (706, 'Wild Earth', 'Documentary');

-- Insert viewing_sessions
INSERT INTO viewing_sessions VALUES (901, 1, 701, 45);
INSERT INTO viewing_sessions VALUES (902, 2, 703, 30);
INSERT INTO viewing_sessions VALUES (903, 1, 702, 60);
INSERT INTO viewing_sessions VALUES (904, 7, 701, 20);
INSERT INTO viewing_sessions VALUES (905, 3, 705, 90);


--PART A :INNER JOINH--
--Qustion 1: SHOW EVERY USER WHO A SUBSCRIPTION....
SELECT users.user_id,       
       users.user_name,
       subscriptions.subscription_id,
       subscriptions.start_date
FROM users
INNER JOIN subscriptions
ON users.user_id = subscriptions.user_id;


--Reviewing the two tables to be Joined--
SELECT *
FROM users;

SELECT *
FROM subscriptions;

--Question 2 : Show every subscription with its matching plan_name and monthly price ...
   SELECT subscriptions.plan_id,   --I only bypass by reference the columns which appear to be ambigious 
         subscription_id,
         plan_name,
         monthly_price
  FROM subscriptions
  INNER JOIN plans
  ON subscriptions.plan_id=plans.plan_id;


  SELECT *
  FROM viewing_sessions;

-- Question 3 : Show every Viewing session that has a matching show ....
 SELECT session_id,
        user_id,
        show_title,
        genre,
        watch_minutes
 FROM viewing_sessions
 INNER JOIN shows
 ON viewing_sessions.show_id=shows.show_id;

 --Question 4 : Show every viewing session with user who watched it...
 SELECT user_name,
       country,
       session_id,
       show_id,
       watch_minutes
 FROM users
 INNER JOIN viewing_sessions
 ON users.user_id=viewing_sessions.user_id;

 --Question 5 : Show users along their subscriptions ,plan names ,and then price ..
SELECT user_name,
       country,
       plan_name,
       monthly_price,
       start_date
FROM users
INNER JOIN subscriptions ON users.user_id=subscriptions.user_id
INNER JOIN plans ON subscriptions.plan_id=plans.plan_id;

-- Qustion 6 : Show every user and any subscriptions they have
SELECT users.user_id,
       user_name,
       subscription_id,
       start_date
FROM users 
LEFT JOIN subscriptions  ON users.user_id = subscriptions.user_id;

-- Qustion 7 : Show every plan and the subscriptions on it
SELECT plans.plan_id,
       plan_name,
       subscription_id,
       user_id
FROM plans 
LEFT JOIN subscriptions  ON plans.plan_id = subscriptions.plan_id;


-- Question 8 : Show every show and any viewing sessions on it
SELECT shows.show_id,
       show_title,
       session_id,
       watch_minutes
FROM shows 
LEFT JOIN viewing_sessions  ON shows.show_id = viewing_sessions.show_id;

-- Question 9 : Show every viewing session and the user who watched it
SELECT session_id,
       show_id,
       watch_minutes,
       viewing_sessions.user_id,
       user_name
FROM viewing_sessions 
LEFT JOIN users  ON viewing_sessions.user_id = users.user_id;

-- Question 10 :Show every user, their plan (if any), and the monthly price
SELECT user_name,
       country,
       plan_name,
       monthly_price
FROM users 
LEFT JOIN subscriptions  ON users.user_id = subscriptions.user_id
LEFT JOIN plans          ON subscriptions.plan_id = plans.plan_id;


-- Question 11 : Show every plan AND every subscription
SELECT p.plan_id,
       plan_name,
       subscription_id,
       user_id
FROM plans p
FULL OUTER JOIN subscriptions s ON p.plan_id = s.plan_id;


-- Question 12: Show every plan AND every subscription
SELECT p.plan_id,
       plan_name,
       subscription_id,
       user_id
FROM plans p
FULL OUTER JOIN subscriptions s ON p.plan_id = s.plan_id;


-- Question 13 : Show every show AND every viewing session
SELECT sh.show_id,
       show_title,
       session_id,
       watch_minutes
FROM shows sh
FULL OUTER JOIN viewing_sessions vs ON sh.show_id = vs.show_id;



--Question 14 : Show every user AND every viewing session
SELECT u.user_id,
       user_name,
       session_id,
       show_id,
       watch_minutes
FROM users u
FULL OUTER JOIN viewing_sessions vs ON u.user_id = vs.user_id;


-- Question 15 : Show every user, every subscription, and every plan in one query
SELECT u.user_id,
       user_name,
       subscription_id,
       p.plan_id,
       plan_name
FROM users u
FULL OUTER JOIN subscriptions s ON u.user_id = s.user_id
FULL OUTER JOIN plans p         ON s.plan_id = p.plan_id;


--BONUS CHALLENGE --

-- Bonus 1 : Which users have NOT subscribed to any plan?
SELECT u.user_id,
       user_name
FROM users u
LEFT JOIN subscriptions s ON u.user_id = s.user_id
WHERE s.subscription_id IS NULL;

--Bonus 2 : Which subscriptions reference users that do NOT exist in the users table?
SELECT s.subscription_id,
       s.user_id,
       start_date
FROM subscriptions s
LEFT JOIN users u ON s.user_id = u.user_id
WHERE u.user_id IS NULL;

--Bonus 3 : Which shows have NEVER been watched?
SELECT sh.show_id,
       show_title,
       genre
FROM shows sh
LEFT JOIN viewing_sessions vs ON sh.show_id = vs.show_id
WHERE vs.session_id IS NULL;

-- Bonus 4 : Which viewing sessions reference shows that do NOT exist?
SELECT vs.session_id,
       vs.show_id,
       watch_minutes
FROM viewing_sessions vs
LEFT JOIN shows sh ON vs.show_id = sh.show_id
WHERE sh.show_id IS NULL;

-- Bonus 5 : Which plans have NO subscribers?
SELECT p.plan_id,
       plan_name,
       monthly_price
FROM plans p
LEFT JOIN subscriptions s ON p.plan_id = s.plan_id
WHERE s.subscription_id IS NULL;

