BEGIN;

DROP TABLE IF EXISTS "user" CASCADE;
DROP TABLE IF EXISTS "project" CASCADE;
DROP TABLE IF EXISTS "member" CASCADE;
DROP TABLE IF EXISTS "ticket" CASCADE;
DROP TABLE IF EXISTS "comment" CASCADE;
DROP TABLE IF EXISTS "ticket_tag" CASCADE;
DROP TABLE IF EXISTS "assignment_tag" CASCADE;
DROP TABLE IF EXISTS "time_category" CASCADE;
DROP TABLE IF EXISTS "assigned_ticket_tag" CASCADE;
DROP TABLE IF EXISTS "assigned_ticket_user" CASCADE;
DROP TABLE IF EXISTS "logged_time" CASCADE;
DROP TABLE IF EXISTS "mentioned_ticket" CASCADE;

COMMIT;
