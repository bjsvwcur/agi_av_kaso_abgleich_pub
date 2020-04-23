# agi_av_kaso_abgleich_pub

Create Schema und Import Daten KASO Abgleich

Git clonen:
```
  git clone https://github.com/bjsvwcur/agi_av_kaso_abgleich_pub.git
```

Docker Container erstellen mit 2 PostgreSQL DBs edit und Pub.

Im Repo "agi_av_kaso_abgleich_pub" den Container erstellen: 

```
  docker-compose down # (this command is optional; it's just for cleaning up any already existing DB containers)
  docker-compose up
```

ENV Variablen auf die "Container"-DB setzen:
```
  export ORG_GRADLE_PROJECT_dbUriEdit="jdbc:postgresql://edit-db/edit"
  export ORG_GRADLE_PROJECT_dbUserEdit="gretl"
  export ORG_GRADLE_PROJECT_dbPwdEdit="gretl"
  export ORG_GRADLE_PROJECT_dbUriPub="jdbc:postgresql://pub-db/pub"
  export ORG_GRADLE_PROJECT_dbUserPub="gretl"
  export ORG_GRADLE_PROJECT_dbPwdPub="gretl"
  export ORG_GRADLE_PROJECT_dbUriKaso="ANGABEN SIEHE Ticket"
  export ORG_GRADLE_PROJECT_dbUserKaso="ANGABEN SIEHE Ticket"
  export ORG_GRADLE_PROJECT_dbPwdKaso="ANGABEN SIEHE Ticket"
  export ORG_GRADLE_PROJECT_dbUriCapitastra="ANGABEN SIEHE Ticket"
  export ORG_GRADLE_PROJECT_dbUserCapitastra="ANGABEN SIEHE Ticket"
  export ORG_GRADLE_PROJECT_dbPwdCapitastra="ANGABEN SIEHE Ticket"
```

Schemas erstellen in der edit-DB und Pub-DB:

Nachfolgende Befehle aus dem Verzeichnis /agi_av_kaso_abgleich_pub/development_dbs/ ausführen:

PW für admin = admin
```
 psql -h localhost -p 54321 -d edit -U admin -c "SET ROLE admin" --single-transaction -f kaso_abgleich.sql -f kaso_abgleich_grants.sql -f agi_dm01avso24.sql -f agi_dm01avso24_grants.sql -f gb_abgleich.sql -f gb_abgleich_grants.sql -f agi_hoheitsgrenzen_pub.sql
 psql -h localhost -p 54322 -d pub -U admin -c "SET ROLE admin" --single-transaction -f kaso_abgleich_pub.sql -f kaso_abgleich_pub_grants.sql -f gb_abgleich_pub.sql -f gb_abgleich_pub_grants.sql
```

Testdaten in edit-DB importieren:

Nachfolgende Befehle aus dem Verzeichnis /agi_av_kaso_abgleich_pub/development_dbs/ ausführen:

#### !! ACHTUNG !! Pfad in den 2 Files zu ili2pg-4.3.1 anpassen
```
./ili2pg_dataimportEdit_dm01avso24_2493.sh
./ili2pg_dataimportEdit_dm01avso24_2499.sh
```

#### Gretljob starten für Datenexport kaso und DB2DB edit-pub.

Nachfolgende Befehle aus dem Verzeichnis */agi_av_kaso_abgleich_pub/kaso_abgleich/* ausführen:
```
sudo -E ../start-gretl.sh --docker-image sogis/gretl-runtime:latest --docker-network agiavkasoabgleichpub_default --job-directory $PWD
```

#### Gretljob starten für Datenexport capitastra und DB2DB edit-pub.

Nachfolgende Befehle aus dem Verzeichnis */agi_av_kaso_abgleich_pub/gb_abgleich/* ausführen:
```
sudo -E ../start-gretl.sh --docker-image sogis/gretl-runtime:latest --docker-network agiavkasoabgleichpub_default --job-directory $PWD
```

