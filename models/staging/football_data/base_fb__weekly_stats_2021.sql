{{
  config(
    materialized = "view"
  )
}}

select 
    _table_suffix as season,
    
    player_id,
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
    fantasy_pts

from {{ source('football_data','weekly_stats') }}
where _table_suffix = '2021'
