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
            ELSE concat(LPAD(birthYear, 4, '0'),'-01-01')
        END as date) as birthYear,
    cast(
        CASE
            WHEN deathYear = '\\N' then NULL
            ELSE concat(LPAD(deathYear, 4, '0'),'-01-01')
        END as date) as deathYear,
    CASE 
        WHEN primaryProfession = '\\N' then NULL
        ELSE primaryProfession
    END AS primaryProfession,
    knownForTitles
  from {{ source('staging','name_basics') }}
)

select 
    nconst,
    primaryName,
    birthYear,
    deathYear,
    primaryProfession,
    knownForTitles
from name_basics_data

