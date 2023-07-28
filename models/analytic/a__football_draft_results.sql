{{
  config(
    materialized = "table"
  )
}}

with cte_career_stats as ( 
-- This CTE aggregates career stats for each drafted player. Drafted players who never appear in weekly stats will have null values
select 
    player_name,
    position,
    min(season) as first_season_played,
    max(season) as last_season_played,
    count(distinct season) as seasons_played,
    count(distinct season||week_num) as games_played

from {{ ref('int_fb__weekly_stats_enhanced') }}
{{ dbt_utils.group_by(n=2) }}
) 

select 

    dra.draft_year,
    dra.draft_rnd,
    dra.draft_pick_num,
    dra.draft_team,
    dra.player_name,
    dra.draft_position,
    dra.college,

    first_season_played,
    last_season_played,
    seasons_played,
    games_played,
    first_season_played = draft_year as played_rookie_year

from {{ ref('int_fb__draft_results') }} dra 

left join cte_career_stats sta 
    on sta.player_name = dra.player_name 
    and sta.position = dra.draft_position