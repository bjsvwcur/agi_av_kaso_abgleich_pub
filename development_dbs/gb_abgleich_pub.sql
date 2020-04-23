CREATE SCHEMA agi_av_gb_abgleich_pub;

COMMENT ON SCHEMA agi_av_gb_abgleich_pub IS 'Vergleich der AV-Daten mit den Grundbuchdaten. Fragen: AGI'
;

GRANT USAGE ON SCHEMA agi_av_kaso_abgleich_pub TO admin,gretl
;

CREATE TABLE agi_av_gb_abgleich_pub.differenzen (
	t_id int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	geometrie geometry NULL,
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
	fehlerart_text varchar NULL, -- Fehlerart als Text
	CONSTRAINT differenzen_pkey PRIMARY KEY (t_id)
);
COMMENT ON TABLE agi_av_gb_abgleich_pub.differenzen IS 'Differenzen zwischen den AV-Daten und den Grundbuchdaten';

-- Column comments

COMMENT ON COLUMN agi_av_gb_abgleich_pub.differenzen.fehlerart IS '1 : ''Liegenschaft mit falscher Art'', 
2 : ''Grundstücke mit Flächendifferenzen'', 
3 : ''Grundstück kommt nur in den AV-Daten vor'', 
4 : ''Grundstück kommt nur in den Grundbuch-Daten vor''';
COMMENT ON COLUMN agi_av_gb_abgleich_pub.differenzen.fehlerart_text IS 'Fehlerart als Text'
;
GRANT SELECT ON TABLE agi_av_gb_abgleich_pub.differenzen TO admin,gretl
;
GRANT SELECT,UPDATE,DELETE,INSERT ON TABLE agi_av_gb_abgleich_pub.differenzen TO admin,gretl
;

CREATE TABLE agi_av_gb_abgleich_pub.uebersicht_des_vergleichs (
	t_id int4 NOT NULL GENERATED BY DEFAULT AS IDENTITY,
	geometrie geometry NOT NULL,
	gem_bfs int4 NULL,
	"name" varchar NULL,
	anzahl_differenzen int8 NULL,
	CONSTRAINT uebersicht_des_vergleichs_pkey PRIMARY KEY (t_id)
);
COMMENT ON TABLE agi_av_gb_abgleich_pub.uebersicht_des_vergleichs IS 'Anzahl Differenzen zwischen den AV-Daten und den Grundbuchdaten pro Gemeinde'
;
GRANT SELECT ON TABLE agi_av_gb_abgleich_pub.uebersicht_des_vergleichs TO admin,gretl
;
GRANT SELECT,UPDATE,DELETE,INSERT ON TABLE agi_av_gb_abgleich_pub.uebersicht_des_vergleichs TO admin,gretl
;
