{{
  config(
    materialized = "view"
  )
}}

select 

    draft_year,
    rnd as draft_rnd,
    pick as draft_pick_num,
    tm as draft_team,
    player as player_name,
    pos as draft_position,
    college 

from {{ source('football_data','draft_results') }}
