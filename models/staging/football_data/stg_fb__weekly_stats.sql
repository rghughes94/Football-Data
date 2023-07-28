{{
  config(
    materialized = "view"
  )
}}

select 
    
    {{ dbt_utils.generate_surrogate_key(['_table_suffix', 'player_id','week_num' ]) }} as sk_id, 
    
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
