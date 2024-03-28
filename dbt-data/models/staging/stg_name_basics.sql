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
            ELSE concat(birthYear,'01-01')
        END as date) as birthYear,
    cast(
        CASE
            WHEN deathYear = '\\N' then NULL
            ELSE concat(deathYear,'01-01')
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
    --extract(year from birthYear) as birthYear,
    --extract(year from deathYear) as deathYear,
    primaryProfession,
    knownForTitles
from name_basics_data

