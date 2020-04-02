
CREATE SCHEMA agi_av_kaso_abgleich_import
;

GRANT USAGE ON SCHEMA agi_av_kaso_abgleich_import TO admin, gretl
;
COMMENT ON SCHEMA agi_av_kaso_abgleich_import
  IS 'exportierte Daten von KASO'
;

CREATE TABLE agi_av_kaso_abgleich_import.kaso_daten (
    t_id serial,
    geb_gdeid int4 NULL,
    geb_bfsnr int4 NULL,
    geb_gemname varchar NULL,
    gb_nr varchar NULL,
    gb_flaeche float4 NULL,
    gb_art int4 NULL,
    gb_gueltigbis varchar NULL,
    PRIMARY KEY (t_id)
) 
;
COMMENT ON TABLE agi_av_kaso_abgleich_import.kaso_daten IS 'Tabelle in welche die Daten von der KASO importiert werden' 
;
GRANT SELECT,UPDATE,DELETE,INSERT ON TABLE agi_av_kaso_abgleich_import.kaso_daten TO admin, gretl
;
GRANT USAGE ON SEQUENCE agi_av_kaso_abgleich_import.kaso_daten_t_id_seq TO admin, gretl
;

CREATE TABLE agi_av_kaso_abgleich_import.differenzen_staging (
    t_id serial NOT NULL,
    av_lieferdatum date NULL,
    av_gem_bfs int4 NULL,
    av_nbident varchar NULL,
    av_nummer text NULL,
    av_art int4 NULL,
    av_art_txt varchar NULL,
    av_flaeche float8 NULL,
    av_mutation_id varchar NULL,
    av_mut_beschreibung varchar NULL,
    kaso_gemeinde varchar NULL,
    kaso_bfs_nr int4 NULL,
    kaso_nbident varchar NULL,
    kaso_gb_nr varchar NULL,
    kaso_art int4 NULL,
    kaso_flaeche float4 NULL,
    flaechen_differenz float8 NULL,
    fehlerart int4 NULL,
    fehlerart_text varchar NULL,
    PRIMARY KEY (t_id)
)
;
COMMENT ON COLUMN agi_av_kaso_abgleich_import.differenzen_staging.fehlerart IS '1 : ''Liegenschaft mit falscher Art in KASO'', 
2 : ''Grundstücke mit Flächendifferenzen'', 
3 : ''Grundstück kommt nur in den AV-Daten vor'', 
4 : ''Grundstück kommt nur in den KASO-Daten vor''' ; 
;
GRANT SELECT,UPDATE,DELETE,INSERT ON TABLE agi_av_kaso_abgleich_import.differenzen_staging TO admin,gretl
;

COMMENT ON TABLE agi_av_kaso_abgleich_import.differenzen_staging
  IS 'Differenzen zwischen den AV-Daten und den Katasterschätzungsdaten'
;
SELECT AddGeometryColumn('agi_av_kaso_abgleich_import', 'differenzen_staging', 'geometrie', 2056, 'POLYGON', 2)
;
GRANT USAGE ON SEQUENCE agi_av_kaso_abgleich_import.differenzen_staging_t_id_seq TO admin,gretl
;


CREATE TABLE agi_av_kaso_abgleich_import.uebersicht_des_vergleichs_staging (
    t_id serial NOT NULL,
    gem_bfs int4 NULL,
    name varchar NULL,
    anzahl_differenzen int8 NULL,
    PRIMARY KEY (t_id)
)
;
GRANT SELECT,UPDATE,DELETE,INSERT ON TABLE agi_av_kaso_abgleich_import.uebersicht_des_vergleichs_staging TO admin,gretl
;

COMMENT ON TABLE agi_av_kaso_abgleich_import.uebersicht_des_vergleichs_staging
  IS 'Anzahl Differenzen zwischen den AV-Daten und den Katasterschätzungsdaten pro Gemeinde'
;
SELECT AddGeometryColumn('agi_av_kaso_abgleich_import', 'uebersicht_des_vergleichs_staging', 'geometrie', 2056, 'MULTIPOLYGON', 2)
;
GRANT USAGE ON SEQUENCE agi_av_kaso_abgleich_import.uebersicht_des_vergleichs_staging_t_id_seq TO admin,gretl
;

ALTER TABLE agi_av_kaso_abgleich_import.differenzen_staging ALTER COLUMN geometrie SET DATA TYPE geometry;
ALTER TABLE agi_av_kaso_abgleich_import.uebersicht_des_vergleichs_staging ALTER COLUMN geometrie SET DATA TYPE geometry;
