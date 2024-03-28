{{
    config(
        materialized='view'
    )
}}

with title_ratings_data as 
(
  select *
  from {{ source('staging','title_ratings') }}
)

select 
    tconst,
    averageRating,
    numVotes
from title_ratings_data