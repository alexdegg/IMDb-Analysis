{{
    config(
        materialized = 'table'
    )
}}

with graph as (
    select 
        count(tconst) as count_films,
        avg(averageRating) as avg_rat,
        avg(numVotes) as avg_num_votes,
        genres,
        startYear,
        ROW_NUMBER() OVER (PARTITION BY extract(year from startYear) ORDER BY count(tconst) DESC) AS rn
    from {{ ref('common_data_partitioned_by_date') }}
    group by startYear, genres
    order by startYear DESC, count_films DESC
)

select *
from graph
where rn <= 5