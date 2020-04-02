CREATE SCHEMA av_grundbuch;

COMMENT ON SCHEMA av_grundbuch IS 'Schema fuer das Verwalten von Information zum Grundbuch. Z.B. Grundbuchkreise.'
;
CREATE TABLE av_grundbuch.grundbuch_art (
	ogc_fid serial NOT NULL,
	art varchar NOT NULL,
	art_txt varchar NULL

);

-- Permissions

ALTER TABLE av_grundbuch.grundbuch_art OWNER TO admin;
GRANT ALL ON TABLE av_grundbuch.grundbuch_art TO admin;
GRANT SELECT ON TABLE av_grundbuch.grundbuch_art TO public;

CREATE TABLE av_grundbuch.grundbuchamt (
	ogc_fid int4 NOT NULL,
	amtschreiberei varchar NULL,
	amt varchar NULL,
	strasse varchar NULL,
	hausnummer varchar NULL,
	plz int4 NULL,
	ortschaft varchar NULL,
	telefon varchar NULL,
	web varchar NULL,
	email varchar NULL,
	uid varchar NULL
);

-- Permissions

ALTER TABLE av_grundbuch.grundbuchamt OWNER TO admin;
GRANT ALL ON TABLE av_grundbuch.grundbuchamt TO admin;
GRANT SELECT ON TABLE av_grundbuch.grundbuchamt TO public;

CREATE TABLE av_grundbuch.grundbuchkreis_herkunft (
	ogc_fid serial NOT NULL,
	art varchar NOT NULL,
	art_txt varchar NULL
);


-- Permissions

ALTER TABLE av_grundbuch.grundbuchkreis_herkunft OWNER TO admin;
GRANT ALL ON TABLE av_grundbuch.grundbuchkreis_herkunft TO admin;
GRANT SELECT ON TABLE av_grundbuch.grundbuchkreis_herkunft TO public;

CREATE TABLE av_grundbuch.grundbuchkreise (
	ogc_fid serial NOT NULL, -- OGC Feature ID
	grundbuch varchar NULL,
	gemeinde varchar NULL,
	gem_bfs int4 NULL,
	gb_art varchar NULL, -- Art des Grundbuches:¶0: unbekannt¶1: kantonal¶2: eidgenössisch
	gb_kreis_herkunft varchar NULL,
	nbident varchar NULL,
	bemerkungen varchar NULL,
	wkb_geometry geometry NULL, -- OGC WKB Geometrie
	gb_gemnr int4 NULL,
	grundbuchamt_id int4 NULL,
	kreis_nr int4 NULL
);

-- Column comments

COMMENT ON COLUMN av_grundbuch.grundbuchkreise.ogc_fid IS 'OGC Feature ID';
COMMENT ON COLUMN av_grundbuch.grundbuchkreise.gb_art IS 'Art des Grundbuches:
0: unbekannt
1: kantonal
2: eidgenössisch';
COMMENT ON COLUMN av_grundbuch.grundbuchkreise.wkb_geometry IS 'OGC WKB Geometrie';
COMMENT ON COLUMN av_grundbuch.grundbuchkreise.kreis_nr IS 'Nummer für fusionierte Gemeinden';


-- Permissions

ALTER TABLE av_grundbuch.grundbuchkreise OWNER TO admin;
GRANT ALL ON TABLE av_grundbuch.grundbuchkreise TO admin;
GRANT SELECT ON TABLE av_grundbuch.grundbuchkreise TO public;


