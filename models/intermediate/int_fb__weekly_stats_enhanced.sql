{{
  config(
    materialized = "ephemeral"
  )
}}

select
    
    season,
    player_name,
    team,
    position,
    
    week_num,
    opponent,

    pass_yds,
    pass_td,
    pass_int,
    rush_yds,
    rush_td,
    recs,
    rec_yds,
    rec_td,
    def_sack,
    def_int,
    def_fumb_forced,
    def_fumb_recovered,

    fantasy_pts as fantasy_pts_std,
    -- Caculating alternate fantasy scoring systems that award a half or full point for each reception
    fantasy_pts + (0.5 * recs) as fantasy_pts_hppr,
    fantasy_pts + recs as fantasy_pts_ppr

from {{ ref('stg_fb__weekly_stats') }}