CREATE TABLE arp_npl_pub.auswertung_grundnutzungszonen_pro_gemeinde (
        t_ili_tid uuid NOT NULL,
        gemeindename varchar(255),
        bfs_nr int4,
        typ_kt varchar(255),
        flaeche_zone_aggregiert numeric,
        CONSTRAINT auswertung_grundnutzungszonen_pro_gemeinde_pk PRIMARY KEY (t_ili_tid)
);

-- Grant privileges on schemas
GRANT USAGE
ON SCHEMA arp_npl_pub
TO public, gretl;

-- Grant read privileges
GRANT SELECT
ON ALL TABLES IN SCHEMA arp_npl_pub
TO public;

-- Grant write privileges
GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA arp_npl_pub
TO gretl;
GRANT USAGE
ON ALL SEQUENCES IN SCHEMA arp_npl_pub
TO gretl;

