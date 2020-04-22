-- Grant privileges on schemas
GRANT USAGE
ON SCHEMA agi_av_gb_abgleich_import
TO public, gretl;

-- Grant read privileges
GRANT SELECT
ON ALL TABLES IN SCHEMA agi_av_gb_abgleich_import
TO public;

-- Grant write privileges
GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA agi_av_gb_abgleich_import
TO gretl;
GRANT USAGE
ON ALL SEQUENCES IN SCHEMA agi_av_gb_abgleich_import
TO gretl;
