{{
  config(
    materialized = "view"
  )
}}

select 

    {{ dbt_utils.generate_surrogate_key(['draft_year', 'pick'])}} as sk_id,
    
    draft_year,
    rnd as draft_rnd,
    pick as draft_pick_num,
    tm as draft_team,
    player as player_name,
    pos as draft_position,
    college 

from {{ source('football_data','draft_results') }}
