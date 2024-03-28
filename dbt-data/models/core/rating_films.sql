{{
    config(
        materialized = 'table'
    )
}}

with join_title_basic_rating as (
    select
        tit_b.tconst,
        tit_b.titleType,
        tit_b.primaryTitle,
        tit_b.originalTitle,
        tit_r.averageRating,
        tit_b.isAdult,
        tit_b.isAdult_description,
        tit_b.startYear,
        tit_b.endYear,
        tit_b.runtimeMinutes,
        tit_b.genres,
        tit_r.numVotes
    from {{ ref('stg_title_basics') }} as tit_b
    join {{ ref('stg_title_ratings') }} as tit_r
    on tit_b.tconst = tit_r.tconst
),

calculate_title_basic_rating as (
SELECT 
    avg(averageRating) as avg_rating,
    avg(numVotes) as avg_num_votes,
    startYear,
    genres,
    ROW_NUMBER() OVER (PARTITION BY startYear ORDER BY avg(averageRating) DESC) AS rn
FROM join_title_basic_rating
group by startYear, genres
)

-- Жанры по годам, сортировка по среднему количеству голосов и рейтингу

select 
    avg_rating,
    avg_num_votes,
    startYear,
    genres
from calculate_title_basic_rating
--where avg_num_votes >= 10000
ORDER BY
    startYear DESC,
    avg_num_votes DESC

