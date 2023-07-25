{{
  config(
    materialized = "table"
  )
}}

select
    
    sta.season,
    sta.player_name,
    sta.team,
    sta.position,
    
    sta.week_num,
    sta.opponent,

    sta.pass_yds,
    sta.pass_td,
    sta.pass_int,
    sta.rush_yds,
    sta.rush_td,
    sta.recs,
    sta.rec_yds,
    sta.rec_td,
    sta.def_sack,
    sta.def_int,
    sta.def_fumb_forced,
    sta.def_fumb_recovered,

    sta.fantasy_pts_std,
    sta.fantasy_pts_hppr,
    sta.fantasy_pts_ppr,

    dra.draft_year,
    dra.draft_rnd,
    dra.draft_pick_num,
    dra.draft_team,
    dra.draft_position,
    dra.college,

    (sta.season = dra.draft_year) as is_rookie_season,
    (sta.season - dra.draft_year + 1) as career_season_num,

    row_number() over (partition by sta.player_name, sta.position, sta.season order by sta.week_num asc ) as season_game_num
    -- Teams have 1 bye-week (rest week) each season. This counts the number of games each player has played in each season to avoid missing trend values

from {{ ref('int_fb__weekly_stats_enhanced') }} sta 

left join {{ ref('int_fb__draft_results') }} dra 
    on sta.player_name = dra.player_name 
    and sta.position = dra.draft_position
