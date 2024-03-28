{{
    config(
        materialized='view'
    )
}}

with title_episode_data as 
(
  select 
    tconst,
    parentTconst,
    cast(
        CASE
            WHEN seasonNumber = '\\N' then NULL
            ELSE seasonNumber
        END as integer) as seasonNumber,
    cast(
        CASE
            WHEN episodeNumber = '\\N' then NULL
            ELSE episodeNumber
        END as integer) as episodeNumber
  from {{ source('staging','title_episode') }}
)

select 
    tconst,
    parentTconst,
    seasonNumber,
    episodeNumber
from title_episode_data