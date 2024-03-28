{{
    config(
        materialized='view'
    )
}}

with name_basics_data as 
(
  select 
    nconst,
    primaryName,
    cast(
        CASE
            WHEN birthYear = '\\N' then NULL
            ELSE concat(birthYear,'-01-01')
        END as date) as birthYear,
    cast(
        CASE
            WHEN deathYear = '\\N' then NULL
            ELSE concat(deathYear,'-01-01')
        END as date) as deathYear,
    CASE 
        WHEN primaryProfession = '\\N' then NULL
        ELSE primaryProfession
    END AS primaryProfession,
    knownForTitles
  from {{ source('staging','name_basics') }}
  where cast(CASE
                WHEN birthYear = '\\N' then NULL
                ELSE birthYear
            END as integer) > 1000
    and cast(CASE
                WHEN deathYear = '\\N' then NULL
                ELSE deathYear
            END as integer) > 1000
)

select 
    nconst,
    primaryName,
    birthYear,
    deathYear,
    primaryProfession,
    knownForTitles
from name_basics_data

