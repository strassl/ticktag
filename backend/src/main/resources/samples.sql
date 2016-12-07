BEGIN;

UPDATE "ticket" SET "description_comment_id" = NULL;
UPDATE "ticket_tag_group" SET "default_ticket_tag_id" = NULL;
DELETE FROM "ticket_event_comment_text_changed" CASCADE;
DELETE FROM "ticket_event_current_estimated_time_changed" CASCADE;
DELETE FROM "ticket_event_due_date_changed" CASCADE;
DELETE FROM "ticket_event_initial_estimated_time_changed" CASCADE;
DELETE FROM "ticket_event_logged_time_added" CASCADE;
DELETE FROM "ticket_event_logged_time_removed" CASCADE;
DELETE FROM "ticket_event_mention_added" CASCADE;
DELETE FROM "ticket_event_parent_changed" CASCADE;
DELETE FROM "ticket_event_state_changed" CASCADE;
DELETE FROM "ticket_event_story_points_changed" CASCADE;
DELETE FROM "ticket_event_tag_added" CASCADE;
DELETE FROM "ticket_event_tag_removed" CASCADE;
DELETE FROM "ticket_event_title_changed" CASCADE;
DELETE FROM "ticket_event_user_added" CASCADE;
DELETE FROM "ticket_event_user_removed" CASCADE;
DELETE FROM "ticket_event" CASCADE;
DELETE FROM "logged_time" CASCADE;
DELETE FROM "time_category" CASCADE;
DELETE FROM "assigned_ticket_user" CASCADE;
DELETE FROM "assignment_tag" CASCADE;
DELETE FROM "assigned_ticket_tag" CASCADE;
DELETE FROM "comment" CASCADE;
DELETE FROM "ticket" CASCADE;
DELETE FROM "ticket_tag" CASCADE;
DELETE FROM "ticket_tag_group" CASCADE;
DELETE FROM "member" CASCADE;
DELETE FROM "project" CASCADE;
DELETE FROM "user_image" CASCADE;
DELETE FROM "user" CASCADE;

INSERT INTO public."user" (id, username, mail, name, password_hash, role, current_token) VALUES
  ('00000000-0001-0000-0000-000000000001', 'user_a', 'a@a.a', 'Mr. A',
   '$2a$10$mTEkiQq2Wo./aqfekJHPk.5sG8JLWqWYbtMODwk9xQwQp0GtkCiM.', 'ADMIN', '00000000-0001-0000-0000-abcdef123641'); --aaaa
INSERT INTO public."user" (id, username, mail, name, password_hash, role, current_token) VALUES
  ('00000000-0001-0000-0000-000000000002', 'user_b', 'b@b.b', 'Berta Berta',
   '$2a$10$Ydzo0FR5x8ZweeaeIQS2gevmLqsZuS37.bWRYy.f.u62NG00MAOcS', 'USER', '00000000-0001-0000-2343-abcdef123641'); --bbbb
INSERT INTO public."user" (id, username, mail, name, password_hash, role, current_token) VALUES
  ('00000000-0001-0000-0000-000000000003', 'user_c', 'c@c.c', 'Gaius Iulius Caesar',
   '$2a$10$OgvbSbiDxizgC/6K3dhVwO8iY6.QFS6f2PvE1AyJS1Vmo6Rnb3Gve', 'OBSERVER', '00000000-0001-8676-0000-abcdef123641'); --cccc
INSERT INTO public."user" (id, username, mail, name, password_hash, role, current_token) VALUES
  ('00000000-0000-0000-0000-000000000000', 'admin', 'admin@admin.invalid', 'Admin',
   '$2a$10$dXjkyD704.vNyYWrsmEbrewcMeWIz1fDcjVVuggUyLmExGQQD3RGC', 'ADMIN', '9a030c2e-b2c7-4d98-825b-92c148897f4a');
INSERT INTO public."user" (id, username, mail, name, password_hash, role, current_token) VALUES
  ('660f2968-aa46-4870-bcc5-a3805366cff2', 'drasko', 'stefan.draskovits@test.at', 'Stefan Draskovits',
   '$2a$10$NuX1RqGiFg38qjF75b88J.oWw271xVYhsPvLRxHAQHnS2V9i0nNza', 'ADMIN', '4aa33174-bdf2-4d33-b80f-d7fb8d121923'); --stefan-supersecure
INSERT INTO public."user" (id, username, mail, name, password_hash, role, current_token) VALUES
  ('93ef43d9-20b7-461a-b960-2d1e89ba099f', 'heinzl', 'michael.heinzl@test.de', 'Michael Heinzl',
   '$2a$10$.dLg4Vgt7JrP.564p/tPQOm.TLoy3HieFP1ZpnyWVPkJDYrG6r.Ce', 'OBSERVER', '370f4e86-1ebf-4b70-a113-add96d0905e1'); --michael-supersecure
INSERT INTO public."user" (id, username, mail, name, password_hash, role, current_token) VALUES
  ('00000000-0001-0000-0000-000000000004', 'cannot', 'adsf@asdf.ad', 'I Can Nothing the Second',
   '$2a$10$mTEkiQq2Wo./aqfekJHPk.5sG8JLWqWYbtMODwk9xQwQp0GtkCiM.', 'USER', '4aa33174-0001-4d33-0000-add96d0905e1'); --aaaa

-- BEGIN all role/project role member permutations DO NOT ALTER
INSERT INTO public."user" (id, username, mail, name, password_hash, role, current_token) VALUES
  ('00000000-0001-0000-0000-000000000101', 'admit', 'admin@ticktag.a', 'Admiral Admin',
   '$2a$10$mTEkiQq2Wo./aqfekJHPk.5sG8JLWqWYbtMODwk9xQwQp0GtkCiM.', 'ADMIN', '00000000-0001-0000-0000-abcdef123641'); --aaaa
INSERT INTO public."user" (id, username, name, mail, password_hash, role, current_token) VALUES
  ('00000000-0001-0000-0000-000000000102', 'obelix', 'observer@ticktag.a', 'Obelix Observer',
   '$2a$10$Ydzo0FR5x8ZweeaeIQS2gevmLqsZuS37.bWRYy.f.u62NG00MAOcS', 'OBSERVER', '00000000-0001-0000-2343-abcdef123641'); --bbbb
INSERT INTO public."user" (id, username, name, mail, password_hash, role, current_token) VALUES
  ('00000000-0001-0000-0000-000000000103', 'userla', 'user1@ticktag.a', 'Ursula User',
   '$2a$10$OgvbSbiDxizgC/6K3dhVwO8iY6.QFS6f2PvE1AyJS1Vmo6Rnb3Gve', 'USER', '00000000-0001-8676-0000-abcdef123641'); --cccc
-- END all role/project role member permutations DO NOT ALTER


INSERT INTO "project" VALUES
  ('00000000-0002-0000-0000-000000000001', 'Bitchip', 'Pfizer Consumer Healthcare', '2016-07-03 08:49:05', NULL),
  ('00000000-0002-0000-0000-000000000002', 'Veribet', 'H E B', '2016-08-26 21:57:39', NULL),
  ('00000000-0002-0000-0000-000000000003', 'Alpha', 'Major Pharmaceuticals', '2016-01-17 16:00:33', NULL),
  ('00000000-0002-0000-0000-000000000004', 'Home Ing', 'Publix Super Markets Inc', '2016-03-13 04:21:56', NULL),
  ('00000000-0002-0000-0000-000000000005', 'Holdlamis', 'Cal Pharma', '2016-01-02 01:03:12', NULL),
  ('00000000-0002-0000-0000-000000000006', 'Duobam', 'Proficient Rx LP', '2016-09-29 16:27:21', NULL),
  ('00000000-0002-0000-0000-000000000007', 'Keylex', 'CHANEL PARFUMS BEAUTE', '2015-02-13 09:07:10', NULL),
  ('00000000-0002-0000-0000-000000000008', 'Prodder', 'Nova Homeopathic Therapeutics, Inc.', '2015-11-25 02:56:38', NULL),
  ('00000000-0002-0000-0000-000000000009', 'Holdlamis', 'McKesson Corporation', '2016-03-27 12:41:13', NULL),
  ('00000000-0002-0000-0000-000000000010', 'Asoka', 'Beutlich Pharmaceuticals LLC', '2015-12-11 03:32:52', NULL),
  ('00000000-0002-0000-0000-000000000011', 'Y-Solowarm', 'Apotheca Company', '2015-01-29 21:31:50', NULL),
  ('00000000-0002-0000-0000-000000000012', 'Flowdesk', 'REMEDYREPACK INC.', '2015-04-06 14:47:07', NULL),
  ('00000000-0002-0000-0000-000000000013', 'Asoka', 'Ecolab Inc.', '2016-03-01 03:51:11', NULL),
  ('00000000-0002-0000-0000-000000000014', 'Domainer', 'Barr Laboratories Inc.', '2016-08-01 04:11:30', NULL),
  ('00000000-0002-0000-0000-000000000015', 'Bamity', 'CVS Pharmacy', '2016-03-24 17:48:19', NULL),
  ('00000000-0002-0000-0000-000000000016', 'Otcom', 'Legacy Pharmaceutical Packaging', '2014-11-24 13:49:23', NULL),
  ('00000000-0002-0000-0000-000000000017', 'Voltsillam', 'STAT Rx USA LLC', '2015-09-27 20:29:49', NULL),
  ('00000000-0002-0000-0000-000000000018', 'Overhold', 'Physicians Total Care, Inc.', '2016-01-01 00:10:40', NULL),
  ('00000000-0002-0000-0000-000000000019', 'It', 'Procter & Gamble Manufacturing Company', '2016-04-22 18:36:36', NULL),
  ('00000000-0002-0000-0000-000000000020', 'Sonsing', 'Bare Escentuals Beauty Inc.', '2016-07-02 06:35:50', NULL),
  ('00000000-0002-0000-0000-000000000021', 'Lotstring', 'Baxter Healthcare Corporation', '2015-06-07 02:07:32', NULL),
  ('00000000-0002-0000-0000-000000000022', 'Sonsing', 'ALK-Abello, Inc.', '2015-07-23 03:06:10', NULL),
  ('00000000-0002-0000-0000-000000000023', 'Biodex', 'Cardinal Health', '2015-10-16 08:39:17', NULL),
  ('00000000-0002-0000-0000-000000000024', 'Quo Lux', 'Natural Health Supply', '2016-11-05 14:21:54', NULL),
  ('00000000-0002-0000-0000-000000000025', 'Alpha', 'Nelco Laboratories, Inc.', '2016-01-10 19:14:31', NULL),
  ('00000000-0002-0000-0000-000000000026', 'Alphazap', 'Bristol-Myers Squibb de Mexico, S. de R.L. de C.V.', '2015-08-19 08:26:39', NULL),
  ('00000000-0002-0000-0000-000000000027', 'Aerified', 'Migranade Inc.', '2015-11-09 04:50:37', NULL),
  ('00000000-0002-0000-0000-000000000028', 'Holdlamis', 'Ventura Corporation, LTD', '2015-08-25 19:25:52', NULL),
  ('00000000-0002-0000-0000-000000000029', 'Toughjoyfax', 'Lake Erie Medical & Surgical Supply DBA Quality Care Products LLC', '2016-03-22 03:15:08', NULL),
  ('00000000-0002-0000-0000-000000000030', 'Stim', 'REMEDYREPACK INC.', '2014-12-20 11:11:48', NULL),
  ('00000000-0002-0000-0000-000000000031', 'Matsoft', 'Energizer Personal Care LLC', '2015-11-24 20:48:37', NULL),
  ('00000000-0002-0000-0000-000000000032', 'Alphazap', 'Sun Pharmaceutical Industries Limited', '2015-01-22 12:35:45', NULL),
  ('00000000-0002-0000-0000-000000000033', 'Holdlamis', 'Prasco Laboratories', '2015-10-21 11:47:18', NULL),
  ('00000000-0002-0000-0000-000000000034', 'Hatity', 'Kareway Product, Inc.', '2016-08-07 05:56:37', NULL),
  ('00000000-0002-0000-0000-000000000035', 'Stringtough', 'West-ward Pharmaceutical Corp', '2016-09-04 11:47:27', NULL),
  ('00000000-0002-0000-0000-000000000036', 'Toughjoyfax', 'ALK-Abello, Inc.', '2015-03-21 16:50:20', NULL),
  ('00000000-0002-0000-0000-000000000037', 'Daltfresh', 'Delon Laboratories (1990) Ltd', '2015-08-28 05:23:49', NULL),
  ('00000000-0002-0000-0000-000000000038', 'Bigtax', 'Cardinal Health', '2016-09-26 17:56:34', NULL),
  ('00000000-0002-0000-0000-000000000039', 'Lotstring', 'PD-Rx Pharmaceuticals, Inc.', '2016-05-18 13:08:47', NULL),
  ('00000000-0002-0000-0000-000000000040', 'Latlux', 'Walgreen Company', '2016-09-10 11:20:08', NULL),
  ('00000000-0002-0000-0000-000000000041', 'Kanlam', 'Kmart Corporation', '2016-11-10 10:23:48', NULL),
  ('00000000-0002-0000-0000-000000000042', 'Asoka', 'Sandoz Inc', '2015-10-02 14:20:11', NULL),
  ('00000000-0002-0000-0000-000000000043', 'Bytecard', 'Kinray', '2015-07-22 04:55:46', NULL),
  ('00000000-0002-0000-0000-000000000044', 'Ronstring', 'A-S Medication Solutions LLC', '2015-07-17 08:58:21', NULL),
  ('00000000-0002-0000-0000-000000000045', 'Sonsing', 'Lancaster S.A.M.', '2016-02-02 22:33:57', NULL),
  ('00000000-0002-0000-0000-000000000046', 'Flexidy', 'Natures Way Holding Co', '2015-10-14 03:40:42', NULL),
  ('00000000-0002-0000-0000-000000000047', 'Bigtax', 'American Sales Company', '2015-03-17 00:05:49', NULL),
  ('00000000-0002-0000-0000-000000000048', 'Sonair', 'WAL-MART STORES INC', '2016-01-07 18:13:31', NULL),
  ('00000000-0002-0000-0000-000000000049', 'Home Ing', 'Aurolife Pharma, LLC', '2016-03-27 16:25:32', NULL),
  ('00000000-0002-0000-0000-000000000050', 'Konklux', 'ALK-Abello, Inc.', '2016-07-17 03:47:25', NULL),
  -- BEGIN all role/project role member permutations DO NOT ALTER
  ('00000000-0002-0000-0000-000000000101', 'Project One', 'Incredible Stuff ', '2016-07-03 08:49:05', NULL),
  ('00000000-0002-0000-0000-000000000102', 'Project Two', 'Amazing Too', '2016-08-26 21:57:39', NULL),
  ('00000000-0002-0000-0000-000000000103', 'Project Three', 'Quite Astonishing', '2016-01-17 16:00:33', NULL),
  ('00000000-0002-0000-0000-000000000104', 'Project Four', 'Pretty Boring', '2016-01-17 16:00:33', NULL);
-- END all role/project role member permutations DO NOT ALTER
INSERT INTO "member" VALUES
  ('00000000-0001-0000-0000-000000000001', '00000000-0002-0000-0000-000000000001', 'ADMIN',
   to_date('2016-11-11', 'YYYY-MM-DD')),
  ('00000000-0001-0000-0000-000000000002', '00000000-0002-0000-0000-000000000001', 'ADMIN',
   to_date('2016-12-11', 'YYYY-MM-DD')),
  ('00000000-0001-0000-0000-000000000002', '00000000-0002-0000-0000-000000000002', 'ADMIN',
   to_date('2016-10-11', 'YYYY-MM-DD')),
  ('00000000-0001-0000-0000-000000000003', '00000000-0002-0000-0000-000000000002', 'ADMIN',
   to_date('2016-10-13', 'YYYY-MM-DD')),
  ('93ef43d9-20b7-461a-b960-2d1e89ba099f', '00000000-0002-0000-0000-000000000001', 'ADMIN',
   to_date('2016-11-11', 'YYYY-MM-DD')),

  -- BEGIN all role/project role member permutations DO NOT ALTER
  ('00000000-0001-0000-0000-000000000101', '00000000-0002-0000-0000-000000000101', 'ADMIN',
   to_date('2016-11-11', 'YYYY-MM-DD')),
  ('00000000-0001-0000-0000-000000000101', '00000000-0002-0000-0000-000000000102', 'USER',
   to_date('2016-12-11', 'YYYY-MM-DD')),
  ('00000000-0001-0000-0000-000000000101', '00000000-0002-0000-0000-000000000103', 'OBSERVER',
   to_date('2016-12-11', 'YYYY-MM-DD')),
  ('00000000-0001-0000-0000-000000000102', '00000000-0002-0000-0000-000000000101', 'USER',
   to_date('2016-12-11', 'YYYY-MM-DD')),
  ('00000000-0001-0000-0000-000000000102', '00000000-0002-0000-0000-000000000102', 'OBSERVER',
   to_date('2016-10-11', 'YYYY-MM-DD')),
  ('00000000-0001-0000-0000-000000000102', '00000000-0002-0000-0000-000000000103', 'ADMIN',
   to_date('2016-10-13', 'YYYY-MM-DD')),
  ('00000000-0001-0000-0000-000000000103', '00000000-0002-0000-0000-000000000101', 'OBSERVER',
   to_date('2016-12-11', 'YYYY-MM-DD')),
  ('00000000-0001-0000-0000-000000000103', '00000000-0002-0000-0000-000000000102', 'ADMIN',
   to_date('2016-10-11', 'YYYY-MM-DD')),
  ('00000000-0001-0000-0000-000000000103', '00000000-0002-0000-0000-000000000103', 'USER',
   to_date('2016-10-13', 'YYYY-MM-DD'));
-- END all role/project role permutations DO NOT ALTER

--TICKETS


 VALUES ('00000000-0003-0000-0000-000000000005', 5, '00000000-0003-0000-0000-000000000002', '00000000-0002-0000-0000-000000000001', '660f2968-aa46-4870-bcc5-a3805366cff2', '00000000-0004-0000-0000-000000000005', '2016-11-16 18:06:07.221000', 'Test Users View', false, 20, 10000000000000, null, '2016-09-20 17:07:05.554000');

INSERT INTO public.ticket (id, number, parent_ticket_id, project_id, created_by, description_comment_id, create_time, title, open, story_points, initial_estimated_time, current_estimated_time, due_date)
VALUES ('00000000-0003-0000-0000-000000000001', 1, NULL, '00000000-0002-0000-0000-000000000001',
                                                '660f2968-aa46-4870-bcc5-a3805366cff2',
                                                NULL,
                                                '2016-11-16 17:00:00.000000',
                                                'Added Models to Layout', TRUE, 10, 20, 25,
        '2016-11-20 17:07:05.554000');
INSERT INTO public.comment (id, user_id, ticket_id, create_time, text)
VALUES ('00000000-0004-0000-0000-000000000001', '660f2968-aa46-4870-bcc5-a3805366cff2',
        '00000000-0003-0000-0000-000000000001', '2016-11-16 17:09:59.019000', 'Hello World');

UPDATE public.ticket
SET description_comment_id = '00000000-0004-0000-0000-000000000001'
WHERE id = '00000000-0003-0000-0000-000000000001';


INSERT INTO public.ticket (id, number, parent_ticket_id, project_id, created_by, description_comment_id, create_time, title, open, story_points, initial_estimated_time, current_estimated_time, due_date)
VALUES ('00000000-0003-0000-0000-000000000002', 2, null, '00000000-0002-0000-0000-000000000001', '660f2968-aa46-4870-bcc5-a3805366cff2',
                                                null, '2016-11-16 18:06:07.221000', 'Create Users View',
                                                true, 10, 20000000000000, 25000000000000, '2016-11-21 17:07:05.554000');
INSERT INTO public.comment (id, user_id, ticket_id, create_time, text)
VALUES ('00000000-0004-0000-0000-000000000002', '660f2968-aa46-4870-bcc5-a3805366cff2',
        '00000000-0003-0000-0000-000000000002', '2016-11-16 17:09:59.019000', 'You have to do 3 sub Tasks');
UPDATE public.ticket
SET description_comment_id = '00000000-0004-0000-0000-000000000002'
WHERE id = '00000000-0003-0000-0000-000000000002';


