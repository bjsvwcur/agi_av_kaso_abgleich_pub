SELECT
    geometrie,
    av_lieferdatum,
    av_gem_bfs,
    av_nbident,
    av_nummer,
    av_art_txt,
    av_flaeche,
    av_mutation_id,
    av_mut_beschreibung,
--    kaso_gemeinde,
    kaso_bfs_nr,
--    kaso_nbident,
    kaso_gb_nr,
    kaso_art,
    kaso_flaeche, 
    flaechen_differenz, 
    fehlerart,
    fehlerart_text
FROM
    agi_av_kaso_abgleich_import.differenzen_staging
;