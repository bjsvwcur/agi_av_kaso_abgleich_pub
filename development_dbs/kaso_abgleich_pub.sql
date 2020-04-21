CREATE SCHEMA agi_av_kaso_abgleich_pub
;

GRANT USAGE ON SCHEMA agi_av_kaso_abgleich_pub TO admin,gretl
;

COMMENT ON SCHEMA agi_av_kaso_abgleich_pub IS 'Vergleich der AV-Daten mit den Katasterschätzungsdaten. Fragen: AGI'
;

CREATE TABLE agi_av_kaso_abgleich_pub.differenzen (
    t_id int4 NOT NULL,
    geometrie geometry(Polygon, 2056) NULL,
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
    PRIMARY KEY (t_id)
)
WITH (
    OIDS=FALSE
) 
;
COMMENT ON COLUMN agi_av_kaso_abgleich_pub.differenzen.fehlerart IS '1 : ''Liegenschaft mit falscher Art in KASO'', 
2 : ''Grundstücke mit Flächendifferenzen'', 
3 : ''Grundstück kommt nur in den AV-Daten vor'', 
4 : ''Grundstück kommt nur in den KASO-Daten vor''' ; 
;
GRANT SELECT ON TABLE agi_av_kaso_abgleich_pub.differenzen TO admin,gretl
;
GRANT SELECT,UPDATE,DELETE,INSERT ON TABLE agi_av_kaso_abgleich_pub.differenzen TO admin,gretl
;

COMMENT ON TABLE agi_av_kaso_abgleich_pub.differenzen
  IS 'Differenzen zwischen den AV-Daten und den Katasterschätzungsdaten'
;

CREATE TABLE agi_av_kaso_abgleich_pub.uebersicht_des_vergleichs (
    t_id serial NOT NULL,
    geometrie geometry(Polygon, 2056)NOT NULL,
    gem_bfs int4 NULL,
    name varchar NULL,
    anzahl_differenzen int8 NULL,
    PRIMARY KEY (t_id)
)
WITH (
    OIDS = FALSE
)
;
GRANT SELECT ON TABLE agi_av_kaso_abgleich_pub.uebersicht_des_vergleichs TO admin,gretl
;
GRANT SELECT,UPDATE,DELETE,INSERT ON TABLE agi_av_kaso_abgleich_pub.uebersicht_des_vergleichs TO admin,gretl
;

COMMENT ON TABLE agi_av_kaso_abgleich_pub.uebersicht_des_vergleichs
  IS 'Anzahl Differenzen zwischen den AV-Daten und den Katasterschätzungsdaten pro Gemeinde'
;