INSERT INTO public.ticket (id, number, parent_ticket_id, project_id, created_by, description_comment_id, create_time, title, open, story_points, initial_estimated_time, current_estimated_time, due_date)
VALUES ('00000000-0003-0000-0000-000000000003', 3, '00000000-0003-0000-0000-000000000002', '00000000-0002-0000-0000-000000000001', '660f2968-aa46-4870-bcc5-a3805366cff2',
                                                null, '2016-11-16 18:06:07.221000', 'UI Users View', true, 10, 10000000000000, 18000000000000, '2016-11-22 17:07:05.554000');
INSERT INTO public.comment (id, user_id, ticket_id, create_time, text) VALUES
  ('00000000-0004-0000-0000-000000000003', '660f2968-aa46-4870-bcc5-a3805366cff2',
   '00000000-0003-0000-0000-000000000003', '2016-11-16 17:09:59.019000',
   'Design UI --Comment there is no Closed Event atm');
UPDATE public.ticket
SET description_comment_id = '00000000-0004-0000-0000-000000000003'
WHERE id = '00000000-0003-0000-0000-000000000003';


INSERT INTO public.comment (id, user_id, ticket_id, create_time, text) VALUES
  ('00000000-0004-0000-0000-000000000006', '660f2968-aa46-4870-bcc5-a3805366cff2',
   '00000000-0003-0000-0000-000000000003', '2016-11-16 18:09:59.019000', 'Finished');

INSERT INTO public.ticket (id, number, parent_ticket_id, project_id, created_by, description_comment_id, create_time, title, open, story_points, initial_estimated_time, current_estimated_time, due_date)
VALUES ('00000000-0003-0000-0000-000000000004', 4, '00000000-0003-0000-0000-000000000002', '00000000-0002-0000-0000-000000000001',
                                                '660f2968-aa46-4870-bcc5-a3805366cff2',null, '2016-11-16 18:06:07.221000',
                                                'Implement Users View', true, 4, 25000000000000, 36000000000000, '2016-12-20 17:07:05.554000');

INSERT INTO public.comment (id, user_id, ticket_id, create_time, text) VALUES
  ('00000000-0004-0000-0000-000000000004', '660f2968-aa46-4870-bcc5-a3805366cff2',
   '00000000-0003-0000-0000-000000000004', '2016-11-16 17:09:59.019000', 'Implement Users View');
UPDATE public.ticket
SET description_comment_id = '00000000-0004-0000-0000-000000000004'
WHERE id = '00000000-0003-0000-0000-000000000004';


INSERT INTO public.ticket (id, number, parent_ticket_id, project_id, created_by, description_comment_id, create_time, title, open, story_points, initial_estimated_time, current_estimated_time, due_date)
VALUES ('00000000-0003-0000-0000-000000000005', 5, '00000000-0003-0000-0000-000000000002', '00000000-0002-0000-0000-000000000001',
                                                '660f2968-aa46-4870-bcc5-a3805366cff2', null, '2016-11-16 18:06:07.221000',
                                                'Test Users View', false, 20, 10000000000000, null, '2016-09-20 17:07:05.554000');

INSERT INTO public.comment (id, user_id, ticket_id, create_time, text) VALUES
  ('00000000-0004-0000-0000-000000000005', '660f2968-aa46-4870-bcc5-a3805366cff2',
   '00000000-0003-0000-0000-000000000005', '2016-11-16 17:09:59.019000', 'Test Users View');
UPDATE public.ticket
SET description_comment_id = '00000000-0004-0000-0000-000000000005'
WHERE id = '00000000-0003-0000-0000-000000000005';


INSERT INTO public.ticket (id, number, parent_ticket_id, project_id, created_by, description_comment_id, create_time, title, open, story_points, initial_estimated_time, current_estimated_time, due_date)
VALUES ('00000000-0003-0000-0000-000000000006', 6, NULL, '00000000-0002-0000-0000-000000000001',
                                                '93ef43d9-20b7-461a-b960-2d1e89ba099f',
                                                NULL, '2016-11-16 18:06:07.221000',
                                                'Set UP CI', FALSE, 20, 3.6e+13, 5.4e+13, '2015-4-20 17:07:05.554000');
