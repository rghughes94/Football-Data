{{
  config(
    materialized = "view"
  )
}}

select

    sta.sk_id,

    sta.player_id,
    sta.player_name,
    
    sta.position,
    sta.team,
    sta.season,
    sta.week_num,
    (sta.season||'-'||sta.week_num) as game_id,
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

    sta.fantasy_pts as fantasy_pts_std,
    -- Caculating alternate fantasy scoring systems that award a half or full point for each reception
    sta.fantasy_pts + (0.5 * sta.recs) as fantasy_pts_hppr,
    sta.fantasy_pts + sta.recs as fantasy_pts_ppr,

    -- Some players share names with more than one player who was drafted in the dataset
    -- Use a seed file to manually assign their unique draft year and pick num combination
    -- mark as 'dupe' for later joining

    dup.player_id is not null as is_dupe_name,
    cast(dup.draft_year as string) as dupe_draft_year,
    dup.pick_num as dupe_pick_num

from {{ ref('stg_fb__weekly_stats') }} sta

left join {{ ref('s_football_dupe_player_draft_pick_nums') }} dup 
    on dup.player_id = sta.player_id 
