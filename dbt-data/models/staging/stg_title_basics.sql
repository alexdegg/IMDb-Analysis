{{
    config(
        materialized='view'
    )
}}

with title_basics_data as 
(
  select 
    tconst,
    titleType,
    primaryTitle,
    originalTitle,
    CASE
        WHEN isAdult = '0' THEN FALSE
        WHEN isAdult = '1' THEN TRUE
        ELSE NULL
    END AS isAdult,
    cast(
        CASE
            WHEN startYear = '\\N' then NULL
            ELSE concat(startYear, '-01-01')
        END as date) as startYear,
    cast(
        CASE
            WHEN endYear = '\\N' then NULL
            ELSE concat(endYear, '-01-01')
        END as date) as endYear,
    {{ dbt.safe_cast("runtimeMinutes", api.Column.translate_type("integer")) }} as runtimeMinutes,
    genres
  from {{ source('staging','title_basics') }}
)

select 
    tconst,
    titleType,
    primaryTitle,
    originalTitle,
    isAdult,
    {{ isAdult_description('isAdult') }} as isAdult_description,
    startYear,
    endYear,
    -- extract(year from startYear) as startYear,
    -- extract(year from endYear) as endYear,
    runtimeMinutes,
    genres
from title_basics_data

