DO
$$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'school') THEN
      CREATE ROLE school WITH CREATEDB SUPERUSER LOGIN PASSWORD 'school';
   END IF;
END
$$;