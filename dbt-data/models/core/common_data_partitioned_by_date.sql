{{ config(
    materialized='table',
    partition_by={
      "field": "startyear",
      "data_type": "date",
      "granularity": "year"
    },
    cluster_by = "genres"
)}}

with
    join_title_basic_rating as (
        select
            tit_b.tconst,
            tit_b.titletype,
            tit_b.primarytitle,
            tit_b.originaltitle,
            tit_r.averagerating,
            tit_b.isadult,
            tit_b.isadult_description,
            tit_b.startyear,
            tit_b.endyear,
            tit_b.runtimeminutes,
            tit_b.genres,
            tit_r.numvotes
        from {{ ref("stg_title_basics") }} as tit_b
        left join {{ ref("stg_title_ratings") }} as tit_r 
            on tit_b.tconst = tit_r.tconst
    ),

    join_title_crew_episode as (
        select
            tit_cr.tconst,
            tit_cr.directors,
            tit_cr.writers,
            tit_ep.parenttconst,
            tit_ep.seasonnumber,
            tit_ep.episodenumber
        from {{ ref("stg_title_crew") }} as tit_cr
        left join {{ ref("stg_title_episode") }} as tit_ep
            on tit_cr.tconst = tit_ep.tconst
    ),

    join_crew_episode_name_basics as(
        select
            tconst,
            parenttconst,
            seasonnumber,
            episodenumber,
            nam_bdir.nconst as director,
            nam_bdir.primaryName as director_name,
            nam_bdir.birthYear as director_birthYear,
            nam_bdir.deathYear as director_deathYear,
            nam_bdir.primaryProfession as director_primaryProfession,
            nam_bdir.knownForTitles as director_knownForTitles,
            nam_bwr.nconst as writer,
            nam_bwr.primaryName as writer_name,
            nam_bwr.birthYear as writer_birthYear,
            nam_bwr.deathYear as writer_deathYear,
            nam_bwr.primaryProfession as writer_primaryProfession,
            nam_bwr.knownForTitles as writer_knownForTitles
        from join_title_crew_episode as tit_crep
        left join {{ ref('stg_name_basics') }} as nam_bdir
            on nam_bdir.nconst = tit_crep.directors
        left join {{ ref('stg_name_basics') }} as nam_bwr
            on nam_bwr.nconst = tit_crep.writers
    ),

    common_data as (
        select 
            tit_br.tconst,
            titletype,
            primarytitle,
            originaltitle,
            averagerating,
            isadult,
            isadult_description,
            startyear,
            endyear,
            runtimeminutes,
            genres,
            numvotes,
            parenttconst,
            seasonnumber,
            episodenumber,
            director,
            director_name,
            director_birthYear,
            director_deathYear,
            director_primaryProfession,
            director_knownForTitles,
            writer,
            writer_name,
            writer_birthYear,
            writer_deathYear,
            writer_primaryProfession,
            writer_knownForTitles
        from join_title_basic_rating as tit_br
        left join join_crew_episode_name_basics as crep_nam_b
            on crep_nam_b.tconst = tit_br.tconst
    )

select *
from common_data

