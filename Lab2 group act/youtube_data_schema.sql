-- ============================================================
-- YouTube Data Journey — Relational Schema
-- Companion to Laboratory Activity No. 1: Mapping the Data
-- Journey of an Everyday Digital Service
--
-- This schema models the STRUCTURED and SEMI-STRUCTURED data
-- identified in Part A (accounts, subscriptions, video metadata,
-- views, comments, watch history) as relational tables.
-- ============================================================

-- ------------------------------------------------------------
-- 0. CREATE DATABASE
-- ------------------------------------------------------------


CREATE DATABASE youtube;

use youtube;

-- ------------------------------------------------------------
-- 1. USERS  (Creation stage — account data)
-- ------------------------------------------------------------

CREATE TABLE Users (
    user_id         INT PRIMARY KEY AUTO_INCREMENT,
    username        VARCHAR(50)  NOT NULL UNIQUE,
    email           VARCHAR(100) NOT NULL UNIQUE,
    display_name    VARCHAR(100),
    profile_picture VARCHAR(255),
    country         VARCHAR(50),
    date_created    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_creator      BOOLEAN NOT NULL DEFAULT FALSE
);

-- ------------------------------------------------------------
-- 2. CHANNELS  (a creator's account extension)
-- ------------------------------------------------------------
CREATE TABLE Channels (
    channel_id      INT PRIMARY KEY AUTO_INCREMENT,
    owner_id        INT NOT NULL,
    channel_name    VARCHAR(100) NOT NULL,
    description     TEXT,
    subscriber_count INT NOT NULL DEFAULT 0,
    date_created    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (owner_id) REFERENCES Users(user_id)
);

-- ------------------------------------------------------------
-- 3. VIDEOS  (Ingestion/Processing stage — semi-structured metadata)
-- ------------------------------------------------------------
CREATE TABLE Videos (
    video_id        INT PRIMARY KEY AUTO_INCREMENT,
    channel_id      INT NOT NULL,
    title           VARCHAR(200) NOT NULL,
    description     TEXT,
    tags            VARCHAR(255),          -- comma-separated / JSON-like
    category        VARCHAR(50),
    duration_sec    INT,
    upload_date     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    storage_url     VARCHAR(255) NOT NULL, -- pointer to unstructured file in cloud storage
    thumbnail_url   VARCHAR(255),
    view_count      BIGINT NOT NULL DEFAULT 0,
    like_count      BIGINT NOT NULL DEFAULT 0,
    dislike_count   BIGINT NOT NULL DEFAULT 0,
    status          ENUM('processing','published','archived','deleted') NOT NULL DEFAULT 'processing',
    FOREIGN KEY (channel_id) REFERENCES Channels(channel_id)
);

-- ------------------------------------------------------------
-- 4. COMMENTS  (Consumption stage — unstructured text)
-- ------------------------------------------------------------
CREATE TABLE Comments (
    comment_id      INT PRIMARY KEY AUTO_INCREMENT,
    video_id        INT NOT NULL,
    user_id         INT NOT NULL,
    comment_text    TEXT NOT NULL,
    date_posted     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    like_count      INT NOT NULL DEFAULT 0,
    parent_comment_id INT NULL,             -- for threaded replies
    FOREIGN KEY (video_id) REFERENCES Videos(video_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (parent_comment_id) REFERENCES Comments(comment_id)
);

-- ------------------------------------------------------------
-- 5. SUBSCRIPTIONS  (Creation/Consumption link)
-- ------------------------------------------------------------
CREATE TABLE Subscriptions (
    subscription_id INT PRIMARY KEY AUTO_INCREMENT,
    subscriber_id   INT NOT NULL,
    channel_id      INT NOT NULL,
    date_subscribed DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (subscriber_id) REFERENCES Users(user_id),
    FOREIGN KEY (channel_id) REFERENCES Channels(channel_id),
    UNIQUE (subscriber_id, channel_id)
);

-- ------------------------------------------------------------
-- 6. WATCH_HISTORY  (Consumption stage — behavioral/log data)
-- ------------------------------------------------------------
CREATE TABLE Watch_History (
    watch_id        INT PRIMARY KEY AUTO_INCREMENT,
    user_id         INT NOT NULL,
    video_id        INT NOT NULL,
    watch_date      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    watch_duration_sec INT NOT NULL DEFAULT 0,
    device_type     VARCHAR(50),           -- e.g., mobile, desktop, smart TV
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (video_id) REFERENCES Videos(video_id)
);

-- ------------------------------------------------------------
-- 7. VIDEO_LIKES  (Consumption stage — engagement log)
-- ------------------------------------------------------------
CREATE TABLE Video_Likes (
    like_id         INT PRIMARY KEY AUTO_INCREMENT,
    user_id         INT NOT NULL,
    video_id        INT NOT NULL,
    reaction_type   ENUM('like','dislike') NOT NULL,
    date_reacted    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (video_id) REFERENCES Videos(video_id),
    UNIQUE (user_id, video_id)
);

-- ------------------------------------------------------------
-- 8. SEARCH_LOGS  (Creation stage — query data used for recommendations)
-- ------------------------------------------------------------
CREATE TABLE Search_Logs (
    search_id       INT PRIMARY KEY AUTO_INCREMENT,
    user_id         INT NOT NULL,
    search_query    VARCHAR(255) NOT NULL,
    search_date     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- ------------------------------------------------------------
-- 9. ARCHIVE_LOG  (Archival/Disposal stage — governance & compliance)
-- ------------------------------------------------------------
CREATE TABLE Archive_Log (
    archive_id      INT PRIMARY KEY AUTO_INCREMENT,
    entity_type     ENUM('user','channel','video','comment') NOT NULL,
    entity_id       INT NOT NULL,
    action          ENUM('archived','deleted') NOT NULL,
    reason          VARCHAR(255),           -- e.g., inactivity, policy violation, user request
    action_date     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    performed_by    VARCHAR(100)            -- e.g., 'System', 'Data Governance Officer'
);

-- ============================================================
-- SAMPLE QUERIES — illustrating the data journey in SQL
-- ============================================================

-- A. Most-watched videos (Consumption stage insight)
SELECT v.title, v.view_count, c.channel_name
FROM Videos v
JOIN Channels c ON v.channel_id = c.channel_id
ORDER BY v.view_count DESC
LIMIT 10;

-- B. A user's watch history with video details (traces data lineage per user)
SELECT u.username, v.title, wh.watch_date, wh.watch_duration_sec
FROM Watch_History wh
JOIN Users u ON wh.user_id = u.user_id
JOIN Videos v ON wh.video_id = v.video_id
WHERE u.user_id = 1
ORDER BY wh.watch_date DESC;

-- C. Videos flagged for archival due to inactivity (Archival stage)
SELECT al.entity_id, v.title, al.action, al.reason, al.action_date
FROM Archive_Log al
JOIN Videos v ON al.entity_id = v.video_id
WHERE al.entity_type = 'video' AND al.action = 'archived';

-- D. Engagement summary per channel (Integration/Consumption insight)
SELECT c.channel_name,
       COUNT(DISTINCT v.video_id) AS total_videos,
       SUM(v.view_count) AS total_views,
       COUNT(DISTINCT s.subscriber_id) AS total_subscribers
FROM Channels c
LEFT JOIN Videos v ON c.channel_id = v.channel_id
LEFT JOIN Subscriptions s ON c.channel_id = s.channel_id
GROUP BY c.channel_name;
