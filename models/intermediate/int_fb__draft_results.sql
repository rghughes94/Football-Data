{{
  config(
    materialized = "view"
  )
}}


select 

    dra.sk_id,
    
    dra.draft_year,
    dra.draft_rnd,
    dra.draft_pick_num,
    dra.draft_team,
    dra.player_name,
    dra.draft_position,
    dra.college

from {{ ref('stg_fb__draft_results') }} dra 


