{{
  config(
    materialized = "table"
  )
}}


select 

    draft_year,
    draft_rnd,
    draft_pick_num,
    draft_team,
    player_name,
    draft_position,
    college 

from {{ ref('int_fb__draft_results') }}