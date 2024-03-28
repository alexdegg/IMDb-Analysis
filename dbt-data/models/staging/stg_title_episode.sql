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
    cast(seasonNumber as integer) as seasonNumber,
    cast(episodeNumber as integer) as episodeNumber
  from {{ source('staging','title_episode') }}
)

select 
    tconst,
    parentTconst,
    seasonNumber,
    episodeNumber
from title_episode_data