INSERT INTO public.comment (id, user_id, ticket_id, create_time, text) VALUES
  ('00000000-0004-0000-0000-000000000007', '93ef43d9-20b7-461a-b960-2d1e89ba099f',
   '00000000-0003-0000-0000-000000000006', '2016-11-16 17:09:59.019', '# An exhibit of Markdown

This note demonstrates some of what [Markdown][1] is capable of doing.

*Note: Feel free to play with this page. Unlike regular notes, this doesn''t automatically save itself.*

## Basic formatting

Paragraphs can be written like so. A paragraph is the basic block of Markdown. A paragraph is what text will turn into when there is no reason it should become anything else.

Paragraphs must be separated by a blank line. Basic formatting of *italics* and **bold** is supported. This *can be **nested** like* so.

## Lists

### Ordered list

1. Item 1
2. A second item
3. Number 3
4. Ⅳ

*Note: the fourth item uses the Unicode character for [Roman numeral four][2].*

### Unordered list

* An item
* Another item
* Yet another item
* And there''s more...

## Paragraph modifiers

### Code block

    Code blocks are very useful for developers and other people who look at code or other things that are written in plain text. As you can see, it uses a fixed-width font.

You can also make `inline code` to add code into other things.

### Quote

> Here is a quote. What this is should be self explanatory. Quotes are automatically indented when they are used.

## Headings

There are six levels of headings. They correspond with the six levels of HTML headings. You''ve probably noticed them already in the page. Each level down uses one more hash character.

### Headings *can* also contain **formatting**

### They can even contain `inline code`

Of course, demonstrating what headings look like messes up the structure of the page.

I don''t recommend using more than three or four levels of headings here, because, when you''re smallest heading isn''t too small, and you''re largest heading isn''t too big, and you want each size up to look noticeably larger and more important, there there are only so many sizes that you can use.

## URLs

URLs can be made in a handful of ways:

* A named link to [MarkItDown][3]. The easiest way to do these is to select what you want to make a link and hit `Ctrl+L`.
* Another named link to [MarkItDown](http://www.markitdown.net/)
* Sometimes you just want a URL like <http://www.markitdown.net/>.

## Horizontal rule

A horizontal rule is a line that goes across the middle of the page.

---

It''s sometimes handy for breaking things up.

## Images

![Cat](http://lorempixel.com/400/400/cats)

## Code

```haskell
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smallerSorted = quicksort [a | a <- xs, a <= x]
        biggerSorted = quicksort [a | a <- xs, a > x]
    in  smallerSorted ++ [x] ++ biggerSorted
```

## Finally


  This is the XSS test:
  <script>alert("xss")</script>
  [XSS](javascript&#58this;alert(1&#41;)
  [XSS](javascript&#58;alert(1&#41;)
  ![XSS](javascript:alert())


  This is the linkify test: https://www.google.com
  And this is the normal link test: [Link](https://www.google.com)
');

UPDATE public.ticket
SET description_comment_id = '00000000-0004-0000-0000-000000000007'
WHERE id = '00000000-0003-0000-0000-000000000006';


INSERT INTO public.comment (id, user_id, ticket_id, create_time, text) VALUES
  ('00000000-0004-0000-0000-000000000008', '660f2968-aa46-4870-bcc5-a3805366cff2',
   '00000000-0003-0000-0000-000000000006', '2016-11-16 20:09:59.019000', 'There is still so much todo');


INSERT INTO public.ticket (id, number, parent_ticket_id, project_id, created_by, description_comment_id, create_time, title, open, story_points, initial_estimated_time, current_estimated_time, due_date)
VALUES ('00000000-0003-0000-0000-000000000007', 7, '00000000-0003-0000-0000-000000000006', '00000000-0002-0000-0000-000000000001',
                                                '93ef43d9-20b7-461a-b960-2d1e89ba099f',
                                                NULL, '2016-11-16 18:06:07.221000',
                                                'Subticket 1', FALSE, 20, 3.6e+13, 5.4e+13, '2015-4-20 17:07:05.554000');
INSERT INTO public.comment (id, user_id, ticket_id, create_time, text) VALUES
  ('00000000-0004-0000-0000-000000000009', '93ef43d9-20b7-461a-b960-2d1e89ba099f',
   '00000000-0003-0000-0000-000000000007', '2016-11-16 17:09:59.019', 'Subticket 1');
UPDATE public.ticket
SET description_comment_id = '00000000-0004-0000-0000-000000000009'
WHERE id = '00000000-0003-0000-0000-000000000007';


INSERT INTO public.ticket (id, number, parent_ticket_id, project_id, created_by, description_comment_id, create_time, title, open, story_points, initial_estimated_time, current_estimated_time, due_date)
VALUES ('00000000-0003-0000-0000-000000000008', 8, '00000000-0003-0000-0000-000000000006', '00000000-0002-0000-0000-000000000001',
                                                '93ef43d9-20b7-461a-b960-2d1e89ba099f',
                                                NULL, '2016-11-16 18:06:07.221000',
                                                'Subticket 2', FALSE, 20, 3.6e+13, 5.4e+13, '2015-4-20 17:07:05.554000');
INSERT INTO public.comment (id, user_id, ticket_id, create_time, text) VALUES
  ('00000000-0004-0000-0000-000000000010', '93ef43d9-20b7-461a-b960-2d1e89ba099f',
   '00000000-0003-0000-0000-000000000008', '2016-11-16 17:09:59.019', 'Subticket 2');
UPDATE public.ticket
SET description_comment_id = '00000000-0004-0000-0000-000000000010'
WHERE id = '00000000-0003-0000-0000-000000000008';



INSERT INTO public.comment (id, user_id, ticket_id, create_time, text) VALUES ('1a8c8bc8-c235-4fd2-a36f-73387ad9f54b', '93ef43d9-20b7-461a-b960-2d1e89ba099f', '00000000-0003-0000-0000-000000000003', '2016-11-30 10:40:38.195000', 'ich werde das noch testen !assign:heinzl@testing  ');
INSERT INTO public.comment (id, user_id, ticket_id, create_time, text) VALUES ('dd8c1748-a82b-410a-a9aa-22b2b2cecb39', '93ef43d9-20b7-461a-b960-2d1e89ba099f', '00000000-0003-0000-0000-000000000004', '2016-11-30 10:42:10.592000', 'Das Ticket wird länger dauern als gedacht !est:10h');
INSERT INTO public.comment (id, user_id, ticket_id, create_time, text) VALUES ('d5f38991-8f75-4d8c-ae72-52889de451fb', '93ef43d9-20b7-461a-b960-2d1e89ba099f', '00000000-0003-0000-0000-000000000002', '2016-11-30 10:43:57.111000', 'Der tag ist falsch !tag:feature und bitte übernimm das testen !assign:heinzl@testing ');
INSERT INTO public.comment (id, user_id, ticket_id, create_time, text) VALUES ('0b6e58ba-0e91-4371-be20-6336335beace', '93ef43d9-20b7-461a-b960-2d1e89ba099f', '00000000-0003-0000-0000-000000000003', '2016-11-30 10:45:02.061000', 'ich bin mit dem testen fertig, leider muss das nochmal überarbeitet werden !reopen !-tag:review !est:5h');
INSERT INTO public.comment (id, user_id, ticket_id, create_time, text) VALUES ('f3a7c1f1-5bab-428d-b100-a51ad2434eab', '660f2968-aa46-4870-bcc5-a3805366cff2', '00000000-0003-0000-0000-000000000002', '2016-11-30 11:39:22.640000', 'Wenn das CI #6 fertig wäre könnten wir das dann automatisch testen');
INSERT INTO public.comment (id, user_id, ticket_id, create_time, text) VALUES ('d64d70aa-f1f7-4da6-adc3-1cf7c7b716e1', '93ef43d9-20b7-461a-b960-2d1e89ba099f', '00000000-0003-0000-0000-000000000006', '2016-11-30 11:44:44.162000', 'Auf das Ergebnis von #4 müssen wir warten');
INSERT INTO public.comment (id, user_id, ticket_id, create_time, text) VALUES ('dfceb74c-29c9-4640-a36f-8a07c4d45ca5', '660f2968-aa46-4870-bcc5-a3805366cff2', '00000000-0003-0000-0000-000000000004', '2016-11-30 11:52:12.251000', '!time:1h30min@implementing Users View wurder mit Details erweitert');
-- BEGIN Role Based Ticket Testdata DO NOT ALTER
INSERT INTO PUBLIC.ticket (id, number, parent_ticket_id, project_id, created_by, description_comment_id, create_time, title, OPEN, story_points, initial_estimated_time, current_estimated_time, due_date)
VALUES ('00000000-0003-0000-0000-000000000101', 1, NULL, '00000000-0002-0000-0000-000000000101',
                                                '00000000-0001-0000-0000-000000000101', NULL,
                                                '2016-11-16 17:06:07.221000', 'Project 1 Ticket One', TRUE, 10, 20, 25,
        '2016-11-20 17:07:05.554000');
INSERT INTO PUBLIC.comment (id, user_id, ticket_id, create_time, TEXT)
VALUES ('00000000-0004-0000-0000-000000000101', '00000000-0001-0000-0000-000000000101',
        '00000000-0003-0000-0000-000000000101', '2016-11-16 17:09:59.019000', 'Description Project1 Ticket1');
UPDATE PUBLIC.ticket
SET description_comment_id = '00000000-0004-0000-0000-000000000101'
WHERE id = '00000000-0003-0000-0000-000000000101';


INSERT INTO PUBLIC.ticket (id, number, parent_ticket_id, project_id, created_by, description_comment_id, create_time, title, OPEN, story_points, initial_estimated_time, current_estimated_time, due_date)
VALUES ('00000000-0003-0000-0000-000000000102', 1, NULL, '00000000-0002-0000-0000-000000000102',
                                                '00000000-0001-0000-0000-000000000101', NULL,
                                                '2016-11-16 17:06:07.221000', 'Project 2 Ticket One', TRUE, 10, 20, 25,
        '2016-11-20 17:07:05.554000');
INSERT INTO PUBLIC.comment (id, user_id, ticket_id, create_time, TEXT)
VALUES ('00000000-0004-0000-0000-000000000102', '00000000-0001-0000-0000-000000000101',
        '00000000-0003-0000-0000-000000000102', '2016-11-16 17:09:59.019000', 'Description Project2 Ticket1');
UPDATE PUBLIC.ticket
SET description_comment_id = '00000000-0004-0000-0000-000000000102'
WHERE id = '00000000-0003-0000-0000-000000000102';

INSERT INTO PUBLIC.ticket (id, number, parent_ticket_id, project_id, created_by, description_comment_id, create_time, title, OPEN, story_points, initial_estimated_time, current_estimated_time, due_date)
VALUES ('00000000-0003-0000-0000-000000000103', 1, NULL, '00000000-0002-0000-0000-000000000103',
                                                '00000000-0001-0000-0000-000000000101', NULL,
                                                '2016-11-16 17:06:07.221000', 'Project 3 Ticket One', TRUE, 10, 20, 25,
        '2016-11-20 17:07:05.554000');
INSERT INTO PUBLIC.comment (id, user_id, ticket_id, create_time, TEXT)
VALUES ('00000000-0004-0000-0000-000000000103', '00000000-0001-0000-0000-000000000101',
        '00000000-0003-0000-0000-000000000103', '2016-11-16 17:09:59.019000', 'Description Project3 Ticket1');
UPDATE PUBLIC.ticket
SET description_comment_id = '00000000-0004-0000-0000-000000000103'
WHERE id = '00000000-0003-0000-0000-000000000103';
INSERT INTO PUBLIC.ticket (id, number, parent_ticket_id, project_id, created_by, description_comment_id, create_time, title, OPEN, story_points, initial_estimated_time, current_estimated_time, due_date)
VALUES ('00000000-0003-0000-0000-000000000104', 1, NULL, '00000000-0002-0000-0000-000000000104',
                                                '00000000-0001-0000-0000-000000000101', NULL,
                                                '2016-11-16 17:06:07.221000', 'Project 4 Ticket One', TRUE, 10, 20, 25,
        '2016-11-20 17:07:05.554000');
INSERT INTO PUBLIC.comment (id, user_id, ticket_id, create_time, TEXT)
VALUES ('00000000-0004-0000-0000-000000000104', '00000000-0001-0000-0000-000000000101',
        '00000000-0003-0000-0000-000000000104', '2016-11-16 17:09:59.019000', 'Description Project4 Ticket1');
UPDATE PUBLIC.ticket
SET description_comment_id = '00000000-0004-0000-0000-000000000104'
WHERE id = '00000000-0003-0000-0000-000000000104';
-- END Role Based Ticket Testdata DO NOT ALTER

--TICKET TAG GROUPS

INSERT INTO public.ticket_tag_group (id, project_id, default_ticket_tag_id, name, exclusive)
VALUES ('00000000-0009-0000-0000-000000000001', '00000000-0002-0000-0000-000000000001', NULL, 'Agile', TRUE);
INSERT INTO public.ticket_tag_group (id, project_id, default_ticket_tag_id, name, exclusive)
VALUES ('00000000-0009-0000-0000-000000000002', '00000000-0002-0000-0000-000000000001', NULL, 'Priority', TRUE);
INSERT INTO public.ticket_tag_group (id, project_id, default_ticket_tag_id, name, exclusive)
VALUES ('00000000-0009-0000-0000-000000000003', '00000000-0002-0000-0000-000000000002', NULL, 'Test', FALSE);

--TICKET TAGS

INSERT INTO public.ticket_tag (id, ticket_tag_group_id, name, normalized_name, color, "order")
VALUES
  ('00000000-0005-0000-0000-000000000001', '00000000-0009-0000-0000-000000000001', 'Feature', 'feature', '008000', 1);

INSERT INTO public.ticket_tag (id, ticket_tag_group_id, name, normalized_name, color, "order")
VALUES ('00000000-0005-0000-0000-000000000002', '00000000-0009-0000-0000-000000000001', 'Bug', 'bug', 'FF0000', 2);

INSERT INTO public.ticket_tag (id, ticket_tag_group_id, name, normalized_name, color, "order")
VALUES ('00000000-0005-0000-0000-000000000003', '00000000-0009-0000-0000-000000000001', 'Implementing', 'implementing',
        'FFA500', 3);

INSERT INTO public.ticket_tag (id, ticket_tag_group_id, name, normalized_name, color, "order")
VALUES
  ('00000000-0005-0000-0000-000000000004', '00000000-0009-0000-0000-000000000001', 'Review', 'review', '008000', 4);


INSERT INTO public.ticket_tag (id, ticket_tag_group_id, name, normalized_name, color, "order")
VALUES ('00000000-0005-0000-0001-000000000001', '00000000-0009-0000-0000-000000000002', 'Low', 'low', '008000', 5);

INSERT INTO public.ticket_tag (id, ticket_tag_group_id, name, normalized_name, color, "order")
VALUES
  ('00000000-0005-0000-0001-000000000002', '00000000-0009-0000-0000-000000000002', 'Medium', 'medium', 'FFA500', 6);

INSERT INTO public.ticket_tag (id, ticket_tag_group_id, name, normalized_name, color, "order")
VALUES ('00000000-0005-0000-0001-000000000003', '00000000-0009-0000-0000-000000000002', 'High', 'high', 'FF0000', 7);


INSERT INTO public.ticket_tag (id, ticket_tag_group_id, name, normalized_name, color, "order")
VALUES ('00000000-0005-0000-0002-000000000001', '00000000-0009-0000-0000-000000000003', 'Blue', 'blue', 'FF0000', 7);

INSERT INTO public.ticket_tag (id, ticket_tag_group_id, name, normalized_name, color, "order")
VALUES ('00000000-0005-0000-0002-000000000002', '00000000-0009-0000-0000-000000000003', 'Red', 'red', 'FFFF00', 8);

UPDATE public.ticket_tag_group
SET default_ticket_tag_id = '00000000-0005-0000-0000-000000000001'
WHERE id = '00000000-0009-0000-0000-000000000001';
UPDATE public.ticket_tag_group
SET default_ticket_tag_id = '00000000-0005-0000-0001-000000000001'
WHERE id = '00000000-0009-0000-0000-000000000002';

--TICKET TAG TICKET
INSERT INTO public.assigned_ticket_tag (ticket_id, ticket_tag_id) VALUES ('00000000-0003-0000-0000-000000000002', '00000000-0005-0000-0000-000000000001');
INSERT INTO public.assigned_ticket_tag (ticket_id, ticket_tag_id) VALUES ('00000000-0003-0000-0000-000000000003', '00000000-0005-0000-0000-000000000001');
INSERT INTO public.assigned_ticket_tag (ticket_id, ticket_tag_id) VALUES ('00000000-0003-0000-0000-000000000003', '00000000-0005-0000-0000-000000000002');
INSERT INTO public.assigned_ticket_tag (ticket_id, ticket_tag_id) VALUES ('00000000-0003-0000-0000-000000000001', '00000000-0005-0000-0000-000000000001');
INSERT INTO public.assigned_ticket_tag (ticket_id, ticket_tag_id) VALUES ('00000000-0003-0000-0000-000000000001', '00000000-0005-0000-0000-000000000003');
INSERT INTO public.assigned_ticket_tag (ticket_id, ticket_tag_id) VALUES ('00000000-0003-0000-0000-000000000004', '00000000-0005-0000-0000-000000000001');
INSERT INTO public.assigned_ticket_tag (ticket_id, ticket_tag_id) VALUES ('00000000-0003-0000-0000-000000000006', '00000000-0005-0000-0000-000000000001');
INSERT INTO public.assigned_ticket_tag (ticket_id, ticket_tag_id) VALUES ('00000000-0003-0000-0000-000000000006', '00000000-0005-0000-0001-000000000002');


--Assignment-Tag

INSERT INTO public.assignment_tag (id, project_id, name, normalized_name, color)
VALUES ('00000000-0006-0000-0000-000000000001', '00000000-0002-0000-0000-000000000001', 'Implementing', 'implementing',
        '2196F3');

INSERT INTO public.assignment_tag (id, project_id, name, normalized_name, color)
VALUES ('00000000-0006-0000-0000-000000000002', '00000000-0002-0000-0000-000000000001', 'Testing', 'testing', '4CAF50');

INSERT INTO public.assignment_tag (id, project_id, name, normalized_name, color)
VALUES
  ('00000000-0006-0000-0000-000000000003', '00000000-0002-0000-0000-000000000001', 'Bug Fixing', 'bugfixing', 'F44336');

INSERT INTO public.assignment_tag (id, project_id, name, normalized_name, color)
VALUES ('00000000-0006-0000-0000-000000000004', '00000000-0002-0000-0000-000000000001', 'Ticket Owner', 'ticketowner',
        'FF9800');

INSERT INTO public.assignment_tag (id, project_id, name, normalized_name, color)
VALUES
  ('00000000-0006-0000-0000-000000000005', '00000000-0002-0000-0000-000000000001', 'Document', 'document', '00BCD4');

INSERT INTO public.assignment_tag (id, project_id, name, normalized_name, color)
VALUES ('00000000-0006-0000-0000-000000000006', '00000000-0002-0000-0000-000000000001', 'Review', 'review', '9C27B0');




--BEGIN Assignment-Tag Data for rolebased testing DO NOT ALTER
INSERT INTO PUBLIC.assignment_tag (id, project_id, NAME, normalized_name, color)
VALUES ('00000000-0006-0000-0000-000000000101', '00000000-0002-0000-0000-000000000101', 'dev', 'dev', 'ff0000');
INSERT INTO PUBLIC.assignment_tag (id, project_id, NAME, normalized_name, color)
VALUES ('00000000-0006-0000-0000-000000000102', '00000000-0002-0000-0000-000000000101', 'test', 'test', '0000ff');
INSERT INTO PUBLIC.assignment_tag (id, project_id, NAME, normalized_name, color)
VALUES ('00000000-0006-0000-0000-000000000103', '00000000-0002-0000-0000-000000000101', 'rev', 'rev', 'ff000f');
INSERT INTO PUBLIC.assignment_tag (id, project_id, NAME, normalized_name, color)
VALUES ('00000000-0006-0000-0000-000000000104', '00000000-0002-0000-0000-000000000102', 'dev', 'dev', 'ff0000');
INSERT INTO PUBLIC.assignment_tag (id, project_id, NAME, normalized_name, color)
VALUES ('00000000-0006-0000-0000-000000000105', '00000000-0002-0000-0000-000000000102', 'test', 'test', '0000ff');
INSERT INTO PUBLIC.assignment_tag (id, project_id, NAME, normalized_name, color)
VALUES ('00000000-0006-0000-0000-000000000106', '00000000-0002-0000-0000-000000000102', 'rev', 'rev', 'ff000f');
INSERT INTO PUBLIC.assignment_tag (id, project_id, NAME, normalized_name, color)
VALUES ('00000000-0006-0000-0000-000000000107', '00000000-0002-0000-0000-000000000103', 'dev', 'dev', 'ff0000');
INSERT INTO PUBLIC.assignment_tag (id, project_id, NAME, normalized_name, color)
VALUES ('00000000-0006-0000-0000-000000000108', '00000000-0002-0000-0000-000000000103', 'test', 'test', '0000ff');
INSERT INTO PUBLIC.assignment_tag (id, project_id, NAME, normalized_name, color)
VALUES ('00000000-0006-0000-0000-000000000109', '00000000-0002-0000-0000-000000000103', 'rev', 'rev', 'ff000f');
INSERT INTO PUBLIC.assignment_tag (id, project_id, NAME, normalized_name, color)
VALUES ('00000000-0006-0000-0000-000000000110', '00000000-0002-0000-0000-000000000104', 'dev', 'dev', 'ff0000');
INSERT INTO PUBLIC.assignment_tag (id, project_id, NAME, normalized_name, color)
VALUES ('00000000-0006-0000-0000-000000000111', '00000000-0002-0000-0000-000000000104', 'test', 'test', '0000ff');
INSERT INTO PUBLIC.assignment_tag (id, project_id, NAME, normalized_name, color)
VALUES ('00000000-0006-0000-0000-000000000112', '00000000-0002-0000-0000-000000000104', 'rev', 'rev', 'ff000f');
--END Assignment-Tag Data for rolebased testing DO NOT ALTER

--TICKET USER
INSERT INTO public.assigned_ticket_user (ticket_id, assignment_tag_id, user_id)
VALUES ('00000000-0003-0000-0000-000000000001', '00000000-0006-0000-0000-000000000001',
        '660f2968-aa46-4870-bcc5-a3805366cff2');

INSERT INTO public.assigned_ticket_user (ticket_id, assignment_tag_id, user_id)
VALUES ('00000000-0003-0000-0000-000000000002', '00000000-0006-0000-0000-000000000001',
        '660f2968-aa46-4870-bcc5-a3805366cff2');

INSERT INTO public.assigned_ticket_user (ticket_id, assignment_tag_id, user_id)
VALUES ('00000000-0003-0000-0000-000000000003', '00000000-0006-0000-0000-000000000001',
        '660f2968-aa46-4870-bcc5-a3805366cff2');

INSERT INTO public.assigned_ticket_user (ticket_id, assignment_tag_id, user_id)
VALUES ('00000000-0003-0000-0000-000000000004', '00000000-0006-0000-0000-000000000001',
        '660f2968-aa46-4870-bcc5-a3805366cff2');

INSERT INTO public.assigned_ticket_user (ticket_id, assignment_tag_id, user_id)
VALUES ('00000000-0003-0000-0000-000000000005', '00000000-0006-0000-0000-000000000001',
        '93ef43d9-20b7-461a-b960-2d1e89ba099f');
INSERT INTO public.assigned_ticket_user (ticket_id, assignment_tag_id, user_id)
VALUES ('00000000-0003-0000-0000-000000000005', '00000000-0006-0000-0000-000000000002',
        '660f2968-aa46-4870-bcc5-a3805366cff2');

INSERT INTO public.assigned_ticket_user (ticket_id, assignment_tag_id, user_id)
VALUES ('00000000-0003-0000-0000-000000000006', '00000000-0006-0000-0000-000000000001',
        '93ef43d9-20b7-461a-b960-2d1e89ba099f');
INSERT INTO public.assigned_ticket_user (ticket_id, assignment_tag_id, user_id)
VALUES ('00000000-0003-0000-0000-000000000006', '00000000-0006-0000-0000-000000000002',
        '93ef43d9-20b7-461a-b960-2d1e89ba099f');

INSERT INTO public.assigned_ticket_user (ticket_id, assignment_tag_id, user_id) VALUES ('00000000-0003-0000-0000-000000000003', '00000000-0006-0000-0000-000000000002', '93ef43d9-20b7-461a-b960-2d1e89ba099f');
INSERT INTO public.assigned_ticket_user (ticket_id, assignment_tag_id, user_id) VALUES ('00000000-0003-0000-0000-000000000002', '00000000-0006-0000-0000-000000000002', '93ef43d9-20b7-461a-b960-2d1e89ba099f');


--BEGIN ASSIGNED TICKET USERS role based Test data DO NOT ALTER
INSERT INTO PUBLIC.assigned_ticket_user (ticket_id, assignment_tag_id, user_id)
VALUES ('00000000-0003-0000-0000-000000000101', '00000000-0006-0000-0000-000000000101',
        '00000000-0001-0000-0000-000000000101');
INSERT INTO PUBLIC.assigned_ticket_user (ticket_id, assignment_tag_id, user_id)
VALUES ('00000000-0003-0000-0000-000000000101', '00000000-0006-0000-0000-000000000102',
        '00000000-0001-0000-0000-000000000103');
INSERT INTO PUBLIC.assigned_ticket_user (ticket_id, assignment_tag_id, user_id)
VALUES ('00000000-0003-0000-0000-000000000102', '00000000-0006-0000-0000-000000000104',
        '00000000-0001-0000-0000-000000000101');
INSERT INTO PUBLIC.assigned_ticket_user (ticket_id, assignment_tag_id, user_id)
VALUES ('00000000-0003-0000-0000-000000000102', '00000000-0006-0000-0000-000000000106',
        '00000000-0001-0000-0000-000000000103');
--Ticket 00000000-0003-0000-0000-000000000103 reserved for insert tests
--END ASSIGNED TICKET USERS role based Test data DO NOT ALTER

--Time Category

INSERT INTO public.time_category (id, project_id, name, normalized_name)
VALUES ('00000000-0007-0000-0000-000000000001', '00000000-0002-0000-0000-000000000001', 'Implementing', 'implementing');

INSERT INTO public.time_category (id, project_id, name, normalized_name)
VALUES ('00000000-0007-0000-0000-000000000002', '00000000-0002-0000-0000-000000000001', 'Meeting', 'meeting');

INSERT INTO public.time_category (id, project_id, name, normalized_name)
VALUES ('00000000-0007-0000-0000-000000000003', '00000000-0002-0000-0000-000000000001', 'Testing', 'testing');

--BEGIN TimeCategories for Role based testing DO NOT ALTER
INSERT INTO PUBLIC.time_category (id, project_id, NAME, normalized_name)
VALUES ('00000000-0007-0000-0000-000000000101', '00000000-0002-0000-0000-000000000101', 'dev', 'dev');
INSERT INTO PUBLIC.time_category (id, project_id, NAME, normalized_name)
VALUES ('00000000-0007-0000-0000-000000000102', '00000000-0002-0000-0000-000000000101', 'plan', 'plan');
INSERT INTO PUBLIC.time_category (id, project_id, NAME, normalized_name)
VALUES ('00000000-0007-0000-0000-000000000103', '00000000-0002-0000-0000-000000000102', 'dev', 'dev');
INSERT INTO PUBLIC.time_category (id, project_id, NAME, normalized_name)
VALUES ('00000000-0007-0000-0000-000000000104', '00000000-0002-0000-0000-000000000102', 'plan', 'plan');
INSERT INTO PUBLIC.time_category (id, project_id, NAME, normalized_name)
VALUES ('00000000-0007-0000-0000-000000000105', '00000000-0002-0000-0000-000000000103', 'dev', 'dev');
INSERT INTO PUBLIC.time_category (id, project_id, NAME, normalized_name)
VALUES ('00000000-0007-0000-0000-000000000106', '00000000-0002-0000-0000-000000000103', 'plan', 'plan');
INSERT INTO PUBLIC.time_category (id, project_id, NAME, normalized_name)
VALUES ('00000000-0007-0000-0000-000000000107', '00000000-0002-0000-0000-000000000104', 'dev', 'dev');
INSERT INTO PUBLIC.time_category (id, project_id, NAME, normalized_name)
VALUES ('00000000-0007-0000-0000-000000000108', '00000000-0002-0000-0000-000000000104', 'plan', 'plan');
--END TimeCategories for Role based testing DO NOT ALTER


--Time

INSERT INTO public.logged_time (id, comment_id, category_id, time)
VALUES ('00000000-0008-0000-0000-000000000001', '00000000-0004-0000-0000-000000000008',
        '00000000-0007-0000-0000-000000000001', 10);
INSERT INTO public.logged_time (id, comment_id, category_id, time) VALUES ('cc0b48b3-3dba-489c-8a1d-7b11a14e4cd7', 'dfceb74c-29c9-4640-a36f-8a07c4d45ca5', '00000000-0007-0000-0000-000000000001', 5400000000000);

INSERT INTO public.logged_time (id, comment_id, category_id, time)
VALUES ('00000000-0008-0000-0000-000000000002', '00000000-0004-0000-0000-000000000008',
        '00000000-0007-0000-0000-000000000002', 20);

INSERT INTO public.logged_time (id, comment_id, category_id, time)
VALUES ('00000000-0008-0000-0000-000000000003', '00000000-0004-0000-0000-000000000008',
        '00000000-0007-0000-0000-000000000003', 30);

INSERT INTO public.logged_time (id, comment_id, category_id, time) VALUES ('bc193a47-8230-4140-a242-cf19f1773741', '00000000-0004-0000-0000-000000000002', '00000000-0007-0000-0000-000000000001', 2.0e+13);
INSERT INTO public.logged_time (id, comment_id, category_id, time) VALUES ('5e74280a-2827-4f9d-8c18-d558e7add243', '00000000-0004-0000-0000-000000000003', '00000000-0007-0000-0000-000000000001', 1.1e+13);
INSERT INTO public.logged_time (id, comment_id, category_id, time) VALUES ('5edcbbcb-c169-4f02-957c-05ae61bbae4a', '00000000-0004-0000-0000-000000000004', '00000000-0007-0000-0000-000000000001', 2.0e+13);
INSERT INTO public.logged_time (id, comment_id, category_id, time) VALUES ('b79e6c7a-194f-4e33-bc16-4996fef7238c', '00000000-0004-0000-0000-000000000005', '00000000-0007-0000-0000-000000000001', 2.06e+13);

--TicketEvent
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('aacf19e5-4afb-443c-9597-991e7d91f453', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-24 16:11:09.768000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('4e7773dd-2010-408b-a936-42cb1419c462', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-24 16:11:27.467000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('9abd317d-94fe-4e97-909d-af713479b367', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-25 17:02:25.216000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('31720c8c-19e6-47d7-b1c9-de1cf321d4d5', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-25 17:02:32.631000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('392ff38c-69eb-4e83-8681-79371eb4af20', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-25 17:02:37.587000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('1b139e94-20bb-4070-989a-4e219c124bc3', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-25 17:09:49.356000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('a6a40784-6e76-4da1-b054-c3bdbcc5f5da', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-25 17:10:00.327000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('8156ef34-bb01-41ec-a03d-9a96817d6ff9', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-25 17:01:27.665000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('ac39dd07-1b13-4ea0-bb56-92d82be2b585', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-25 17:01:39.048000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('c26f0650-06f8-4d45-a311-43acc9990299', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-25 17:04:26.346000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('98f68e51-af94-417b-a121-b70ee2e3aecd', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-25 17:04:54.497000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('7c2e93c0-22df-4d9d-856d-0a1ad23a4e5a', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-25 17:07:56.492000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('f8c680e3-3975-489e-890d-917a36e0c97c', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-25 17:08:08.112000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('43444635-5ea0-4366-9d8a-cd139aec5459', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-25 17:08:21.351000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('dfc0f306-9b53-4002-9cf7-2d2a4dbf8be7', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-25 17:10:01.832000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('957dfea0-0da4-49ce-9460-037219eee366', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-25 17:10:07.618000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('a94a570d-02c1-49ac-b558-e455036a9303', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-25 17:10:13.054000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('799ee2dd-2168-46cf-84e2-b6a6395c4801', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-25 17:20:40.389000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('0e842df3-2308-4a12-beba-cacbdf4eeccf', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-25 17:20:49.227000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('347a199c-01e2-4e14-9215-afd4418d59f9', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-29 10:37:09.412000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('2e695d4f-7c17-480c-9ac8-9b59951dbce5', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-29 11:22:38.281000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('df0d8ada-a555-42aa-9495-68ee55263440', '00000000-0003-0000-0000-000000000006', '00000000-0001-0000-0000-000000000001', '2016-11-29 11:22:45.189000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('cfa4b3e0-0944-4c28-889a-3d55b256e4b3', '00000000-0003-0000-0000-000000000003', '93ef43d9-20b7-461a-b960-2d1e89ba099f', '2016-11-30 10:40:38.259000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('cf1ee266-0f7e-42c7-a75e-6b30de2f404f', '00000000-0003-0000-0000-000000000004', '93ef43d9-20b7-461a-b960-2d1e89ba099f', '2016-11-30 10:42:10.610000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('36c04483-4eda-4b12-a051-bdf9caa4331d', '00000000-0003-0000-0000-000000000002', '93ef43d9-20b7-461a-b960-2d1e89ba099f', '2016-11-30 10:43:57.140000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('3aff9346-0a36-49a3-82cc-a46d923a0289', '00000000-0003-0000-0000-000000000002', '93ef43d9-20b7-461a-b960-2d1e89ba099f', '2016-11-30 10:43:57.141000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('bcf284e5-ee4c-4925-8778-43792a9378f7', '00000000-0003-0000-0000-000000000002', '93ef43d9-20b7-461a-b960-2d1e89ba099f', '2016-11-30 10:43:57.182000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('8dc03c84-bf91-4d20-a25b-27c2d4fa3bf2', '00000000-0003-0000-0000-000000000003', '93ef43d9-20b7-461a-b960-2d1e89ba099f', '2016-11-30 10:45:02.076000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('fc782359-38f9-42a9-bf9b-d26ca482bf28', '00000000-0003-0000-0000-000000000003', '93ef43d9-20b7-461a-b960-2d1e89ba099f', '2016-11-30 10:45:02.110000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('baf45f47-4683-40c6-ace6-2b735c887432', '00000000-0003-0000-0000-000000000003', '93ef43d9-20b7-461a-b960-2d1e89ba099f', '2016-11-30 10:45:02.113000');
INSERT INTO public.ticket_event (id, ticket_id, user_id, time) VALUES ('ce7db5dd-32bc-429c-947c-518a8357169e', '00000000-0003-0000-0000-000000000004', '660f2968-aa46-4870-bcc5-a3805366cff2', '2016-11-30 11:54:31.409000');
-- -Ticket Event Title Changed
INSERT INTO public.ticket_event_title_changed (id, src_title, dst_title) VALUES ('aacf19e5-4afb-443c-9597-991e7d91f453', 'Set UP CI', 'New Title');
INSERT INTO public.ticket_event_title_changed (id, src_title, dst_title) VALUES ('4e7773dd-2010-408b-a936-42cb1419c462', 'New Title', 'Last Title was odd');

--Ticket Event Comment Text Changed
INSERT INTO public.ticket_event_comment_text_changed (id, comment_id, src_text, dst_text) VALUES ('8156ef34-bb01-41ec-a03d-9a96817d6ff9', '00000000-0004-0000-0000-000000000008', 'There is still so much todo', 'I am New');
INSERT INTO public.ticket_event_comment_text_changed (id, comment_id, src_text, dst_text) VALUES ('ac39dd07-1b13-4ea0-bb56-92d82be2b585', '00000000-0004-0000-0000-000000000008', 'I am New', 'I am Newer');

--Ticket Event Due Date Changed
INSERT INTO public.ticket_event_due_date_changed (id, src_due_date, dst_due_date) VALUES ('c26f0650-06f8-4d45-a311-43acc9990299', '2015-04-20 17:07:05.554000', '1970-01-01 01:01:40.000000');
INSERT INTO public.ticket_event_due_date_changed (id, src_due_date, dst_due_date) VALUES ('98f68e51-af94-417b-a121-b70ee2e3aecd', '1970-01-01 01:01:40.000000', '1970-01-01 01:01:30.000000');

-- Ticket Event Initial Estimated Time Changed
INSERT INTO public.ticket_event_initial_estimated_time_changed (id, src_initial_estimated_time, dst_initial_estimated_time) VALUES ('7c2e93c0-22df-4d9d-856d-0a1ad23a4e5a', 36000000000000, 100000000000);
INSERT INTO public.ticket_event_initial_estimated_time_changed (id, src_initial_estimated_time, dst_initial_estimated_time) VALUES ('f8c680e3-3975-489e-890d-917a36e0c97c', 100000000000, 80000000000);
INSERT INTO public.ticket_event_initial_estimated_time_changed (id, src_initial_estimated_time, dst_initial_estimated_time) VALUES ('43444635-5ea0-4366-9d8a-cd139aec5459', 80000000000, 40000000000);

-- Ticket Event State Changed
INSERT INTO public.ticket_event_state_changed (id, src_state, dst_state) VALUES ('dfc0f306-9b53-4002-9cf7-2d2a4dbf8be7', false, true);
INSERT INTO public.ticket_event_state_changed (id, src_state, dst_state) VALUES ('957dfea0-0da4-49ce-9460-037219eee366', true, false);
INSERT INTO public.ticket_event_state_changed (id, src_state, dst_state) VALUES ('a94a570d-02c1-49ac-b558-e455036a9303', false, true);
INSERT INTO public.ticket_event_state_changed (id, src_state, dst_state) VALUES ('8dc03c84-bf91-4d20-a25b-27c2d4fa3bf2', false, true);
-- Ticket Event User Added
INSERT INTO public.ticket_event_user_added (id, user_id, assignment_tag_id) VALUES ('799ee2dd-2168-46cf-84e2-b6a6395c4801', '00000000-0001-0000-0000-000000000001', '00000000-0006-0000-0000-000000000001');
INSERT INTO public.ticket_event_user_added (id, user_id, assignment_tag_id) VALUES ('0e842df3-2308-4a12-beba-cacbdf4eeccf', '00000000-0001-0000-0000-000000000001', '00000000-0006-0000-0000-000000000002');
INSERT INTO public.ticket_event_user_added (id, user_id, assignment_tag_id) VALUES ('cfa4b3e0-0944-4c28-889a-3d55b256e4b3', '93ef43d9-20b7-461a-b960-2d1e89ba099f', '00000000-0006-0000-0000-000000000002');
INSERT INTO public.ticket_event_user_added (id, user_id, assignment_tag_id) VALUES ('bcf284e5-ee4c-4925-8778-43792a9378f7', '93ef43d9-20b7-461a-b960-2d1e89ba099f', '00000000-0006-0000-0000-000000000002');
-- Ticket Event User Removed
INSERT INTO public.ticket_event_user_removed (id, user_id, assignment_tag_id) VALUES ('347a199c-01e2-4e14-9215-afd4418d59f9', '93ef43d9-20b7-461a-b960-2d1e89ba099f', '00000000-0006-0000-0000-000000000002');
--Ticket Event Current Estimated Time Changed
INSERT INTO public.ticket_event_current_estimated_time_changed (id, src_current_estimated_time, dst_current_estimated_time) VALUES ('9abd317d-94fe-4e97-909d-af713479b367', 54000000000000, 8000000000);
INSERT INTO public.ticket_event_current_estimated_time_changed (id, src_current_estimated_time, dst_current_estimated_time) VALUES ('31720c8c-19e6-47d7-b1c9-de1cf321d4d5', 8000000000, 15000000000);
INSERT INTO public.ticket_event_current_estimated_time_changed (id, src_current_estimated_time, dst_current_estimated_time) VALUES ('392ff38c-69eb-4e83-8681-79371eb4af20', 15000000000, 10000000000);
INSERT INTO public.ticket_event_current_estimated_time_changed (id, src_current_estimated_time, dst_current_estimated_time) VALUES ('cf1ee266-0f7e-42c7-a75e-6b30de2f404f', null, 36000000000000);
INSERT INTO public.ticket_event_current_estimated_time_changed (id, src_current_estimated_time, dst_current_estimated_time) VALUES ('baf45f47-4683-40c6-ace6-2b735c887432', 10000000000000, 18000000000000);
-- Ticket Event Parent Changed
INSERT INTO public.ticket_event_parent_changed (id, src_parent_id, dst_parent_id) VALUES ('1b139e94-20bb-4070-989a-4e219c124bc3', null, '00000000-0003-0000-0000-000000000001');
INSERT INTO public.ticket_event_parent_changed (id, src_parent_id, dst_parent_id) VALUES ('a6a40784-6e76-4da1-b054-c3bdbcc5f5da', '00000000-0003-0000-0000-000000000001', '00000000-0003-0000-0000-000000000002');

-- Ticket Event Story Points Changed
INSERT INTO public.ticket_event_story_points_changed (id, src_story_points, dst_story_points) VALUES ('2e695d4f-7c17-480c-9ac8-9b59951dbce5', 20, 40);
INSERT INTO public.ticket_event_story_points_changed (id, src_story_points, dst_story_points) VALUES ('df0d8ada-a555-42aa-9495-68ee55263440', 40, 30);

-- Tag added
INSERT INTO public.ticket_event_tag_added (id, ticket_tag_id) VALUES ('3aff9346-0a36-49a3-82cc-a46d923a0289', '00000000-0005-0000-0000-000000000001');

-- logged Time added
INSERT INTO public.ticket_event_logged_time_added (id, comment_id, time_category_id, time)
VALUES ('ce7db5dd-32bc-429c-947c-518a8357169e', 'dfceb74c-29c9-4640-a36f-8a07c4d45ca5', '00000000-0007-0000-0000-000000000001', 5400000000000);

-- Tag removed
INSERT INTO public.ticket_event_tag_removed (id, ticket_tag_id) VALUES ('36c04483-4eda-4b12-a051-bdf9caa4331d', '00000000-0005-0000-0000-000000000002');
INSERT INTO public.ticket_event_tag_removed (id, ticket_tag_id) VALUES ('fc782359-38f9-42a9-bf9b-d26ca482bf28', '00000000-0005-0000-0000-000000000004');

-- Mentioning Ticket
INSERT INTO public.mentioned_ticket (comment_id, mentioned_ticket_id) VALUES ('f3a7c1f1-5bab-428d-b100-a51ad2434eab', '00000000-0003-0000-0000-000000000006');
INSERT INTO public.mentioned_ticket (comment_id, mentioned_ticket_id) VALUES ('d64d70aa-f1f7-4da6-adc3-1cf7c7b716e1', '00000000-0003-0000-0000-000000000004');

-- User images
INSERT INTO public.user_image VALUES ('00000000-0001-0000-0000-000000000001', E'\\x89504e470d0a1a0a0000000d49484452000000b8000000b80806000000503326c700000006624b474400ff00ff00ffa0bda793000000097048597300000b1300000b1301009a9c180000000774494d4507e0010e12161569c8c983000020004944415478daecbd79bc255579eeff5dabaaf670a69ee96e9a6e9a596412d006af283860344ea844d118351895e45e71bc1aaf1318631c50ef8d517f89c6390e5c15651604070641060169a0a169a0e7f1cc67ef5d556bf8fdb15655addaa749f42a06c829e5d3dde79c3e7d76ed77bdf5bccffbbccf2bacb596b96bee7a9c5e72ee16cc5d73013e77cd5d73013e77cd5d73013e77cd5d7fd42b9ebb057f9ccb1a83c54259d2fbdf0b0102040221e7f2cd5c803fca2f630cf9cc2413db37b17bfd5af6dc7b3b53db1e44e80cad72acb1586331d660ad454a8115119905d91e66fe7e07b3e4a0c359fec4e398b7cfbe340787e76eeaef7189399af0f7bbb4b58c3d7037bbefbd835d77ddc4f48ecd74766f036bc0df5a8b002cb648e0d662dd2feed7e273d662fcdf31d66264c4d0b2952c587928fb1d7d02cb0e3b8605fbae9abbe97301fec85e2a4b99dafa00ebaffe21db6efb056a66aa0c6617ca0134a9fda61ed814bf2f03de62850b6eac0b7a63c15a83d660040c2f5bc5e1cf7919fb1f7f120bf6dd7feecdf8af16e04a29eebbf75ebefffdefb379f34686874638eef8e378d18b5fc2c0c000f2f7c0b9d618eebaf8ebacbbf0cb804516774e14595904016ecbccedfe6fc18af233c55d2f82db05b2fb5ed61a8cad70bab1d67d1e30c6a28d415b88070679f65b3fc6014f3a01194573d1fc780ef0ad5bb772de273fc92d37df4c676606a4400a813106ad35466bf65db992b7bffded9c7aea737fa7ef3db36b2b775df855b6defa736cda413cec09f0bf04015fc194f2b775b8e2e148f87987cf8383e283dcba6f8c310e1a1963b0403230c4b2239ec2d3cf7c17f3962c9b8beac75b807fe1f39fe76b5ff93248e932b470212805686331da60b442290556f0ace73c9b8f7fe213c4f1bf5f6377c677f39beffe135b6ffe29d218ff6d058822d58620447800e2136f99bc2d41322e71490d831719de6772f77983b1a2ef6bc360775f5b1d0677000e7feee99cf0aabf667064fe5c743f1e02fc6d679fcdf5d75f471c2708294ab8808891c2202c68402b8d52394a298c36ac5cb9920b2fbe98682f8f766b2d9b6ebc929bfff52344c622848f564fe75977e3b042f80ffb20ec63000bf852e0ec008ad78bcd02aa143004134098fae72c16a3ab835304b80940bdc6f2b433dfc3d1cf7d1971d2980bf0c7ea0fffa9f3cee3bbdffd0e424408345a5b97bdad0509b1943e4b0b97ed744ea60c2acfd05ab37cf9be5cf9939ff4e16ccdcf3ff936c6eebd8da8e0a843ac5d2b242bdc4d09310248520b76db575cdada4130c52110556119c2942ab37b4c6e2a38637c562f4e5391f15bf316f28a4f7c93917f07b668add9b17d3b975e7a09d75ef30bd6dd7b2f599a32326f1e871d7a18cf39f5544e39e599cc5fb0e03f7ce2cd05f81ff0fae5f5bfe46ffefa2c108e57d6c6609476794db862acd968d2481a4489440a01480f5534b952186378fef39fc727cefb1400bbefbb831b3fff01f2a95124b8cc5d9c992abe67fd9e1af4a83e530ff2a0b064367c317dc16c71af2bccf4c6f6518a86328b9be0f454074a608564cdabfe86134e3fb376fff23ce70b9fff1c175df823b66ed9ea6b0781b060827f5b588db582458b16f18a33cee08d6f7c138343837301fe485ed65ad6ac5943b733439eb96c9c678a4cfb468ab5080b7112d31e68d36c3669351a44718c14026d2d5a29f25ca195e21def7a17cf39727f7efda5bf036b91c2676551057299bd6d80b5f7420786b0bc0a6a17f80563127e9e904109b2bcb51653c3ebb6c4dadae11807572c181f84250cb20134c2dd8f55c79fcc0bdefd099246932bafbc82bffbf087d9b37b3742c8e035b87f4308ff74b18e9ac45a847549a4dd6ef33fde72366f7ce31be702fc91badef7def7f2bd1f7c1fad1559a74b274d315a936b03c694051e089aad98766b80c1c101daed36719c1047126dc0a88c2ccbc15afed79ac50c35655021ba982eb37790b66dc50cf671dd1535580fe4fe0cee83d1f3de1830e5f77581ed2088a958968261d1604495c5b5b5be41543d1508d819820333b0785f362f3f8ef3ffeff94432f6ffb60121dd61f64f04a43b75267c01a2a23b4dae39f1a927f2af5ff92a4992cc05f81ffa3af49083c832459e67f4d2945ea74bae72175c45700b412c5d0119c582766b9091e14106070769349ac8486295a3107b594a82e62327af4058538b62b137306225b68c867ad3a686c16d3dc3db1a65688322d24313c2c2d2d4821fcf8153666df785c682ee832861e62fbe9f32961f3ed8655445c517cc627d048e7ec4187fa81c3ef3c7dec336e9208cd5cc9fbf906bafbb9e46e3d15bc83ee6aa86bf7df7bb49bb29699e91e7199d4e17652c42488e39fa68ce38e3553cf5a927b2cf927d68341be479ce3df7dcc38f7ef8432eb8e087686d181911349b4d84144804491cd3cd34576c18e38587cc2757368027b56e0e6528dabd60f0df32b84b5ab1801ffded4fe1d3a80d83d0fafad97db110016eb7d553a3ca575593693c355cf45087199b208bc0b63e98ad299f10d668f724294e9d1558699165888390119170e13e3a3ac61bcffc4bbefa8d6f7aa6692e83ff5e579aa63ceda94f65f3e6cdf4d21edd6e0f10ac59f3143ef9a94f71e20927fcbb7fff81071ee0252f79099313e3cc9fbf80248edd1b6d347996d24d33deffd4a52c1e741f0f61491834d6d6e227c8de154498c5a084416fabe60e7b097e978c8d0b666b31aef22b33b3f17580b5d6412dcfa454cc8cfbde52c0f619c50f1ee812272ddff237187c93481bb4b668abca9fc118e3eb18075d8ac0f58412228a7c7d223c84139cf3a17378edeb5f3f17e0bfef35ba670f471f7314535333f4ba1de68dcce3ff7cf6b3bcea55affa9dbecfd14f38946e6e181c1e208e12ac3168a54955ca016dc1d9272c45f9f4280a492bf5026eaf8cc5ace0b6d5975ae1306dc175f7b11e2176b606ac30f5465009698ae2d37d8f2ac083acec0fe3839319176dec31d06861ac41698d351665b4ef07680c068c74c16f145683b21a6b406230fe51262d10496229896484c112494914c72471cc5df7ac7b54e2f1c79400f9baebae677a6a86b4d7e3cd679dc5a62d5b7ee7e0fefac7decfb1431d7a5363f47a3d94566513271282db47336eda324df9e417040854d61a396540f7332b6197c7ff67fb2458a2fcb49d75301c032299dd2d2d81c25e801365511809b87d77970b37e70cb40630589471d93acd1559e68a6ba53526b7e43a23cf73943268ab9d76dd6a72eb7ed55a936b4d9ee574bb3da63b33a4dd1e79aec9f29c5e9671d69bdf3497c17fdfeb831ffc205b366fe61def7c27471c71c4effcf7cfffa74f70d7855f63a495b073bac7e76fdbc98aa5fbd068345cc7536bf23c63401afee194fdc87c5614fd3526b3d99332886d3d1cad0fd28af3f670a52c1e67e3766b2b3d8bf124797fbbde02465b0c066daad6bd1470edb60eb78f091a8d04ad5db6ce95a34433a5b09e9734c6309d2a0e5ad8e6b4bf7803ab0f58cd82f90b10c2697b1e7ae8416ebfed0e7e79c32fc9d21c211de92285052949e29828499008da8d06b7de71078b162d9a0bf0ff8cebce5ffc985ffff387186a35101e9f6e9bec70ee355b58307f1e711c391193564c767abcf2090b78e601232ee86cbf0cb6d2a2d8fe000d48171bb67c6c10a0050ca18ed1f7c68f53e0ebf0c9513679ac872915dffeab1d3d6e1ab53492985c390d4eaa7274ae51b9eb13182c0d09072d68f2ac55c33463c133fef25d9cf0b2d73decfdbbe617d7f08f9ffd477e7cd9e56479861402292571229151032905cf3df554bef5edefcc05f81ffbdabeee0eaef9d87f470ad7582f0b2601bfde3cc1176edfc38291416219638c265739bd34e7b3cf5f8da4af5d5f6b381570a24ea9780adeb32455fb9cbe0c6c6d5d885505b929717621910df814cf78147c7925adbd6377ca55db14ed22737b5891a91cad3568682782e396b679daca212744a3e0d3056ffa978b59f45b0c54bcfca52fe3b2cb2fc3588390924848922466e9d2a5dc74f32d0c0f3f7aa6901ef7438006b8eeffbcdbf1dbb66cb3940876cdaa05fcc9fe03743a294a65ee4df319fed275a33463591677b50c5c46665fb1284266a462d167353feddef1f42ce2d15385b582d3d8a0b1e43a8fbfd9dde3275b339a5144ae14599e93a619bdb4e783ddf2d415839c75ec124edc6f10656cd04175e2b16fbefb75bfd53dfdde0fbecf9d6bd7f2ac539e8955ba8441bb76ed62e3c68d7345e61ff3baf2dc37623a53d570afafee8407d6b9319c7ee43216c89434cf31da60854046922bee1f63bcab3c2616553732a4f8e8a7127dc0787acdd6be36c0e8c2179ab602291603429459d5065d4a0358edb2b981526025ac60fd78ced5db321a5184523969daa3d7ed91f67a180b2b061afcd5318b3969d52042d8729ace06a5b210d019ddc5b7deffe6fff8b12f04071e7820975e7e39dffcd6b768b55a28a5d05a71ddb5d7ce05f81febfacd25df6262c3da1a8f3bbb4274bffdd0b30f26eb74507e30580a4166e1670f8e9344a2620afbb8ed598d9de0d71afa0b9bac84f398553a2f3a98c216b4a20f6c53149ab6ec7cfab0644faab8f8c10e584996e5aeb3db4bc9b20c21e0d07931a7ae6a228d62aa9b936983aec2ba0f6e091ebcf53aeebbe1a7bff53d3efdf4d3d9b479334f7eca1ab22ce7f6db6f9b0bf03fc6b5e7a1fb587bfe3fb986445021eeb5e366219682773f6d2553dd14633500491cf1d30de3f49429990d2b9845a788be56d05e2f5b3588fad18a296088ffdb4604d935500c5668c8e1ee99dcf06feb26b116b23c274b7b74ba5d5496134792e316c51c3622d8d3c9d83393b27db2cb8e890e3b263b4c7473578496a7a8faf92ffeccfb483b33bff5bd1e1a1ae29a6baee1631fff041b363c3057643ed2579ea5fce8ada761ba93653129bca64208317b32b838ed42f0f91b1ee437639a46128331cca4392f3c7421a73d71b1632e8c4586a938c4e3419aee9f9e2f796a5b356e74f1512b7d94f99134eb8b479cb84afb099fb0186d4ac1bffc668c5d3dd775cc3217e016186a243c6549cc50e2c6f664249108a470af510a88a4248e04ad46422392c4b26a46590b6b5e7c06cffdebf7ffcef77e7a7a9aa1a1a1b90cfe883684be702ea63351067759ec89bd177c85d65a19c32b8e5c865519188b90927612f3d307266945a2ecdb581b16937db9db3e5c2aaf11e418e18a5deb1555e150041e731b6dfdeca52e0556c65a1201e7af9b6047d73a1ab097d1eb755006f6194838614944535645642121f6c7a43c74da422fcbe96439bddca26ca5b1b9e592f3991edbfd3bdffb4753703f2e037cc3af7ec68e5b7e1a0c1ef8202f9581b3e551d6566878e9488b5357cf23370e12c848d2d18acbef1d430ae1600a7d533e7b811d6256a08be00cb813a20386a4382c86421de8031a83b1b20c5001dcbcbdc3baf11c61142a5764590f6360ff790d8e5d28918110cb8a8a8931a1288bca9a426b48959b76d25e4da9b5e1eb67ffd9633e1e1e5701aef38c9bbff86184706f7299c16d2167ee2bacb0015be1fedccb0dcf3f6c0959b7eb0a3e21184812beb776375abb02d00a0f5bf75274161fefd7ac50d3a5503a5bd9b04b69ad6349ac674b6c81c12b31d5b669c54f36754118b23ca79ba668a35939d2e4f0115041716bac714f008ac6922d65b0a5d84be0a5bf02a50d99766d7d6b6162f72eeebee6c77301fe68b9aef9c239d82cc5faf4297cea16659615b3877c039eafa0009b71c4d96b5690e70a10c828424682cbef1ba59544e51044c58004e0d80645a32d284951f2ddd65a8c37f751da96d254e33179d199d4da0767f16763994e0ddfbe77cafddd4c93a5294a29560db73964d863754bcd67a5340f1205d728ca9fcb7add77a9921416ad2dcaffdbb9355cfae9f7fe3f4195b900ff035f3beefb0ddb6efea9cf94228025151411d41b24656c8baa53a30c747b1907cc6bb2503aed06808c122e5b3fc6eee90c6a13ef85d82a508b1beb87130abe9d5af1a90de4dab7d8fd403481759b33f6f1bffa36bcb096efde378dc5991ba5694aa6344b879a1c3ce271bda937874c80bf5d37d47835a2cfe0826094ce5144852c4c6927d7eda529b75ef8cdb900ffcfbe6efadaa7108546b9afc6ab80491ffd51567caea04bb38c5c36890f388ef92f3c8b8f7ce6b33e380c520222e2b2f56334a444207d36ae7f4f6321d3aa3c5d5527d3fd6cc6ebcfa7d3dc8dd889caaecdf8cc5d1c900236492cdfb96f9ac9dc906739692f23cb73160f3539664154af270a1db967855a49c4602366a89930d44c6835221a912492a200e875119710256c53d6a00ddcfca36fd299187d4cc6c5e3c25df6b60bbeccd443f720a513e80b0fbe455064da80f208333940ae0c59a6193ee595ec73e2a98c2c5840238e8922c9996f3a8bcffdef4fb170fe3c9238e2ea87a678faca61f6196a38d8a36df914105660ac25379686033780f19338d66b3f2c9d5433d953cc1f686074e502e0b4dd052de8b588162e7fb0c38eae41e58a5ee6a699160f363966be44d9b089e50e5b1cc1bc7693c1664c2b895da32a3804dae37ba34159eb2d2a44f9730a5f4c1bede054afd7e3ba7ffb1ca7fecd071e73b1f198e7c1d32ce37b6f388548561caf08a6e2ebda6c5b0aa78ac1deacdb812507b2eacfdfc9d295fb33d26ed16eb568c4b1fb3e52f2cca79fc4e68d1b4912970fda91e0a327ef476a6c1f4922c88d66cf74cad291016259617b6d2db936a4da7d7eb493b2efbc019a51a57551c6a0b42f32b5254673f1c68cfba672b4cae9f57af47a3d962e5bc651fbed8319db899edc4d9c44202322291969c52c1c6c33d48e89fcc47c75d03dc7292a272c63dc81d446d7ace6841048e95e53238a1868c5bcf387b7cd05f81ffbbaf03daf6666db033eb85d8087d9dbf63175e560aeb1747b3d068f7a26079ff13f58326f98c1569346a35105b707d05bb66ce1f8638fa5dd6a20a3180b1c3894f086a3171347b2e4c4a5844e6e189deeb162c120b1147e90d7d16eb931f472cdb6890ebba7530e5e3a8f86145ecd674ade5b6b4d9a192edf92b371466175d182efb17cc50a4e7ece9f785803e9e418d30fae835d9b593220d967de20038da8d6342aefc1c3b459ddbfef33bbf798299e84423803a5562c39fad92fe14fdff1f77318fc8f756d5b7707d3db36f4b125e23f34c7d4c6d0ed650c1ef73c8e78dd3b59b1683ec30303b49b4d1a4952429de25ab1620597fff8c7747b3d945258e0c119cdd7efdccd4c9aa14d35cea68cf599bbae13d73e88336d18edb8e68a2b048d870b7ec63253ec98ccf9c68694cd33393a4fe9f67af47a5d56aeda9f979ffe672c9a3fc2a2e161160cb458b27c054f78ce4b38ee556f66e9eac3487c015944b40c0bedd05fce56049040100b4112491a91208965c9f9e3991d65e0deeb7e4cda999ecbe07f8c2b4fbbfce0ad2fc3762610650bba624f6a622a5bfa71620cf43a33349ff8748e7cdd3bd967e1025a8d84244e48922898c19c95ffb9e617bfe0a52f79314383438838420ac1502c79c3910b5931bf0908463b3d7ab966d9c8205124dce48e35e4c692e58af15ece9d5b4789111cb9622191148e85311aab0d973ed4e5be298db59a2ccfe8747aa459caa9cf3d95273f790d42b8c9a366abc521071dcce2a54be9e5397bc627d93336ce9e2bbf83deb98124129511a9cfd065452d6435a9d4577b5bcfc1ebe2a0f89b9748493b963cfdb56fe5c457fcd55c803fd2d75d577c8fdbbe711e9194080491ac5372c2ce36a2b7c692650abb60394f3cfb3c562e5d42abd9a09924c4515c4a684b939030f3f90fad5dbb9697bdf434c647c768b5da44b1c3be872d6cf0e7472c62aa9b32d649d97fd1308dc260c8ba41df4eaed93236c33ddb27d867a8cde1fb8ed08a24a9b25cf1508775132eb31b6dc95546b7dba3d168f0ca335ec9aa556e1061d9b2e51c78c06ae6cf5f8088242a57a479cef4f40cbb2727d9bd67941d177d193bb69546c31b928653fc76ef6452bf8aa1802dc6b7ef8584561431326f1e6ff8e265b48646e602fc91ba7a33537cefaf9f478cabf823498d22b47d78bb7863b536747a3907bce9231c76ec53186abb62324992d28790ffc0dec37a57d90f9d7b2edffdc637999c9ca0d56e8110f472c349cbdb1cb53066f592615a71ec3b9b8ecf1eeba4acdf31c5e6f119562e1e81b8c1dda339778d660814e49a5cbbac9d4411871c76282f7af18b58b1623f56ac58c1aa55fb333838409ee768a55c43466be7f0952ba6673aec1c1f67f79e51767eef9f10d90c491c21a58365b6ae0e735e843c7c901bebfe4e3151d488225a89e4796ff930479e7ada5c803f52d7151f7b1b7bd6fe0a21209202292b8f8ef02d0ab5d7da40b79b3274c20b38f6356f61f140933849682489e3847d8b433c8cc566b9bdc13addc6f854878d3b77f0858f9cc365575e0542d04c622201af386880d54b461868449efbb6f432cd96892e0fec9c6243071ee84aa45508e3b4277996d24b7b244993e39f7c1ccf7ddef338feb827b3efbecb993f6fbeb37f36dab94e1927c0525a638c331355de35777c7a9a1da393ec5c773be33ffe3a71ab4114c565c1893041e9653c95f930599c62db4495f25b8964bf438ee0359ff9ce6322561e733cf8a63b6f66f7da5f21254e022aebcd9d6250ccd6e456de1fdc4a0ef8d35733d24888a288661c2345f80687cfee2adbb94c57d1676e063162f98285fcd5d96fe3499d0dec99eef0c55f6f6522d56c99886835bb2c1b6a232341966bc67b395bc73a8c678a0766245667a4b962b29781ca79c629cfe4f457bd8a238f78224be62fa0d56e127bcf40a3dd888214122b9de3abf03587158e6b8f24982862b0dd66feb0223bf808d2879e42f7fedb0085f03676d8e0f57a2c3e2b8df7a53cefa5e5a08eb1ecda70371befbc8555471e3f17e07fc8cb68cdaffef9c325332065e8ba54bc0d65285658525bbadd2efbbeea3d2c5eb090662376983b927b6b77d62149f918afe4b052402b89b1ad06830b9730b068198b0776f185173f814d133df64cf5d835d941294392487ab961623a6526cb4995e1c076443b493872d942164692035ff43af6fd6fcf66646080f9036d9a8deaa9123e8f8a0258f82e64f16b2425ca0bc3621931d46e9366399d639e4e6fc31d286d888a11393f785d2820670d80940e0245829008e1e94661505a924bc38ddffe3cabfefe5fe702fc0f79adbdfc7cb289dda5705fcc8a49d197845c3323cf73a2f94b59fea413186c359c2353e48ad3d22e5888ca1db60802af8b755f13b8dffb404ae28846a3c1e0fe8790dfb31b6d60f9708b85030993dd9cb16e8e9931a4b9a6932966f29c671cbc8427af5a4cae0d5b477bf49a0b5874fc33186834186c260e3387421a1b3c5d4425e0925260adf41e250669245218a414349388e18116dd652b985c7d149dfb6e754f1eff9a097ccffbe109a2a20e4d6063e114091283a34237df750b69b743b33d30c783ff21aec91d5bf8cd773f1b4ca51443c402d147070811820c43daedb2e8e497337f68d0b7e023d78ef6c470b526a4d2483be193f113ec965b6ebe990f9f7b0e975f7e19584b1c45ee3f21682f5b85b6fe6008684492a356cca719476e9840299a49c4330e59ce11cb17329d6af6cc648c4f4cb3e8c43f61a0913032d0a2e9ad9dcb2653f954a94c23449fce3d92c50b9665e7550a493349186c26cc3fe154a2b8516bfff70737ccf6fe2cd952e1ed8982593d6d20579a8bfee1ad7319fc0f755df7cfe7968564d1952b3b97b65e0a86fe21b9d6440b96b362cd290c369b44912c717b35e1ee77ee507db0dcb22d242f7cc19f72c9a597953fcbe1871fce5d77dd45a423924832b86c157b8c2df51c12186cc59c70c0622789159008411c094f195a263b8a68f10a161dbd8679436d121923230956102731524ab234ad6c1d28f6f7d8724b8b10a284199114182910c6057b1c453493848191f9c8e105e8891d60254248427d586d1f8510b5d94c5be440bfeba810c31b406bcbf6bbefa03735416b78de5c06ff7dae3b2ffb2e13eb7fe36189a8518235805238a196f48920ef29e61df5df98b76011890f1c29646098606b3610f5ef2739ed252fe1caabaee6031f7c1f5ff9ca9779eea9a772f7dd7773da692fa191c4341b098dc1216f8756719491e7e69bb1642096c4912bd0726de9e58a6e3763e1d14f6568689066d22069c43cf4d043fcedfbdecf734e3d95934f3e9973ce3d973ccf1dc353761d2b08e14e7915b442c8d2d3454a49ab91d08c23068f7d26149618d68f6588feda52d4ebeb1091595106b7fbd5490a7abd0e77fdec92b90cfefb5ce9cc346bbfff85724aa77822cb502d28eb7edc9466ee4ebcb4e8d89368faa554d1efb030f54b5ffa223fbaf042befce57fe5f5af7b3d56c09a13d6f0a217be880b2fbc88eddbb6910c0c12270dac5118911085a4a257e6194f5316a368d3bd9cde4c87f9871ccd50ab4912475c71e5559c7df65bb079cefcf9f398e97458bb762dd75f771d175c7001ed56db4f6e56249e088a428ac32f45a92389a28866236168f5614c3407d056fbe5b5725607736f546195c5abb128e1b5efc638edfcad3ffc1a473feff447ed36b747750637c6f0d34fff4fc8b352f8534cc887818ccf68a26fe3599e1be4fc25ccdbff509a718cf05dcfdfea60f552defef67770f45147f1fce73f1fa59d79e53e4bf661f9f27db1d6f2b35ffc82246920e3185485e10b4edd183738906b45ae35da38c560965b5acb0f6464e9725a8d06f7dfbf81b7bfe31decb77c191ffbd84739fffcf3f9dc673fcb094f59c39d6bd772de79e7398f706ced2487a643a538aabc29ae106d24097192902c5aee8f84995554eedd7dabbfae290e45d563d0c632b16b3b0fde72dd1c44f97fb936df763de3eb6ff79c2f65f1250934d0655169e95fbb90e58a91a34fa2d96c1247d2af34a96bc1f77a53a4e4d24b2f617a7a9a56ab45b7db2dff9d071f7c90d13d7b00b8e5e65b9dda2e8a2875df45515808bbacf543c35e12ab2d69ae9977e8918c0c0f638de17fbef77fd1eb7478d10b5fc8b39ef56c162f5acc9a134ee02f5efb170c0f8df0cffff22fecdcbe2370c9aaa64b2b2b0ce13d604419f0d24b5de3382259b20a61b4a3fd82c0ae17ad7d1d8580cc11252c9225dda8ad4159c3af2ffae65c80ffaed7f4e82eaefbecfb9025335717539584a01f1db7e584b1fba4d616ad15f30e3f9e86b45e7844c98ddb873347f1d739e79c0bc096ad5bb9f492cbd8b17d271b376ee63bdf399f4ea70b0876eddae9be97b68e6a34f504586f79dbc019d6326ff521345b4deebb7f3d77dc7c33f3470659b27809b13791b7c6b278f122e6cd9f07086eb8f106a248d6d2b6f5bd481ea6162938f3444a927d568056ae4cb5f5d16b66d53301fc99b523d4ba9d55d689c494b26cbaf366b6de7b749993e50000200049444154e75c80ff2ed7b59f7d1fd2e66560cb5afd530472d5b410084449fb09e7a61a250c2ddb8f669c8014b3de446bf716e496d13d7bb873ed9d082150b9e2dfbefd6ddef296b770d6597fc375d75e8bf4385e6bed824ca5cea12734582ea947135091b8fd3f0806f7594e338eb9faea9f1235132299b0f6aeb56cdfb60d21046996b176ed5a17d4582eb9e8125a8d663d00fbd8ff3201f765e5484a1a8b9622a264968f8b28ef6665a15b1b90087615954f0a5be07c97c5736db8faf37f375764feb6d78d5fff14131bd656adf842e7ddb7184ad83ec33f21dc90adb1a8dc102f59497b7098389244fef15d8cae15ebb9431aae605eb66fdf5efe2ced761bac61c78e5d1e8644181fcc83c3c36e4bdbd404c250a71efdcf69fc185be16aa2b485a4417b681e711c73c9259763b5c11ac3dab577f3f9cfff7f3c65cd93991c9fe0daebafa333edf4d7d75f7fbda311fdcf5f33d9f72b46347d5be18473e14a22896cb511ed21ac4a4b3d4a4d9a20421d4e2176b07df287728ca2961b95b1ec7c601d93a3bb1959b8782ec0ffbd6bcfa6fb79e8673faa312605b75c3e766b95bff51f13e5223e8b4569cde0fe87d368249ef72e37a3d6660fd9cb86b3c9c9a9f28f912c9a427e67a5d11ea2c0aa952be9a52933db37132751aded1dee8fb7a5d0098c36886490a8d1a0d7ebb171f346acb524ad0616cb7debef65fdfafbb008b22c6372c2fd2c135393e51ac1da56132bf602341ca5278a1d2c5210272da28121d4580711c535ac5eda5b94074694857b71808afad2bd0c891516e93b9bc6b87ec3c51f399b577ffa5b7310e5e1ae3ced71cd79ef4018edf176f018ed9fb52c93947f5b7cbbbd98a051ca30b0f26012e95bdf5294e699b6680396e7a3229805822c4fab9f49e7b8d8762029cb32a6a65cd01df7e427d3c9151377df828c6a65aedfbde3614a61e7e0e72d65dc249292999919f24ecf6b4862876fcb491ae3947c01b097b23e635998e5172f7a16042bb3b0208a23889b35e6a42c1e451d96081ebe8d5f16a836f8397103d33b1ebc9bb1ad73fee00f0f4dbefc71f289dd252c1182eaf7ecc5fe58f4cd2658efe0642d1a417bf172e2382a1b207bf7390eb2a0f7001f1ca876b1773a1d2ffa774d923da37b48d31ecd668b430f3d8499990edd0d7721e3a86e55612ab6a35ac1ed77ee08899011c6188f7b67af19c43a1351a59d45e78a15fb9695abb5f57d9bf42f172fed1f70b6cbd6f98ecbb8518ead490932725dcfbd47433802e8ffb7975e83bbb7026d0c79aeb8f9875f9d0bf0bd5d775cf055b6dd7845df9ef8aab8acd2ed6c9ab666302f9c8f899109d1e030c5d4561806055f5c155701c56b61d1e26a91d2c4c404e3e313e42a677c7c8cad5bb760ade5b497bd9cf6e01013db3661ba53247154d7518bc0f852144ba76c6d43dbc0c000c808ab0d799a96366e85c1fdcc4ca7b4613bf91927a374deb703c8964f0a21421b665b15dcc5d75a8b95b2e62be7242ca68cf1bdf031c17b6183a0ee7f1bdcbfa994e5ce2b7ec0d8b6cd73015ee3bb6fbf81753ffa6289b9ddb0ac0802513cfc5aedfeae872d76da486494783acb0b696d451306914ebfd1f7feabf667c06771a514ebd7dfcb9d77aee5de75ebd05ad36eb7f9d0873f4c274d99587fb76b820831cb6da8b62abb7612351868b75becb7df0a00c6a7c6515a23ac2b18d334657272a2fc764f3be924b22caf855461436b0de59e9eda32d8504446a1b731252c93c852ac26aa1e10fd42dd1adfb2b7eea77faf34cef4e8c6f3ff792ec08bab3b39ce4d5ff8808322bed358eabd03b0188aa86a34588d19ab02cac8c8154b850eba289644f5b22b6e5a10ae531352f2c98f7facb6fd37f5dedbd65adef7fe0f92b406984a3326d7dd4adc8c1d8e67efe7ae502d1667c06419da28b4369c7cf233105144da4bd9ba6d0bdd6e8f999969b6efd846b7d72beb90134f38c1419a1ac6c6c38fea1495ebc10b5351130c0f63bd6e452070a36c51482f8afa4ded572e569e8f1576af4a0e47672a05775d7d11633bb6cc05b85639577df88d98ac5be9bb3d7b22fb82d8323b79cf66b14569b28997bb62ebeb478a1d7e96c09dd2077f694caf356ff8ab37b27af5eada1a126b2d679e7926679ef56666d20ed31353a41bd79334e2a07a0d1aa536fcd5636261d159973ccfe9a519a73ee73925ab3d3131c17debef65c3031b98f6852c32e235af79354b972dade5d5feb582d6986a3da13165806b6b2a7f7063f00e74d5812c6a9c7e4b8900a254ca5d41bfe963591f49d739b540a63497fcc3dbe702fcd6ef7e8174746b19dc52b81b552bf3fb8358d8daae9cbd05b94420ac865c9559c7f66db9b4963e1d78fd674b92845b6fb995673df399b45b6d162f5cc4673efd19cefbf467989ae9a0b565fcee5b31533b892282264bbfd96ce19962ca81659b67f46666b0c670cc314771f0c107d5a0447198e2a4c1b2258bf8e0073e14ece5a1a4f06c5fc16c8cf67ee2b6d4b31b6350c660b4c6665d575c5a11d4203efbcabece51c190f409d944df01132123e5e35f5bcbf60debd8bd65e37fdd00bffbc7e7f3d095df0decd6282bf5bdadd1a970a5a8658e9a0f7d510c491046a3b28ee38efb826776b3a41a04a83e6d98376f1e575d7d355bb66e61e3e64dfc8fb3cf66264dd1c69066196337fe84288ae927e8288a3d53f3b42d5d628535a493e318018da4c9c73ffe3186e62dacd34348860707f8f257bec2c0e080e3edfbe83fac29592363eabec9c6b88cadb4c6588dca52f4f47825370e8745044e472e676794a2992682225c06f7bb008fa236b00db9365cfaf177f4c1aaff2201bee3dedf70e7b7ffd15380a236c8d05fabd599bc400464fb0ba2a011e4337867e776e7d66aeb7e1fd502d66ab547359e567dde184d9ee70c0e0ea22d8c4e4c92e539ca18a6c7f6906ebc9bb895f8d95051418642b42da9b6a3150d1fe37892cee84e6f93a639f2894770e105dfe775afff4b8e3cfa689e78f81338e3957fc64f7ef2138e7dd271258f5e57cbfaf5dd5410441b53ea5ef083154ecd68509d694c67a2a45d0b76a968fb3b26c5f6e965451f7325fadc8244601fedbeb6e88f1a63d9f1c03a1ef84f561afed13b992a4bb9ee33ef728fca60a0b7a2a1facb748ffe6cdfbad4bd34218b2c27a5251282e98df791e5a7541855468169952d1b3ea2b6b158cc2a10b35cd1cb32ba698f34d7cca4193b7e7631118a286afbd7616b7542b9c9210448d6faa795657aeb46945290c468a359bd7a351ffef0b9cec8a8d8b1690c4ae515d8b1f5d76a3ce1ee3c055d6308e31758198355cafba618d4c46eb0dacda34a90defe59d44c498b152dbee32b6d1d15dad049b738ccc64deadb803bf77033d7961fffe3399cf5b52b9032faaf91c16ff8ca27d0dd69a40c9282080b987e16aa94fa94755c58609559b9b0b8f7373a8e05e3b7ff9234cb9ce94d3163d98fb7cb6d0cf5a64cc129e75a93aa9c5e9ed3cd14a9524c6edfc2f40d9790349ac49128bb8fb6ea92d7f7f60405ae908ea599bc6f2d5dbfa8d518cf86142b4d8ce7fe443f13634aaedc2114ed83bbf04831ce25d63bd566c6906b8b02f25d9b89a2c4fbc8489f60aaf7a0e44c4cf5682c3bb0b5af731f28d8276b65b0e2d00fb905d2dda9b11d5cfbcdcffdd780285befba952dd75fe66e7261b7566b2604c29ebdeca3acd2b6adefd70902b3c02c712c5093bb99999e42e9c2e0d22f77eafbbb25bd66eb1b86f35c9366b9db5d932b3295d355861d3ffe2e8d66832876af41068d23fa191bdf212db2a494cee4b2b3e55e2676ef7219d6ea72bb43f1b319e31ef3aa801d5e4466b06074b9fdc16887b3b5d6a85ca18c761e305a932bff6703f9ce4d447183388a89a2a0c40c9b5c4544843f7bb94753d4928945d4166895f7d4c3a3026e1a03377defcb4c8f8f3ebe033c4f7bfcec136f2d835bd66c18fa7a2d05cf1a507f95a9a60df6ec88be064a358c1bc90819478cdd7f0f3dad3c5eb5cee4d286cba77cf07b1863fc985bae349d2c27d79a6e9a3393a67432c58e5ffd8cce1dd7114582248e4bfc1dca09fa751c9260584348377c11c7ecbeef3774d214a30db9d19ede337ec588cbc8d6688c72c1ec283f83f216c74511a98c422945ae0d5ab98fe5b92253eefbaade0c6ad716925812458e4509794131bbbdb0d72a5f077d83fa8af24a87636ce125234bc89969c505e7fccde33bc06ff8d2c788308e35917d59db06a1506b36c820f203dc17acb32e03d7865607ae884aa460cb551730dd53284f9939ff6d53e2543718e1706aae3599d26479ce7437255339d3bd94894e87a96e8fa99ddbd87ed15768b69bb45a91a707ab474fa89f169ef2949232b08570d0204aa0d96ab0eba69f3393e50e232b47e769ed283d53fe8cc5eb730720f79fd7c6902bf773ebbc782dcedecdbd0e456e3469aee9aebd116134898c8823898ceac3dbb6cef4cd66846c7d75a229a643835aa3ea187b6b396b9c8438729fdb7adf5a1efacdcd8fcf001fdbb689cd375d4d229d7582db772301e9b7fc96a032a0210210e8b34631176382454a6e24ccefb809e0b514827602d9d60dec587707692f734c83326e8953aee8e5399952644ad3cb737a59ee1ca152b72664a6db63b2d3a1d3ed91a5290f7ef5e324f9348d5812c7b294e1869346b2285c8b2419c030299c5a301692462326dd763fdb6eff15599ea194cbbada68e735687469aca9957207406bacd13e536b17e85a390caeb4eb8e2a4d96bb00cf72576476d7dd44b3d920490aa3d2bd34ccfa8c382b83807a73a9d8de664cb557c814100530c6bd4f26747291ee6b2ffec4bbc87bddc757805b6bb9e18b1f2542236561d8236bdc7529732de5ac45f3a558ece4d77b1883d2d5260263cbf5bfe51e49636db9be3a8e044964d87cf5858c765232add11832ad498b204f337a59e6035d91694d2f574cf57a4c767a74d28c4e67860d5ffa28ecd944b3d9a4d98a1c04f26f5e4dcadb27e292beb074fa7649ec0778e338a2d96cb2e5aa1f32d671eb0033a5c83245ae8a80358efaf38564013fac7681abb4f2585b936be5f1b822d53999d2a4c630b3f646c87a349388d84b872d6ed372b8b1b964a96cddcecef615f31583634b9780928b2f16d91aeaef8f8768d3a37bb8e38a0b1e5f013eb16d23e3f7dfe11e8d959a2af0f236b3f8d7aaa6f437d20774ae0d9956e4fe51ad8c25b7eebf62ab41699920dd30703b164cdd7d13f75f7b25db4627e8a4a93f28ee7be4be0833c6ad1ae9a42993d31d66ba5dba694a676c9407fee5ef500fdd45ab842632108355f5822828b4429a54c2130f57bcf354242191d06c2664a35bb8ffaa0b199f9921cf14599e93e6ee49926519799e93abdc158cca39c9baec9c93e58a3c5328adb0bed84c73f724e8e58adeae1d746ebd8a661c3b737f210248e18b72e3d58b657636813b00b591b592f72628ca31688a7d9ba134d827222a3f17632d3fffca27e90422b247fa8ace39e79c731ec97fe0f28fbe0566c6dcd8548945851f5008ca76d1d7daf699c0592d689471bbe40b43795dacfdf038dd045db6526a2bbd71a4b68cde751b72ff27a01a83ce424204030ac2995776ba3d263a1d3a594696e54c6fdbc486cf7d00c6b631343cc840bb41128b590318361c820ef8ef0a6105e6fc5e7465ac404a8bd282c907ee215e7d04c9d03091884a3f71a34d95c57d00672af77046a39483340e93bb274f4f65ce2eaed763eceaff8be84e32d08c49e298b81ccab0251b68ca967ef871c1ecf18980202a0bf602a3173a1b119863893a87207cbfd31a4637aee789a7bce0b1dfe8d9b5e16eba5bd6d3f26363322cc8f0ab3bb02ec80b2e35b8f1c5865fb73455bb0d6486da944bac8d9fb904231c2f1b7996209292461c33d402d14d79f0f31f64e259a7933efbc50c0f0dd108288f5cb9668e1211bd8971b65f763e93375f45222dc323030cb4136414e8c8a528f74a8af011ee8771a50513bade5ae10a2e2331c612471a8868b72cb663d9f08dff4df486f76096edcb50bbe50f8fadc1026b8a02d39678bcd09964da15c7dd5e46aa61ecba4b51db1f6478b0553e3d8ba65311cc36d49b95015b71de2ec3fb6464cb2d8555a4cb62f96ca5bab4a5b6bc3a2c78e60c9fb41ebaf55ab6adbf9be5071ffe8807f8236a807ff9dfff77a637dc4e238e880af23f545494dcb329578c98e20df0593ad7864c69c7651b5baeabd6c631322eb81dde8ea55b701a4b513ac8c6be56cd72456726a7db4b11fbac66f8c8350c1f7234cd058b889b2db2a9093a9bee67ea9edb99befb66e84cd01e6a313cd42649224ad709ff3a8aaea7f0439ec56bd1a58a8fd2e847048f74837ba228cf636b63e9f4727abd1c3bbc0ffbbfec4c96ac3a90a1560329fdb259ad4b1c6e0bfedbba42531b17dc4a69ba594a2f37ecfee90fe9dd7b0bed76c2602b7186a332609e8a2c1c16ebc67a997a8599c3e68d0df07855dc870b6b99e51d09b67c6f22ef8c60813812ec77c8e1bcfa53df4148f9d80cf09d0fdccb4fce793d038d98c48f7389b02277e32e682bdcc9f713e8d658b42d5ca0dc306b9aeb7277bbd2068de080273d8deee428630fde432c5da0bbe691248ebdbdb17496c151a1c3d6d63dde3345af9b92a6195a5bac76a92b4a62a224a6d56ed26c26b49a716de5b798a54baff75c2b159ff5766da662776cbd10b33e135bebdcafba69469a19f27890952f7a2d8b0e7e02c3ed368dd849158b0d0f79a6d03af73588a7379522d59adecc0c7b7ef23dd496f5341b927633a1d170f7c196f6d0759c5c24186daa567c8de3f63faf30d425c54590176bcb1d65543db1fcd74a41e96a50d0c391806623e1359ff92efb1c70e86333c06ff8daa7d8fcf30b687833f748066df7a06ba88ba685cf7ec6b8ca5c19c77664992655da6771c855c64bfff6d31cf4d467b179d3667ef9c58f32baee66a228f69d517735e28824f29e20322af7f8d86040b778346b63eabe7e58ac2c566ffb5117114eb404cf695bf9761774a57b2d26d86eec9f4eb662204a8db667219436e4b9a6a714bd0c860f3f9ee5cff85306172da61dc7c491b3abc895a697656eedb876f746e78aded687d87dc5b7884d4ab311d36e24c40d492c65b942dcf6ad36b45eef6208965405f0a5606a4df8720bdcee218923003cf411951ab4b07fb64223918e22f60aaf5840120bf63f6a0d7ff6f75f9a6dc2ff58c0e03beebcd16f2013c888724ade96da8baa936603c8a22d5e5be1de7055e0706548b561df438fe6e867bd80c98909549672d8cbdfcc65e7dcc440ac88a42cdbe6a9322491a4190b5464497c260f3ba3b210f24751f906ea425fa76d6db0191dd83c09e347e00a6f15ff9f5fc95d646a658a0ea9c50aebe9344adfc2624fa6b52023e91c002444c2d0bdfb46d6afbf9dc68a839977d8310cad3e8c64643e56087265e8757af4766c61e6fe3b4937dc89ed4ed08e239a032d9224f24b6845b9c39392c736d532dc107e0433a3e57b6202d5818ffed2273ce8510851396c9982552a9e0646046a4d43242446088c81ad6b6f66f743f7b164f5a18fad001fdbfc00e9e8765a89f41cb0f058cbd604dc21c75a663fe35468a93264da92294d9e1b94056314a7bde31fcabb1ac51102cbf4e28368edb99f5c2ba2c02cc88d6a49ac556063b41408616adb1b1cad18957ae6e2c899821bb660d03ebbd9401ed0674aefd77c14fcafd38f089fc98bb22b802b22c8e0dec745b8b5c234a42049daaed1b3f96ef63c7027bb658c495a88247162ac3c43e894485a06938478b8ed0b798994eeb0695b7811da9269327d4fd0b2c60f285a1b70e0a6544854a6a2eeafc9229cfd9ca7a8a1b6b238f6191f2cd244086189acc00850d672d74f2fe6e4bf7cc7632bc037fffa5a04b6dc185cba535174238bc68ebb39e5f4892fc232cf51671e9a64daa24ccec8e215ecb3fa402f4632c4714c14c59cf4925773c107dfc401abf67599c4bab91e297cb3c446286d3d1e0f0df4a51b4010aad88deae18bf40de9ea0dd53a1019595d9706d88a1e2b8b498f510b0850bee9c15c42b132a53ae826b061b3104744b1a4d54e7c565458a1109103b2423441484f8d3acf402b709a110f1d84a85489c5bf69caff3c62d675854431eb59b026a6b04cc6f884617dafb2a00bea12671bee712c8a6e401ae3176979237d6bb9e3926f3fb602dc1ac3fa5f5c848c7da3438a598e4fd5735104858cc0f8e2d2f8268ef22c84b6963c539cfcdab7228433dfc9b2ac7c43f65db59af9873e1933b305ed3dac111a2120d7825c5b1a3242c6a6f239ecdbf353670202bb60ff1696ea3d63a9ac3483664f61522eaa03511cd85a66a4122a855616e5c89a707b77646d1531418fd47b4b894aeea78b0f6b27892aa69f44a1c00c243dae06f0c1695dc15e51f4a2363c5d0c3398c2d5cb4b742b1d4208322b35a7b52258c4eb0b5c0cda1a222b4b4c6f8d9bcbbde3b2ef70f4f3cf786c04b8ca52bae3bb1888647d598e15ae3113f0c5787ab0ac82c0675c7c0bda90fb7d30ed054b59f3a72f254b53f23c43a9dc29e8f21c6d0cc73ce705dcf6adcfd06e561cb233b8914eee1a1962e5fe1c49e902285ce01118713a4ab0624b1c3de9671eadf03c7c488709843ba2e59a9112cf17d8dd0a07746cbd935bcd345acfb16b8c2cb2b2a98423818bae087266e1a462bd4533c2b72603dd1a3a5438ba80ed4e4db268d5214cedd98130d60f220b6790ef0b6a636d0dce98709aa8042fc58e510f600a4e3d182491160c12834b12e160923696fbafbfeab113e0e9cc2456e710c7252cb165ae0af40fc652773a11182b1c156834bddcd0cd9d79bcd29a239ef20c72a5c8b3dc310859eec4495a93a629071f792c174f64ecbfa8e1c82ae19f20da22a5cbc0b91044d2944d27297cb3a9c4c9f519cf2a8b99a0956d83c99f006752b4bf4d093644814f3d0c3136cce3c5c2a8ca90c415c8d259d715ad7dea361055651c1481c662ad42577914616ce0a8eb6e7ad15a574af38af79cc7d34e7b351b36dccf37def306a6776e464a27e58da4ad772d8d75933bfe188bd27cd343152bab679128365bd8306f398013f401acacb0ffb6f5773e7620caf4e8ae60cb411525c6d8d29ca600afc2e3dda2c766ac232b52e582bba7723265e9cd4c71ec9fbc94b4d321d79a3ccbc895426ba7c3d046333838406bffa398de7d2f49ecb69f09e90a2ea1290df4a5a1dc6f4f0021421a2c14eedbfe11366331a2f219b4a5e8c815c8da1a3ff31805fe2162964a4f789c2dc2312f04426aa4f04126abce699118acea9ba42f8a41eba6798c11a5fbabf5215f6a4c8c455978eaf35fc6d34f7b35dd6e97248a78c699efe25bef3d93c1a11117c4c696ab0c6dc19c94fb795c369e3d565815a322687c21849f13f52c95815c1a1a7e74d96251bd94076fbd8ed5c73dedd11fe0dbeebed5ab03ab415b5dfa95f8171dde1f513cea82468ed79b28ed34cfed7df6e7a0a38e45a5a9efe4b9c100ad4d6d9bc3f35f7a3a5ffdd8fb3868d1201a818c4c396051c598047222bf88aa0a3c13e0c67a26b71e5ed8420b631cafa23d476cfc489cf21cbe282c8d85e3df9db98e7430a02820cb72d261fd4816cb6d0b1d8d2847ca28180b2bcb62343c2c8eadd168edf700996af2de5180c67758059de971ce78dbfb2b5a561b86972c63d1014f646afb43080c5114b9e658f9042e1a93b25648176b138b1f4688106e39a98235ba3c34452657c67919c6515416b4ebafbbfcb111e0bb373d50d17e9aaa583255705736bcc59083e3958d29ac160acd84a59b6b9efdf2d79067996b55e39b41da6be03c3bd1ed7438e9d9a7f2990ffd2da3dd94812441ea8a7f0ffdaf23119a0587ec41ff7efa22787c9169355a0b34ceaea1a8178a6611d4461a115221acd381b8924412e166329d759a2893815b11ee5723fa274c25e8aa8ac2fe660d457d40357c6c8c285990c2ddca4a4bda4979d5db3ec482c54bd046936739d61a2260e1139fc23d6b6f67d5920558ad313272c5ae6f1459c206576de3600dd309ea26a2ce97d196bc7a55d30837761ab9e3ba7bc37d18a5dcbea347738077a6a76a2d6b55f86888f015d3d7e0319e5172456588777b53131c75e2c90e07fb312de36712ad2d16a6ba00eb763b2cd97719eb363dc4218b47dc4070a5e8affcaea98bfe2df51dc936e8ec85da736382ce64d0a52cecab8cefc6621c7b144199b5a5df712fa59bcb2c7f2fa260dade755323a1914475132951b90a15d3f445f754dbaab964fdd305cfb58b42d0a604ed79f339e3cd6fc518439e65642a733af42ce3d0638ee7e2af7f11bd7b92950b869c7e44ba27875380bac251060328eccd4c4f10b809ccc2655efb8283534296107072d716b4ca1ffd019ea7691908421ad09272c6c1f49d765b3c0025a0bc88c8966635cd28e1c8c38e67f1f215be90c28f9bd5a77a0bfc3b3939c9997f7e16fff6aef732d3e991352cc40211834822a258d04a22861a31c32db709388ea019c744c2edb26935e28ab810b6928312f8fef9dfa7cad0cd727265e9e59adc687a4ad3e92926f39c6eaac833ed0b50af701485284c7a18a21038bd4699b5254468aca703059187357dc5ad2da6679cdc154b55d6063b2f85855e679a57bfedfd4471ec75e68a3ccdd1b9136c2d5eb682a5fb1fc0ce4d1bd8383acdca85c3e56281b2560812830d4608430943218d2d0f62add02c787527c530c63b8d2230594a6f668aa4d57e94377a8420d786c4588436209d663bb6c50d2a1a291ea7221152975a90021726444cdd32c1099f7a8d3b387e91a9d67e38d7048ea9bea1323dd3e1c457be82dbde752ef37a0b195ed562785993e67083e6a02419889d28ab6f66cbd61c5bd9ab275cffda8ef000106a3b3c5c30c61554a9d6f432c5742f67a297b373aacb96b119b64dccd0c935492468c691f74381c87b99178b9e1c1daf3cb4f18accbe1f2564ec8a7411c8ecb142b0cfaa0378c119af25cf3dbd9a65a4598f5c3b7d79afd7e34f4eff73bef6e973994e153ba63aec3b6f1083ef465b8990061b09842a74f0b6344b2dd91debbc528415655bcf756d8ba7a929b7ce55da73d7759ddeb995e145fb3cba037c70d13eecf1022a21a57f330c06d7452c5be4c55e182910da37847c26481a1153374c60b560e9114f20cd32d794f0d608699a9654616605aad3416eba9d7ccf16eeff59c6296f38862811f5e688edf32db1d4e8cb2a60fd4d37fd7bd8aaaf159ef61335a981ad356422e96630e32866b011b168a8596f751be8e58ac93467a29b333ad365fb64871d133dc6bb590911a47536c785a2cf312b1674d5b022685895ebbd030524da70ca8b5f416b600095a5e459462f4dc93317dc4ae5743b1d0e3dea49600426b24cf472069b19f3db0d221b61846bce4b4db9fabc802d88d0bec9c122d7f5ac046636a8ba2864cfe19d3596a93d3b58fe682f32571eb586fb7ffe230751b46b2060c00817f09117e048e96e9815021149a431c41134ddef9bcb000020004944415422492b69b2652a63606488c6a2f9a4ddaea39b8c416b37249c77a7e96db91f75e73534b7dc055113a4c47a4f946a774dd06bb3016f4c25b8281b26867a26ef63546a0434155314ea2f0a67db30ef8bbd7c2721a1dd8c693763968db411cca37080eb649acd63336c199f66cf748f893467a6a7ddf22be318965894b9da413d198ceb1578de1fd68ed63cf3b4579067a9576bfa3ac6ff5af4dd32e566568511881c46677ab413678d11c7206d54359a44052ecb1754646b15aa158b66912871930de51a546bc47b537ff851b63f78802f3ff03037346b22f7d4122efb6849d92088a4132215e2f8c88fb2253262a861191c6cb0607e83c1430e63a6db25570a21a4f3e9def1209d7b7e457aefaf20eb20a20622699729abb62ab5c81e41cc59634a5d9029f87a5bff3b047bdb6769896bcb58030edd548abb6a724dd44c3e0b4c5d045428b5752bf91cde4da460ff4543ac5a38e8c453c232d1cdd83ad165ebee1976ec9c615a684c6489a4c0ca8a152a579dfb117f6d2d27bde065ecb7fa4054ea99283f146cb5a75afd5dcbb28ce39ff13c6eb8ea626c923093e64c76331a51db35cb22438c9ba0b6d638fbb7b0632aacd38dd79a77a6ec6217161252f6a50dafb1ed8cef79f407787360c889a372536692e2940b6331d220885c78f84e9b34100b68c511b194b4ace0a4d30fc0c686f10b3fe71e856907d399843c03631c7b123502cbb6ba4d7239295424661bb4cf6db8a9cc96e35555b6ad6d68af3434a5fea38f4a84bef581a18a25745dadb41fb6a8474cd5fdebe7741c36352803ad46c4018b8758bd78087d8825ed2aa6477336df39c1d85807a440c790b704aa65d16d8b8920cf33feec4d6793a769298530de63c549752bbe23cf735ef6ba3770f5453f6070380205a3dd8ca156421425ee70faf74fcaa8b2bcf6dcafb1a24e639a4a966ba5177545a6c659c960ca6b6674e7a33fc05b4323e44292694dac05d237725cb347125be7f7277196bd91a8740c6e304294e640d2a6a89d0fd4b6ed5aaa35804e9b11aee60e293e5b7a7450feb9aaea6d4dfd666a50a30662fb25be8162ac823961408b205eeb7b2683ee56f9980f4e8f53fe05d2d4221d1a5b073952406b20a13910b368d500794f31bd2d65cfa619f66cea60265d0f3347b1e4c8c359bc7c79a903373e6b17c3cc1576765a9bc5cb963332329fdca6e4c6d24933267a8e71728e64ce1520f26acc722842088435c1e3acbac795bfae296d29dc9349d4d6858f6d7de8d11fe0511cb3f2c835ecb8e39734628954c2cb23254406ab5d752d7d474f17234e4543c1cb4cabdd5eb6c278d6063a6c51cbc23610f1189f3eb4ef329a20c3175dbe22ae448da60df2ad606f544a7f02ef53d4858568908f6dc8677bef3edffc127bb385161ece59518741e140427168952bd487f66d31b27a80032cec593fcde8831d46f78cf3a28f7c10ab8dd3b47b99b1f6469d659f1febb42bd632313ec113e6af64c3fdf73333dfdd8d4eaa9002069a2e73c702641495bd0da5dd449211c1212df5fe651a2fe73ae3422b14d51b42ff8177dca323c085103cf5a5afe33bb75ec740ae11892046b8f25b458e5af2c30852b80ceb1a8da6a6a9ce4cc804d45daee897680672d442f3528c8c8543b1ce945eec2524ebfdcbbdde66eb5ba0a65eb4d66aca7ea2bf462dd69078b03bc8e750492dd757409dbd75a40aa56c981b3199831d23ab06987fc00007da458cafbd92ee130f26191c422bef8295e5ce4dcb5bc0b9795767d6b967cf1e0e7cc2d1ecba7b1d833b13b2835c143662c9a2e19683195260c2f1356110da6beb03f9affbb5d2c4582857b347910c582e770d2d5cf2d8187838f4b81369cc5b4cd61b23d2c5cb135861905ec823fc545889c36a3eddff7f7b5f1e6e5955ddf9dbc339f7bef9551535524015a0cc18310145e93805344a97314e312ae9441ce8b4c684b4498cb65f62ecd8d1244e31d86a1c5acd670c22518ca41523ca24508032543114a055d43cbde1de73cede7bf51f7bede1dc577626a801eef9befaea55bd7af5ee7b6f9d7dd6faaddf806883e6202079559d3691f9b2a3add07783566e14e4616d0212a14d190810618664c62d0925a55aced76bd3fd29db980a97fdd90eacb3f9512eda27bd276ea015a1980410d91300c9ec33ddb8ae45147370b0c69fbe9b6ff90eb6dd713d969d7216ce78eda5b0bcb9acaa3eeaaaf6bf8c5ffc98c660b699c531679d81ebbff2798c60049d071df4295d2c9f1ac5b28951f41bcb2e63046b81da7acd258906242c3f7502a3d21f328292d58782771d9392d23e826fe4d1987271981738003cf999e7e3ceabfe0f8a2033f1aeeb51191272625201714f9a78a7b0612326b000d6cbd7d6e1e31db3d5288a97d336cd7f906d45088a0467805952c1cc24a508678ba016f08dc496032335705cdcee40718722b51ead7955046274bcb963f05376d3c72d673b4fb935ce460d74c6cb86f081b29b6ffb1eb6fee8461c73de8bb0fcec17c04a8dc61acfadafbda7a1310d8cb5985ab91c0534041cb49118238de96e89b1824df30dc5a7656032c6cd6a105d5bd6638a24d303b725be8757899cc53f8691a945474e813fff57df88ef7de91328a4c24821a1e1c5c682d31aa48a06679070bce8f19c8cf8cdf09a2b90a59645784c2e0b1a4747311ec433944552b1a3ad50493d090d1ee3016e19e8b9f2a19216865eb51019c737888b85daea819c18e06d084631d830c851f212cfb14d91476e2712d620492c41a3a9c389945da940c661d3355fc5c3dfb902d3a73d1323c79d0a3bbe047d4be8d5359aca7b248e4d95981a5f81feec0c64a7c0aae523583a31caff9fe38384505b8b86c81b81c2464f734fb9b08c58a525980c7e35926d24205badd8e4d295474e814f4e2fc2732f7a2baeffdb8f0228515882529e31a784040c453aa804fc662ec086320f04e1c9dc11e3aa399bce659b32ee4339ba3ad739a6f1517241092e36076424fd01c08413671c70c03373e0a671a1a25c8c0d1479e06cc8eca18c76e7d08e303b40db1f379394040c512217476297f1ef4584fe92d36ee88f997d2f0576de793de48fae832a4ba8f169d8c99530238b517727d19f9ac2c8caa3d0ad1d9ef6b32bb074bc0b638cff1e5b9f685c59f2be8e862da98d8cf6cdce5aff73c98c842024a3641285f4acca163b4b484cad3af6d1678e3c96ce5655bf8fb73def541c35d641a9350ae9ed1182cb91ccd2be64a0d26628861796a5c71fb5368f494645d18fc4c543383864c5364fc505a42f6e19007231d07a6432c6bce0a34a5f44091a16282b05064de5a9257e0bbdbee0afac9569d18e3c39108a13d8e3990739519b32de126e044c3404eb7274495c0409ff1d0e06a12a9e388a7f3e41909220524bf0de2d1c12d0388ba6e1d3dc78632513112ceb3f3e245b68816e5160a45418d10a5a79444641a0db29f06b9ffcbfe88e4f1e1927380074ba5dfcf66597e3a397bc0c635dc048096dc963a9ca7f9383259a10d2173943687eed6c90d2cb9856cb23676c4b28a597050a6730da8990ac0044934e43c04158910d88940638eea76d7e426753695ce9470251c6f20bad4910de8a0c59c9aa370cd851b81bd0878c04462ec856299a95868514317db505ae98747a875106418e27844f75702ef2d07da1bb6c032ab22875db4abd4b6891177e18eb5039e70b9a9d7e1be3ad9b1b56ebc3512c6ec1378f928a9fe2c1c62f8dd9634b56a0e8748f9c16255c279efe3338f9d917e2eeeffc03ba5ab15fa081b4cca083f38903e4984814c402b22d3da06cc922d80d95e559213623b626c1eb10c14e8cadc49cc8e8b98ccc64bb650aa7b913198b2483149dc8500b05083bd8a6c7402a412e9eb95ed09012cba2abae73a0364b7de02d0c64c887a747d6828808adb7349194213ee4b2b00c215884c2723ec636402e11e0824b0ce5c1c6c47c20822142ed1c8c2158f8940c63fdc695ac882c9c1063127a6f2d012d92f574fca14a8155a73e15aa288fac1625bf2e5d771eea5d9bfd6349823796ac76891e253c5cca4813ce1edea9dca33b2a825a3df875b8b4960fd0b9c482125a00510fa87b06fbf1161043ed85bec8b6a9a2d553fa1e9c44f20a8f87bdccbeaeeceffc6b12915d178b37fb5811d56bfcff67c59d04f899f51a2588b495439af9b92c58b16443accc3ec6b21d4643f0b940ec5206b6b70e712b619309e14ff0420b145aa1a325ba458152f96da896020ade20f5bf7cfc1b985cb6f2c83bc1c3f55b1ffc0cdefe4be761a25b46b34ca508d2faa1538aec91c977b85cb0711191d64a8c32c4d39a4ccb9129ef6705d14249950060d082ffdc80a63e74c920df160513f77864a610f71618131ebfa1d0fd109d5a10e10653b7f8b50800865ab3576c3f02c538f44e965a4e00bedf7631fd2cdda0e126b011a9f2ad43eeaf925b5988289c00049c0803ac274e19f65134961769102cb6f6e2eb30bb045b9940a4d342310558b0851ee2cf72e993ce7c4c8afba09ee00070ddd55fc7877ff7f5182d0b148a790d71e84c89082d1bde5c49d23a49d95b299ca04c984e4e516d5b0a1c2896b03520e63d774e0558c83ba19f12b907d18eb74ede2922de04f869614ff9ce63505397076666374e42930274ea168837c2b6b335a64ac4e11251549179b56418a388bd3cb14fa41f22bdd85ac49f4318f455105d04f99d9428b542a7f0c28e526968a6502b6e597ee5fd5fc0aa279ff698d4dc414d3a3ef7fc1761efeef7e1d37ff276945aa1540eca84b43264c34772971a2ceed68a7dc0e4158e1244b6a098647be01303436476a244d31b2cbca982f90e8878506d1747a0ace68b77d1da44b6969a037f96a90db1193745529bccc5e8086506f9ad54655a78d30ab6a796d24258bf440b1afde02f2432b7a020918bbe30acfd346c0917ac2052f25afaba95f0496e9221e1d08a281e6429405d2471da05bffc9815f7412f7000f8c557bd0e4e485cf6aedf46b710d04ab1abaa607aad8c3d9f942e4162c8b47fadc213ad454c38fd286ba245be3accf48c42b41fe3e9900e8f7897b7e42d62d08102c765ab90651cccf2be57507b7bd752df84fec365c7396591960c3112da4c453a80b2c82be9398935c0ade49749829dbd2cd0464b06a801117e05a23f7bf254441a5ef9c456ecd1ee41038623435ba2bcd03adc904196f7cc5f79f3635a6f07b545c9afef7feb6abcf3e25762ac2c51f2374147558a4cbe8121862fda2c0cd678223651962a1b0c68161efbc8e801d9e09a9b4506b890b2f80e503c25db5d04656bf8366e9c22ca79c4a381e84f919097fceb1103be8471206d531fe395173513125a37025a284f2a48d1f256140b60f75cb14f03dad3fcbb1f16385af9b644660b26ad244a2dd0d5debf3d7c194a02aff81f1fc189e73cfbf159e00070df3d77e10f2efe55ecdafc90ff062846579094f8924f5a8f97cb54386c4d9667fe60204b269df819cf359c820c34871c1a481fe14199bd451ef711fc0b69813540f629443bd558f063d87f2dd462cec5c217691914bf067ead2278fcb53c14a96d4a9249eedaa7391d78e86eed3c658a414c6ba4cc2299d3eb322259f862c3e1135c02a40c7e2ec9ad4b4b9f06ddd11285e2cd2bf98f3b67dd6b70c19b7eff31afb1435ae0e17ad76f5d827fbafc73e808cd792e80d032ca9b82598e14e17c4c8e4a920484621ff04866ca560822315e90c1676d1830f88a303e9e153265599d8cdfb13776e6f5e244841c23ac169f40a97884486d4c781179b44b8cff087bce840972cd73bfd2620efb00af604b9d6f7ad313c7452254da31b4dd715bfdba3810831119971129b5996362429b13b6174a0a145aa2541aa5f68082671b383ce365afc70517ffce41a9adc3a2c0016076660617bf621deebaf93a7475015db0ea830b4329e611b33822b43090892f225a9bf7f4a81724324c1d99323ef4a769a072d4865a1ce5cb1eef68255a9e0dfc247183c59c5ca1525b90c5c4b2f7839029d906035dc2425efa02aa574b2ee78217799e3c3130947bb783787ec7cf19564e32acef257386c4e06c2162e667d87e2a91369681fa5c48a0d02a066085eb8597bc03e7bee43507adae0e9b020fd72d375c87bf78cfbbb0fea6eb21acf189c5dccbf947bd848637b387f0a7bb14b205db89017bb19f06c9458831f4dd199b8fb2cd29b57cca122e3c38bc4a36a31719294a065294446abdb2533ea18859e1531044c894fe94b54ea15ba00c140a2b7964ad459e25efed1c088dcb58866130969e0b24d99b25146e8c7eccda8e642dd75eef4b21a359a89640a1144aedb16ff042ec45ffed9d78c6ba571fd47a3aec0a3c5c9beedb88ab2eff32aefeda5770df5d3f84732e168ee4934f717f1a0c2bbdf51979b2bf642f70c04794049e745c0dba85b0f880048d48b4b384b2ddb890b973acc820423f102bc69b932354a003f3924548feb3889b4e19a905c89649120bd8e589f012c355637a06254da7e31e25d21932e95e981394600f179513e004276450fc732864c11674611197beffa9652995c7be7d74a1c4e8e4245ef9071fc049679f77d0ebe8b02df0c1f6e54fdff1bbf8e6955f466f6e0ece3a1603508bb423065a533160044fb18d08ed8b4c3d71bee9e47fe706d87942f2fbe2a790de1220ce60921fd988fd6dc8a8a7ecc414d9102d1c80505cc8b07f205a32b479e5a948c3b84741b0418015219e3b0313d943d1914bfd33ef1d340777495fddf18918707129c82b709082bb204476630a68eeeb95041777684b08273ced3c5cfcbf3ef99826a91df1051e2ed334989dd98fdb6fb9095ff8f85fe1ce5b6fc2cccc2c23225c54b9ca37036a076f0181032f8f020faa656ad3aa7211f9301864b8c448104a7d6964eef16be362ce450f1e029569b995812910092c1adcbc86e235995e354f8af67461ff954806a603ef27b420c9041450991544a02bfb5922b39413c1d63918897a758e56028590280a0ff9762796e08d7ffe69ac3ef1e4435a334754810f5e755561d3bd1bf0e3071fc0fd1beec2a68d1bb175f3437878d326ccecdb0367eab68841449cc3b71994e8722db252243525488eb2a54d8222a9a52e0ad87190d239768db5c4688f44ec676538c15b24a80429865156642b1d31e8a1c87f6fc368903be7661487dc6f5c084f6e0a7db392a9b716d1cb5c64c5ec6701a5d2ff976e10ef54a6941731682551141d5cf0eb6fc17ffae5d7a233327ac86be4882ef09f76f57bf3d8bf772f7ef2f083d8fce0263cf2931f63c7d6cdd8be6533faf33398d9bf0f3f7ee0be4cfde3a3250c5ce6cc442dcfbddccc129c0b2938ed216e38838d7238695dde23e7cab8856848ea9206884f717d9538d4100b18076d921a535005f23e9951280e05936001844066ddec3fd6cf3a32f5dd40f4ab89c3a5962800281512a5058e7fca39f8b53ffa10a6972c3d6c6ae17159e0ffd2b5e1cef5f8cb77fda65f232b191392a5f49c71ef436ed13416d6789be1c65a34fd0675dda01fd4e8b5b779769c89ed25738891886074030e70b17f1f887759b0f00fa20599a13632ed59487a0a437c2ac956cb15247ff1a611e0805c09cd81bce1c1a5844cd4649968bd92429f1e4e6a8a7db9e2d6456b6e45ca0e96ad39016ffdd0e731b578c961f7b3d678025e577cfeb276c0122106524921a0387fb33b2a63c1880c3a0b374384ec229aceab72ebd0ef57989bed6166a6c2fed939cccd56fee6a86b543d83da187676a2d81ee4e32b0584c671a31bb07e890423d201480b3293e9716f9d38f74c558d3823d2cd67fdec222de0948096210bb33d89080274a170dcc9a7e1172fba04a79df32c8c4d4e1fb63febc3b6c089081bd6df80cd9b3662d7b6cdd8bf7b27080e4a1518199fc4e8f82426a61763f1f2a3b16cf51aac3af6f87fd5ff7bfb0faec37d77dfcee905e13186442e0a06922420a5f740f4ac00ce62777ee8124e327f5d320950c41e5a170a536589e9e949cfa063ab00c3ae52c658d4fd0673bd0ab3737d7f23ccf5d09baf303b57616eae076b9ddf01c4bc1c990e79992c3722a51503918452780f923cae85bd19030c2919661424e2102a6470f8e08f65cb3755281c7fda9938f7fc75f899f39e87556b4e38220eb3c3aec0b73c782fbef5779fc2fa6baf62557adb1890b2250ce58218a170fce94fc30b5ffd461cf7e433d019397052c0173ff18105ab69cab69d395e38e8bf129696de0ad8f109ec202d177b801d798124c8139f82ff8767da69749446b7dbc5f4a2097e3aa4d5b9623c6e7ebec2bebdb3d8be632f76eed88fd97e0fa67130c6c034d65ba511f99b27dc4459f32345bbf3a1b0eaa79c9b3eb062e776a63b3686254b5760f1512b70d25967e3acf39e8393ce3c0b45591e714febc3a607dfbd632bfefa9d6fc2ee2d0fc4616640efdb4af88a096e3627440928e54fd3e7bff28df885975d8491d1f1f8391ed9fc30fef04d2f872c64347f94114550ed7573281ce4e96159c86fc6c26b73d74506a5211355a7c4e7b43491d18433f4c44a025a6b48e5554f8594505aa2536814a546576be8c2abde7bfd1abbf7ce625fddc123b305b63df820f6ecdc0e678c5fee38eb0f79e72094880c4bad0a74c7ba58b4781996ae5a8d15c7aec5aa63d760d5716bf194a73f0b028f9feb9017b831069ffa93dfc27debbf0fc93f8058dcb9af77e61e9b6c2210fd0743fe3a8565891428cb2ed69cf634bce8356fc609a73c05bffdebebb06fe7564826ff84b573dc4032aa100949b99e1279ac5fce2769afb213dc97596244e1ee403ca00c0b1eff493517b362c84d2b89424b682da1a446a1250aad5068896ea7c058b783b1d11253131358fd82771cf0fbeb38de8558f623a4f4c6994f9079eb90b6289beeb9037ff3c76f4135bb87336a4426f60272c5822747b1c43cf495ccf0139209f616bc84b1104ea26f7bd870f3f7b0e196efe384337e0ebbb76e86d02a6e38bdca8de2e33d7252329e7752a353641646b54b06ed254253684f925ede3944ab60c77642228a92bd67a3808f2b14fc6f834bae9786f9a54af0302712b0cecb371b4bb0d6a0a9e6517416e2ced233d5f044bd0e59816fb8ed267cfc0f7f83613ad93699cc172bc89c4a192620e72210806005e744cc85f44a77c79e28be99beeff61bd025426534a83bc2168432f5d6f9638da563b1e8456efb99c9d4a82db44cab9834d485f33d9ef52e2d63c22fcadeb6ce5b4c48c7f6d20eb1b829c0900a990fba8071809ddf7dc0027fa25ff2d09cdc3fc4c7dff97a68a562e869b2490e45265aebea5cc9d3a237851e4666ba4289761e0f871e0102255960662f6c6da28f8acd5b1ca20549c1839ab57c7b1963aee38e31d7d1a48de242915b269ea6b4050d79ee2945995b304e6d73144c2ef9cf0e30c6a19edd3dace6c3a1c0f7eeda81cbde7171cc424f723091f197db74d5962a25789eb4d15fe4cbc73cff3dfd7f14530da494107333a05e0f65a9bd29bc7331a089c8c2f28de19383f39e3f2be4f8762674ce369718bc37d0561288dc4f30ff1794bccc39cfb96d0fcdef234e39b644a8f63d32ace643dda218d3e08397be0e4d3dcf0a7a17971ad1d34f50ab90437a59204fe5084a760e22cf354b360ad9fb932a37d9bdf5e621463a38f1d855989dab30dfafd0181b57f888dc676ff50649492b2a52c2847ff0041105c52751441e3351b310296a8f444e006b11c579482588188320e3d7154ef9e03d480454fbb70eabf95017f83f7ff50bd8b3fd275092e5532e200c0ec4dac5dccc26e5ac26161d05c1308901cf9254cfa1ef250cc4fa3997b5d6feaddddb77a223059ef2d453d058873dfbe731d7ef636eae466d1a0f43b24c4d38efcd1755e3e006392e8b72fbb5e42e1b72750001a28118f168e48998bf39d8c21073bb65862ca5d39cdb98d99dc36a3e94053eb36f0f2ebfec7dd04a7a09a3082d89f54e4fc245f022cf666afb7be4f1218edd9690e20273c14202ceb91777038286a04697d8b26d07683d70ced3cfc4d245e398ebd59899eba3aa6aecef55e8f76bf4aa1ac638dfafdb0467e6b180a26585c686f62d4c9f9291ce805839b658122d63a2d4a6b100c3a5cd8d737e0f600920dbc05807ade4b0aa0f45815ff1c9bf88933face73f08e1f502a2e5d49a590a8b8125cf82421f1c02a915fb17921e6870a843b25e86f4ebf61d3b76e1bbd7de8ad56b8fc1496b57e0a8e9a330d7afd0eb37e8553566e72af4ab0a73fd0615c77d58f2c50e991bd4136f3c5910402ec55c234560b7b983075845e42e56bc618acfb16c0f90077391a9003532acea4351e077dcf8cf9ca0e67b48c9743b17a03e997cb2a39be9017ef6143169a638b1936ae8bd5d4426306084ef6f22976a82dfcf925ba5303fb31f1b373e884776ecc56927aec689c72cc5a2c931548dc1cc6c0f73bd1a55dda05f35e8d70655d3a03116bdaa81312efa247a4c9bfdb545708ef25f9b0b651e0a3f9b864964eee203d657312d18ed087287e470e54c0d7486057ed00bfcbebbeec0de9ddb7c1fca9451174e25b64b9326ffb9ca3614280e60d516531fd2c91d7b564abfb7b92b9462a409adf7c39137056d2aecdb3f8f1befb8173bf7ecc7e94f5a8da3168d636ca48b5ebf42bf32e85735fa558d5e6530d7ab303162519906bd5e03eb2c88048cb52d772d8fa753843fa5f43767a0aa3a72ece1edc3561d29a8f6c32973a34dce5279a2f3809fc4f03a58057eff5db7c170f86b3aa745f2cc46222b85a0a6a4381703b667c80c7c82ba3c21252efcbd73117188851c6049eedf4920e5ff90832505e92c0adb47832eee7d681b76ed9dc5194f3e06c7af5e8a89b12e3a8545a75418e916186b2cc6473b98efd5a81a83a9317f9ad74c8aaa1ac3f023dbc0b1605e0adf3a05e57218b6c9399092700428222e7ae9874876106859c8515edc02b2182e7a0e7a811311eebfeb3634c6c5289b0539ef41df07ebb35c84e03f078212015266a07de6b0ead08af326972205c302278f3c4194940d78800be6860b01d93470b2847012bbf7cde2863beec7aebdb33869cd0a2c5d3c01a57c244ba50db456280b8dc618547583b228509b06a629d1af1b34c6a03116d6595ed6f8c58da7ab3a5856b5132723587210e48de6a5107ee3caad14914ad99403fb0001a0283bc38a3e14053eb37f3f1acb0804395f48acfc0eb12331ea4209144a41496f941f9424d225bbb07c3813593f0a84246386ceb84775c1231c0badcd5a21c2c207c82a9218317dcc17a3200754fd06773fb00573f3154e5abb022b8e9a8294129d52434a402b895ee54ddecbc2a0aa346add406b81aa96309660ac3fd195a318be9a2ce158bf196e50e153836df8bbdc1fd0a588407219276674f1b09a0f558b525515aac6d3371beb62b6622c30e77d392004a4012a6123a3aee06c1719a46514f0e0cccf2fcb7a0983acefb71d9ce5b733b530e54e55eccd40918fc2a7a7b310d6c0495eb4588707b7ec44d5785465083447c80000163f49444154e59269e852f9686a29315216688c89fe2c8595289486520d9adaa0b280940ac61a18e3d0c032c2435cdc5ce48ee0a4e7924b46817cbf8ecca32573c3e5efc0e8b2270dabf95015b82c4a34d6c0394263bc8f9e35846ea7c0e2a9124200c610667b359a3aacbe1d9482e7432b1e00350718b11393a7b4b67c8f138a1244bfc123c4390c7a033b2e7209ffff262aae83730263aec65e5702cae3ed5a2a6cdeb6177563618dc5518b26d129b5e7b984983e2550f0f6516b4257683f473402563a544db249364e30a69e419b31bdc2819c0449910dc7c9bc274504fa6dab9c5831ace64351e0524aac38668d5f4870fab03584934e98c29aa3270052b0d6a1e1beb3692c66e76aecd95f61e7ae79cc1b03259d6f5dac37e79442f8dfd9eb3adfe0e4fdb8e3c270364b7c08c2c2e05a45049200c93cec9583a3c8a280456d15afdf1da414d8b97b3feeb40e6b571b2c5b3c89916ee187464afdb160bf6ceb1cb49420ed5f67412ae1430631093886e03297c54141d240cc09da9ba1402f9e9a1cc325afb810679e7d1e5efff6f760c5d1c70c2bfb609ee0abd79ce80b9bc94bcb968ce2c96b16c1ba10bdadbd419474280a85458b0a1cb5781c271eb7088f6c9fc523db67d0ebfbd869a5140ae58df36391b752bb4442875d96a5197af656784f66e54080e6058d034138092b815161d0b35e416e7d261c9c0076ed99f524a7aac1d24513181ded24b551f85ac9252b65a1182962a31fb670300e594e8e68ddac22b7aa1874ee82cf1cd55ae2bb37fe0873fd0a375f770dd6bfe49958f7ba37e3a5175d82f1c9a9277c811f94bdeee9673d1d108ad97ac0ca65231984e73b690b09470a2424000d4b12901a2b974de06967acc4294f3a0a6323251a63d1af0dfab541af32a88d456d2c1ae3d034f0f60e8657d88e38fdcbc1180be7acdf3e32ba622d317b3065aea74db89f1594702860d158ebffbdb570c6c290c5aebd337878eb2e6cd9b907bbf7cea2df6f50550daadaa06e1a34355b4f381364eb11d28b11d7adc8bfac55097c16d15a6d26134c9e511c11befa8d1bfc8a9ebfa7577cf66378c38bcfc60ddffe069e80ae2087e0043f6e2d561cb3069beebd075e37295b090c2e50655b2b796f09158c33974c8f61f1d40866672bfc70c30ed4c6b240404029156d7c918d9cdef1c9c5d5bc3521c92dc1825a8b9443e314a44a06987e6095181384b986e014419197bb09e7e5673bf7cefa683de330353e8a4ea9139520f0d029bba19c8d3796a3d0b679e72bc909e34289cc5259b4359d2107477ad4e6735fbe0655d56758554627ae5eaf870ffcde9b70e2193f83f77ee28a43e60df88438c101e0dce7bc108e00632de6fb5e15ee3771214a43b2b164ea8d8300c03a768b921293131d3cfdaca371f4b231384ba80cf1dadca2b216b5b530d69fb88e7365c82511838fbbf3a73b11c15ac4153fa52935be6e470e8570a89a06756d51370e0d9fe0c6faacf6ddfb66b165fb3eecd83383bd33f3e8f51bccf71bf42a6f1234df6fd0ebd7e8d70d2a63d1588386a3f81a63bd529e73de89320a6ddce28b56c6a51402239d0e2efffa75d8b4e92751e963c9c50468304f7ce30f6fc36b7ffe14dcf4cf573f210bfca0898e776edf860b9f710a1c39ac5e318d538f9f46512810342c544a240804a66ca0ca3db5fde6cf404a60f7de79dc7dff6e54b563f34809a1bd1f48343d238044b8999814a562ca37b490280baf5e2fb484520a5a7a78522aaf13d552e0a1198bda39282d2111e2565898ac043424a626463035398a914e8952ab887604fe399cf746210758c7a28a6cb75b688d422b682dfddb4aa1501265a1e342a92c35acb5b8ea9f6ec2aedd7ba2493de2d726d94745247f724928a4c44b2efa4dbcecf56f85d64f1cbf27f5ee77bffbdd07e3138d8e8d63766e1e3fbce526f46a8b154b47e2cadeab53f8dc64c728020fa0ce6524a3b06657b08ed02d25562e1dc5eebd7ddfeb667233e7107bedc03bb19673dc193e04bb4749c818372dc863f222584ab0939516c0ee9e810bc2665e5839e256c459eebdf90962fcef556350370655bff19bcd9a6706eb4d802c93b4a450ecd69a2cd384f41edb524a482951160a0f3cf408befe8fd7a3d7eb27a95f3aafe24248464b378a43f4bdb7ff00ebafbb06e73effc227ccd6f3a0da46ecddb307cf7dea1a34b5c3d9672cc792e92e842a20a001216363e01fb580e36c99609f16fcb3837da51f4d2d1c11366eda83edbb7b30c671749d6cf1cba37e12c8ac21c041a53e2849ebe092aabc6d830e312a024e08dcb96d1e52836f88603b1c4c2da54f9f901245a9d0e9946c2e2f4042400f66b9f2565629895229e852432b85524968ad50e8025a0b944aa1d32db06fdf2c6e5dbf017b66662021506a9536b7b9dd32124151b33d44b06f0e4fb98989295cfafe4fe0a4337f7678823f9a57776404538b97e27bdffe268c05a6a7babe3f16d22bc3c9c1705f6c9c833101e9c83491202ef270fafba5d0f464893dfb6a548d85b1593a18320fc23c38954f3b29bd355a709852dc9ac82c6f2624216c99a93231b38b22e5304c5a1e1c1b6350d7064d6351370675ddf853bcf1277b631d5b6a22331fca6e18e9e9c34a49547583f5b76dc02db7df03672dc63b25c6463a9cf5aea09437b11732b95ba57b8822569edbba35758debbef915ac3df94cac3866cdf0047fb4af57bff879587ff30d78eac9cb303dd985d40537c62c7908d8b543e2589380500c8f498f01fb0813e7495a6451350e37ddbe0dbdbaf1276fe68a9a8646445b61a57cbc5d3839cb42a3d01e9d5052a2e02741685f36db71ecd9b5dd5b3bf0092ca339908c2697082d06f7c3befd60f72aa5fcc9ae049fd48a7b6f01a57c0f5e141a20c2235b77e0ee7b366162b4c4d2a9318c95052caf5b4d6429f2210097c86581e7c35e15e12923a447a5a400b410283b25def3a9af61f5da138705fe685e4484f3cf3e0d3b776cc6d34e5e0a552808d9c120f13b72b9071ebf5288687d2c4336252ce00c7a5583eb6fdf16c31d648cb60b096b2efeb9d0029dc23b4569a5fcdb4aa0500594169e26c0c5dde976f0677f7f23b66ddd829b6ffc3eaefcbbcf63d3fdf7700ba0a201a7966c69cf1bd7986b037fca0a3ea50ba5bcc7b692d0d20f90baf037c2839b3663d7ee7d00392c9f1ac3aac5135ee227589fe902dce8bd0fc95a6f04e458c6c7be8536f37694420e448a8b6813f7c1cbbf87e925cb8605fe685efd5e0fcf3dfb7468378335ab265014a5173a0c843a1d30272db60ffe94166ce123850591c3b65d3ddc79ef4e28a5b85f17d117dbeb24084af9feb6d4e19780d6be1f2fb484160a4afbc7bf560223232378ffe5374117457c1955d5c787feecbdf8ecfffe30c64747d01de9a2db2953ab902538847485e0deaa55404c34881c766cdb85d9997954750d22c2d468076b974f61f164979761144d831cb744c44b2c0b1eae9d431329c34994cc060171207194cc2aa49078f29967e19d1ffdd270d1f368f7e3dffec19d58f7dc67e0911d5bb074c928a42afdf49f2505c7c4605e76901090e48d71208cb731660dbd1004410e8b273b58b26814bbf6cefb0111e435a0008ce5e812283819b8230e161a8a7b7538800a07906271b3f2bdfa00bcd6e97431bd683166e7e6313fd7f3052325b42a50961245597ae8512abf8c52fe6d6f9aefd0d40d7abd3e9aba862e0a4821506a89554b26b066d914baa5ff7c941dbd0e0049071539ef02da11ac7020e987d9a847a57453e4be32d13683fbb5fb7f782baeb9f26ff19cfffcaa61813faa45deede29bd7adc72fbdf0397864f39d583aed00514028052509902a46d9c9488ff574d8c8a37696b79322e53ec262e5d2516cdf3d0f27ac77bbb2168082b596d3cd042f47786d6e1d48aa289490568074423d3a631307dc064e4c4dc33a3f4228de3f5a72a82b87a6b101f5f4723dd6554ace0d09f419a935a400964c74b176c534168d8f70b62c63e40bbc6082053213b49480907ee3ebe7161eca83da4978c835a8992cbc92c971229b1116577ee6a3f8f917bf1c523ebe7c0c0f0b8f81af7ce31a3ce3f9afc44fb6cfa0b135eaa641afb23e26a4b1de179b3926c6306261c32f87ba717e93d9585486501ba02c2426270a180b186b602dbca90f0063fda2c5588f8658170857e1340ff8b98de2e565ab0f6cb07fdc9ae3612dc130f72550731d3c4e6e1d6b2559552f65da9806ec7f72a4c493562dc6196b96626ab41bc95ae4d2ba9ff2c02bde1ec54623438ba412503ca8165aa1283de4596a89a290280a8542f96592d602b200b456d8b7732baefdc65786abfac7ea7aef9f7f186f7fef65d8ba730ee41a38e7d05842d518f49a06bdca78f8cd52f42731d6c138ef44654c587dfb026f0c61edca0908410c4112f34dfc62a5710ceb398223eb87b520c48896134913b6e6e4330ff8ba7feee9e7c21aebb793c1228e23fca2519113bcb544342d223808052c991cc1d14b26b07472947b77172151078a2e00f1777259a8d5a0742dcffef147b6a01c8a64c833a62ecb98b00c21f08f5ff86b4ffb1d16f86373ad7be9cbf1f12f5d8391a9d5689a0ae47caf6a8c3fa5e7ab06bd7e3ff23bfab541555954b56516a1436d1d1aeb505b42438455cbc6611a426d7c519b38a0794a800d44281ed8c8493ed529aa8e2080a79cfbbc03f7785ae317d7bdd40f7bd65b1a478fc5b0b08ae69a94382f00b4503ed20f401357f7b174f9d476e96d241b8c0003e65d1389c094744c604b5e866e81cf0ae5e6eb7000f66cdf0ae757b5c3027facae33ce3c135fbcea7a3c77dd6fa05f3580b3de60d2798296310e55ed6d1afa75c3d4d906556dd137064d6d9810e58515e3a30546463588fc80197b5486d58cf327b5b3fef33838ffbb4b51de42281c7ff2e93ff535ffd1fb3ee0974b8e608d83339cc7c3669e8e9f1671e1c4fdb073fe86ac1ac71f9f6a9068c0a2cdb9b6d17fe4b964426b97965a367e7edfca35d6a269fcf2ccb779fe5359e29bde116a53e3be3b6f1f16f8c1b82e7dc71fe3b35fbb19154660aa1eb3ecc001ab88de278e5b95aa36a82a835e6d98ff41e8379ec6ba6c5117c6b988c18795bd23dfd658eb072f672871b4011059108095c7feff0397561f732ccebf701d0cf9e58b61d51205de7938c9b93d72ac1b8d45e72c1ab698a0dcd705edc81647b9cb6cf676e0ddf04ce20f027ea2359efb628c43e33cdbb2e1202c5ff08e5997fe00b8eaf37f352cf08375ad58b90a57dfb0116ffaefef43bf32a8aa06d638e4660922c4010bc0312fbb6a2cfa8d416508c60245a9303ea27d913174111edbd6926f0f8c850d832125fd234038f3dce7ff8baff5939ffd22c62716f91b86fbe726787adb3003f00d8ab4de0fad55e48647d3d054e41830e4a48c4046d900ea18faf34c45be715d9a576ce3bc30c43265d7794298b10e640cc801f7de76d3b0c00ff6f5d2575d842bafdd80739fb70efb66663137df435d7bf6a0201173e1c3b0151ed9be97f5ef5bbe6424ce5ef922c43a0b6b82a55c422c42f3ad75890b5ef16bffe26b2ccb125ff8fb2bf849e051c980a284ded838ca0cf9fdcdd458624512d038ef3c40ed6e395a482797aecc8f90bc9e94407100cdbf366708c6f801dd73d0c309ce27bde57f470427fcfbf7eede312cf0837d4d4c4ce08fdfff31fcfdb7ee4039b11c33b373e8f52b34ac58505231e350a4e210c1e852a1dbd1989a2a5aef0b122fc3a79d176164a42e022e7ced9b31feaf0c3a3de719cfc4172fff1a2a63d8549f65734cfe0ac90d96614322f2a20967d137fee954732f1f163531e181d0f246779cee40c4ad55e8eb917a760a33850bc2113fb4fbe13a204afe747700c02d4e7f6e7658e087ea5abdfa187cf3dadbf1d1cf7d1db3f306b3b3f3a88de11e5d4608cd5982b3cc23177e05b472e9286f4311139d3cefdc9fae414114ace026164d61dd45fff5dff4fa7ee18217e0d67bee4563e1a148e78bba0938b975b00619f3d0f290e9fb61e261d2eb3f118b3460e2bed71611a509eeb9440977777ca33a1b34a9967bff947641bcda0f6c4d388fa458e7d09b1f16f821bd9452f8b973cec52d1b77e2f7dffb114c2e59895eaf0f29ac0f6c62af117fd2791b06125ef7b87c4917ce727d87f060f227970b3004804ed9c59f7ee62ae6b3fcdbaeb5c79f80db36dc87b5c79fe0c5ce7c825b4330dc8307e4c23942cdb4e08a8741e3026cc9856e921d4582015dfabb304f90f31b4a073f34060108096e995c7436f0b23d01c777b9cddaa0baea0f0bfcb078f152e0252f7b35befaad5bf19e0f7e0eab4f38dd3b9a5003720670160216829fef2480c9b1024a65ea83147519d189c9e929fcc5df7e13472d5ff5ef7e6dc71eb706d7adbf132f7ff5eb7c9f6bf8346fb845b0fe46b48ee2e6d63887cae645e8b59f36cb17b22eb52d9631763f4cdad87a18305c492ec185b165e21b887b6f1bb8f32e850b28a587057eb85dcf7efe0bf0375fba1a5fbbfe019c7fe1ab7d519185b596172ec96f4472368e0c1a4f24d7dba54b97e313fff07d1c7ddcf1ffe1d754688d8f7df2d3b8ea3bd7421485f72824f2c324051485505b426d1bf46b0fdf59e3602814335ac51d04d326f3380cb4852660da963cdd808bd8e3fd2eb64b713660195ff451e70145e9e27153e0874d94f7a37d596bb173c736dc78ddb5b8fc0b7f837b37dc81de7c1f7bf6f4505b03c5a28492b9e065a1f186b7fc0edef0b6df837e0c7ec0b3333378ddafbc1cdffdd63fb11842418120a440472b2c9ae862f1780753a31d8c740bcf2b1759ae7c76a5a8166a85523997298db89f76fcf4b2f9901a8757cbf9f41aa5165eba576afce597bf8bc5cb560e0bfc48bbb66edd8a6d5b3663cb961f63d3bd1bb167d70e1485c6c9a79e8eb39ff56cac5879f463fe1afee18aafe00fdf7e291e7e6813cae0e7a225a6464b2c19ef626abc8391a240a1654c59cb5d05bceb9c88f6cf8e1d661da5e276e016887fb496ed335aa10000acf1b2382d05cac2f3e2bbdd2e3ef39dbb8727f8f0fa8f3d5d7effd2b7e193977d0c82084afad9606ab483e9b12e464a8d4e2113412a134e04232020a13d819c65035262292e7dd270ca480bdb5587e22f94d77576b446a9155efc9a37e0b5bff97bc3021f5efff1abdfebe3bc739e8afb37de8b918ec4d46881e9b12ec63a053aa5625d69b0b6002b9ea2ef575c6a01324697dbd08e381b1dc38c7519018c6f3236052db4f7791c293574d9c5e7be7dc7e3ca52420fcbecd05ddd912e7e70c7ddb8e986ebf1d637bf1e3f79e03e68d144d185d641ddcf0643c28b36c4403217a149b2364a5e3081a065337e8b710e24bc38da018093508584901ae73ce7058f3bbf94e1097e185d5fbdfceff0898ffc2536de751bc64b8d6e47430905a94474a38d0c9908fdf0328b3d18832b98a36c230a07eb444c46960a28a482d60a1d0d8c7547b064d90afcf595dfff77e1fec3021f5effa6ebee3b7f843f78db25b8efeedba108d0da1bf62825a3296734fb11c97dc0814036596d10b1d8c35aef25231db4f01eeb85162894c468a78bd16e89f77eea723ce9d4a73ceebe97c3023f8c2f630c3ef8feff894f7fec4368aa79148a5b15f6440cb15c0ecefb12866d262192c62c9fe84a7ac99a96de93a5941aa5d6989e1ac35f5d7e0d561c7dece3f27b382cf023a2d02d1e7ef0015c75e515b8faaa2bf1a3db6f8535dedc48c9644ee8d8e9df094e58667b0dcda77f30395212181f1bc7ab7ee3cd78cdc56fc1e8f8f8e3f67b372cf023f0dafac823587febcdb8f5073761c3dd77e2fe8d1bf0f0439be0d8e41f42404bb0572217b956181f1dc339cf3a0fe7bff897f09c0b5e8cc9a9e96865f778f50f1f16f8e3e8b2d6e2e1871fc27d1befc1d6cd9b41e470d4d2e5386ad9329c72eae998989c7cc27d4f86053ebc1ed7971c7e0b86d7b0c087d7f01a16f8f01a5ec3021f5ec36b58e0c36b783d5ad7ff03fab9c092e4fcbc200000000049454e44ae426082');

COMMIT;
