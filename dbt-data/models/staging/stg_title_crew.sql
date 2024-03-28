{{
    config(
        materialized='view'
    )
}}

with title_crew_data as 
(
  select *
  from {{ source('staging','title_crew') }}
)

select 
    tconst,
    directors,
    writers
from title_crew_data