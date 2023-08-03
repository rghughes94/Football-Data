{{
  config(
    materialized = "table"
  )
}}

with cte_career_stats as ( 
-- This cte aggregates career stats for each drafted player. Drafted players who never appear in weekly stats will have null values
select 
    player_id,
    player_name,
    is_dupe_name,
    dupe_draft_year,
    dupe_pick_num,
    min(season) as first_season_played,
    max(season) as last_season_played,
    count(distinct season) as seasons_played,
    count(distinct season||week_num) as games_played

from {{ ref('int_fb__weekly_stats_enhanced') }}
{{ dbt_utils.group_by(n=5) }}
) 

select 

    dra.sk_id,

    dra.draft_year,
    dra.draft_rnd,
    dra.draft_pick_num,
    dra.draft_team,
    dra.player_name,
    dra.draft_position,
    dra.college,

    sta.first_season_played,
    sta.last_season_played,
    sta.seasons_played,
    sta.games_played,
    sta.first_season_played = draft_year as played_rookie_year

from {{ ref('int_fb__draft_results') }} dra 

left join cte_career_stats sta 
    on case 
        when sta.is_dupe_name is true 
            then (sta.dupe_draft_year = dra.draft_year 
            and sta.dupe_pick_num = dra.draft_pick_num)
        else sta.player_name = dra.player_name
    end  