BEGIN;
  ALTER TABLE builds ALTER COLUMN id TYPE int;
COMMIT;
