-- Grant privileges on schemas
GRANT USAGE
ON SCHEMA av_grundbuch
TO public, gretl;

-- Grant read privileges
GRANT SELECT
ON ALL TABLES IN SCHEMA av_grundbuch
TO public;

-- Grant write privileges
GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA av_grundbuch
TO gretl;
GRANT USAGE
ON ALL SEQUENCES IN SCHEMA av_grundbuch
TO gretl;
