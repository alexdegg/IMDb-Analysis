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
-- количество фильмов по годам по определенным жанрам (граф 2) и их % от общего числа (граф 1)

graph as (
select 
    count(tconst) as count_films,
    avg(averageRating) as avg_rat,
    avg(numVotes) as avg_num_votes,
    genres,
    startYear,
    ROW_NUMBER() OVER (PARTITION BY startYear ORDER BY count(tconst) DESC) AS rn
from join_title_basic_rating
group by startYear, genres
order by startYear DESC, count_films DESC
)

select *
from graph
where rn <= 5