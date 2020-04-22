
CREATE SCHEMA agi_av_gb_abgleich_import;

COMMENT ON SCHEMA agi_av_gb_abgleich_import IS 'exportierte Daten vom Grundbuch (GB)'

GRANT USAGE ON SCHEMA agi_av_gb_abgleich_import TO admin, gretl
;

CREATE TABLE agi_av_gb_abgleich_import.differenzen_staging (
	t_id serial NOT NULL,
	av_gem_bfs int4 NULL,
	av_nbident varchar NULL,
	av_gemeinde varchar NULL,
	av_nummer text NULL,
	av_art int4 NULL,
	av_art_txt varchar NULL,
	av_flaeche float8 NULL,
	av_lieferdatum date NULL,
	av_mutation_id varchar NULL,
	av_mut_beschreibung varchar NULL,
	gb_gem_bfs int4 NULL,
	gb_kreis_nr int4 NULL,
	gb_gemeinde varchar NULL,
	gb_nummer varchar NULL,
	gb_art varchar NULL,
	gb_flaeche float4 NULL,
	gb_fuehrungsart varchar NULL,
	gb_nbident varchar NULL,
	flaechen_differenz float8 NULL,
	fehlerart int4 NULL, -- 1 : 'Liegenschaft mit falscher Art', ¶2 : 'Grundstücke mit Flächendifferenzen', ¶3 : 'Grundstück kommt nur in den AV-Daten vor', ¶4 : 'Grundstück kommt nur in den Grundbuch-Daten vor'
	geometrie geometry NULL,
	CONSTRAINT differenzen_staging_pkey PRIMARY KEY (t_id)
);
COMMENT ON TABLE agi_av_gb_abgleich_import.differenzen_staging IS 'Differenzen zwischen den AV-Daten und den Grundbuchdaten';

-- Column comments

COMMENT ON COLUMN agi_av_gb_abgleich_import.differenzen_staging.fehlerart IS '1 : ''Liegenschaft mit falscher Art'', 
2 : ''Grundstücke mit Flächendifferenzen'', 
3 : ''Grundstück kommt nur in den AV-Daten vor'', 
4 : ''Grundstück kommt nur in den Grundbuch-Daten vor'''
;

GRANT SELECT,UPDATE,DELETE,INSERT ON TABLE agi_av_gb_abgleich_import.differenzen_staging TO admin, gretl
;
GRANT USAGE ON SEQUENCE agi_av_gb_abgleich_import.differenzen_staging_t_id_seq TO admin, gretl
;

CREATE TABLE agi_av_gb_abgleich_import.gb_daten (
	bfs_nr int4 NULL,
	kreis_nr int4 NULL,
	gemeindename varchar(50) NULL,
	grundstueckart varchar(50) NULL,
	grundstueck_nr varchar(50) NULL,
	grundstueck_zusatz varchar(50) NULL,
	grundstueck_nr_3 varchar(50) NULL,
	fuehrungsart varchar(50) NULL,
	flaeche float4 NULL,
	egrid varchar NULL,
	t_id serial NOT NULL,
	CONSTRAINT gb_daten_pkey PRIMARY KEY (t_id)
);
COMMENT ON TABLE agi_av_gb_abgleich_import.gb_daten IS 'Tabelle in welche die Daten vom GB importiert werden'
;
GRANT SELECT,UPDATE,DELETE,INSERT ON TABLE agi_av_gb_abgleich_import.gb_daten TO admin,gretl
;
GRANT USAGE ON SEQUENCE agi_av_gb_abgleich_import.gb_daten_t_id_seq TO admin,gretl
;

CREATE TABLE agi_av_gb_abgleich_import.uebersicht_des_vergleichs_staging (
	t_id serial NOT NULL,
	gem_bfs int4 NULL,
	"name" varchar NULL,
	anzahl_differenzen int8 NULL,
	geometrie geometry NULL,
	CONSTRAINT enforce_dims_geometrie CHECK ((st_ndims(geometrie) = 2)),
	CONSTRAINT enforce_geotype_geometrie CHECK (((geometrytype(geometrie) = 'MULTIPOLYGON'::text) OR (geometrie IS NULL))),
	CONSTRAINT enforce_srid_geometrie CHECK ((st_srid(geometrie) = 2056)),
	CONSTRAINT uebersicht_des_vergleichs_staging_pkey PRIMARY KEY (t_id)
);
COMMENT ON TABLE agi_av_gb_abgleich_import.uebersicht_des_vergleichs_staging IS 'Anzahl Differenzen zwischen den AV-Daten und den Grundbuchdaten pro Gemeinde'
;

GRANT SELECT,UPDATE,DELETE,INSERT ON TABLE agi_av_gb_abgleich_import.uebersicht_des_vergleichs_staging TO admin,gretl
;
GRANT USAGE ON SEQUENCE agi_av_gb_abgleich_import.uebersicht_des_vergleichs_staging_t_id_seq TO admin,gretl
;

