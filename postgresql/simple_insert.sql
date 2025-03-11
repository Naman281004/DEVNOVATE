INSERT INTO event_platform_simple.users (id, email, first_name, last_name, about, created_at, updated_at) VALUES
(1, 'user1@example.com', 'FirstName1', 'LastName1', 'This is user 1.', '2024-12-19 16:56:39', '2025-03-11 16:56:39'),
(2, 'user2@example.com', 'FirstName2', 'LastName2', 'This is user 2.', '2024-12-13 16:56:39', '2025-03-11 16:56:39'),
(3, 'user3@example.com', 'FirstName3', 'LastName3', 'This is user 3.', '2024-12-26 16:56:39', '2025-03-11 16:56:39'),
(4, 'user4@example.com', 'FirstName4', 'LastName4', 'This is user 4.', '2024-12-29 16:56:39', '2025-03-11 16:56:39'),
(5, 'user5@example.com', 'FirstName5', 'LastName5', 'This is user 5.', '2025-01-10 16:56:39', '2025-03-11 16:56:39');


INSERT INTO event_platform_simple.events (id, title, description, start_date, end_date, location, organizer_id, created_at, updated_at) VALUES
(1, 'Event 1', 'This is the description for event 1.', '2025-03-23 16:56:43', '2025-04-16 16:56:43', 'Location 1', 4, '2024-12-09 16:56:43', '2025-03-11 16:56:43'),
(2, 'Event 2', 'This is the description for event 2.', '2025-04-04 16:56:43', '2025-04-16 16:56:43', 'Location 2', 4, '2025-01-08 16:56:43', '2025-03-11 16:56:43'),
(3, 'Event 3', 'This is the description for event 3.', '2025-03-15 16:56:43', '2025-04-21 16:56:43', 'Location 3', 1, '2025-01-20 16:56:43', '2025-03-11 16:56:43'),
(4, 'Event 4', 'This is the description for event 4.', '2025-03-31 16:56:43', '2025-05-05 16:56:43', 'Location 4', 2, '2025-02-01 16:56:43', '2025-03-11 16:56:43'),
(5, 'Event 5', 'This is the description for event 5.', '2025-03-24 16:56:43', '2025-04-20 16:56:43', 'Location 5', 1, '2025-01-30 16:56:43', '2025-03-11 16:56:43');


INSERT INTO event_platform_simple.event_settings (event_id, landing_page_config, registration_config, team_formation_enabled) VALUES
(1, '{"theme": "Theme 1", "layout": "Layout 1"}', '{"max_participants": 200, "fee": 0}', false),
(2, '{"theme": "Theme 2", "layout": "Layout 2"}', '{"max_participants": 117, "fee": 15}', false),
(3, '{"theme": "Theme 3", "layout": "Layout 3"}', '{"max_participants": 127, "fee": 6}', true),
(4, '{"theme": "Theme 4", "layout": "Layout 4"}', '{"max_participants": 147, "fee": 90}', true),
(5, '{"theme": "Theme 5", "layout": "Layout 5"}', '{"max_participants": 75, "fee": 17}', true);



INSERT INTO event_platform_simple.participants (id, user_id, event_id, registration_date, status) VALUES
(1, 1, 1, '2025-02-11 16:56:52', 'attended'),
(2, 2, 1, '2025-02-24 16:56:52', 'cancelled'),
(3, 3, 1, '2025-03-08 16:56:52', 'attended'),
(4, 1, 2, '2025-02-21 16:56:52', 'confirmed'),
(5, 2, 2, '2025-03-07 16:56:52', 'attended'),
(6, 3, 2, '2025-03-08 16:56:52', 'registered'),
(7, 1, 3, '2025-02-17 16:56:52', 'cancelled'),
(8, 2, 3, '2025-02-15 16:56:52', 'registered'),
(9, 3, 3, '2025-02-22 16:56:52', 'confirmed'),
(10, 1, 4, '2025-02-19 16:56:52', 'cancelled'),
(11, 2, 4, '2025-02-11 16:56:52', 'registered'),
(12, 3, 4, '2025-03-07 16:56:52', 'cancelled'),
(13, 1, 5, '2025-02-21 16:56:52', 'confirmed'),
(14, 2, 5, '2025-02-11 16:56:52', 'attended'),
(15, 3, 5, '2025-03-10 16:56:52', 'cancelled');



INSERT INTO event_platform_simple.teams (id, event_id, name, description, created_at) VALUES
(1, 1, 'Team 1', 'This is the description for team 1.', '2025-02-07 16:56:56'),
(2, 2, 'Team 2', 'This is the description for team 2.', '2025-01-29 16:56:56'),
(3, 3, 'Team 3', 'This is the description for team 3.', '2025-02-17 16:56:56'),
(4, 4, 'Team 4', 'This is the description for team 4.', '2024-12-02 16:56:56'),
(5, 5, 'Team 5', 'This is the description for team 5.', '2025-03-10 16:56:56');



INSERT INTO event_platform_simple.team_members (team_id, participant_id, joined_at) VALUES
(1, 1, '2025-03-01 16:57:05'),
(1, 2, '2025-02-20 16:57:05'),
(1, 3, '2025-03-03 16:57:05'),
(2, 4, '2025-02-15 16:57:05'),
(2, 5, '2025-03-03 16:57:05'),
(2, 6, '2025-02-21 16:57:05'),
(3, 7, '2025-03-09 16:57:05'),
(3, 8, '2025-03-05 16:57:05'),
(3, 9, '2025-02-10 16:57:05'),
(4, 10, '2025-02-11 16:57:05'),
(4, 11, '2025-02-25 16:57:05'),
(4, 12, '2025-02-14 16:57:05'),
(5, 13, '2025-02-24 16:57:05'),
(5, 14, '2025-02-17 16:57:05'),
(5, 15, '2025-02-18 16:57:05');



INSERT INTO event_platform_simple.projects (id, team_id, event_id, title, description, github_url, demo_url, created_at, updated_at) VALUES
(1, 1, 1, 'Project 1', 'This is the description for project 1.', 'https://github.com/example/project1', 'https://example.com/demo1', '2025-01-31 16:57:12', '2025-03-11 16:57:12'),
(2, 2, 2, 'Project 2', 'This is the description for project 2.', 'https://github.com/example/project2', 'https://example.com/demo2', '2025-03-10 16:57:12', '2025-03-11 16:57:12'),
(3, 3, 3, 'Project 3', 'This is the description for project 3.', 'https://github.com/example/project3', 'https://example.com/demo3', '2024-12-24 16:57:12', '2025-03-11 16:57:12'),
(4, 4, 4, 'Project 4', 'This is the description for project 4.', 'https://github.com/example/project4', 'https://example.com/demo4', '2025-02-12 16:57:12', '2025-03-11 16:57:12'),
(5, 5, 5, 'Project 5', 'This is the description for project 5.', 'https://github.com/example/project5', 'https://example.com/demo5', '2025-03-06 16:57:12', '2025-03-11 16:57:12');




