# agi_av_kaso_abgleich_pub

Create Schema und Import Daten KASO Abgleich

Git clonen:
```
  git clone https://github.com/bjsvwcur/agi_av_kaso_abgleich_pub.git
```

Docker Container erstellen mit 2 PostgreSQL DBs edit und Pub. Inkl. 

```
  docker-compose down # (this command is optional; it's just for cleaning up any already existing DB containers)
  docker-compose run --rm --user $UID -v $PWD/development_dbs:/home/gradle/project gretl "sleep 20 && cd /home/gradle && gretl -b project/build-dev.gradle createSchemaLandUsePlans createSchemaLandUsePlansPub"
```

ENV Variablen auf die "Container"-DB setzen:
```
  export ORG_GRADLE_PROJECT_dbUriEdit="jdbc:postgresql://edit-db/edit"
  export ORG_GRADLE_PROJECT_dbUserEdit="gretl"
  export ORG_GRADLE_PROJECT_dbPwdEdit="gretl"
  export ORG_GRADLE_PROJECT_dbUriPub="jdbc:postgresql://pub-db/pub"
  export ORG_GRADLE_PROJECT_dbUserPub="gretl"
  export ORG_GRADLE_PROJECT_dbPwdPub="gretl"
```

Testdaten in edit-DB importieren:
```
In das Verzeichnis /agi_av_kaso_abgleich_pub/development_dbs/ wechseln...
./ili2pg_dataimportEdit_dm01avso24_2493.sh
./ili2pg_dataimportEdit_dm01avso24_2499.sh

Daten in Schema av_grundbuch importieren:
Pro Tabelle in der Temp edit-DB die Daten importieren aus den Tabellen der sogis-DB, Schema av_grundbuch, Tabelle:
- grundbuch_art
- grundbuchamt
- grundbuchkreis_herkunft
- grundbuchkreise
```

Gretljob starten für Datenexport kaso und DB2DB edit-pub (aus Verzeichnis /kaso_abgleich/ starten):
```
sudo -E ../start-gretl.sh --docker-image sogis/gretl-runtime:latest --docker-network agiavkasoabgleichpub_default --job-directory /home/bjsvwcur/Meine-Repos/agi_av_kaso_abgleich_pub/kaso_abgleich/
```
