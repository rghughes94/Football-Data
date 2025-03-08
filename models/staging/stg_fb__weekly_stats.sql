{{
  config(
    materialized = "view"
  )
}}

with cte_union_all as (
select '2013' as season, * from {{ ref('s__season_stats_2013') }}
union all 
select '2014' as season, * from {{ ref('s__season_stats_2014') }}
union all 
select '2015' as season, * from {{ ref('s__season_stats_2015') }}
union all 
select '2016' as season, * from {{ ref('s__season_stats_2016') }}
union all 
select '2017' as season, * from {{ ref('s__season_stats_2017') }}
union all 
select '2018' as season, * from {{ ref('s__season_stats_2018') }}
union all 
select '2019' as season, * from {{ ref('s__season_stats_2019') }}
union all 
select '2020' as season, * from {{ ref('s__season_stats_2020') }}
union all 
select '2021' as season, * from {{ ref('s__season_stats_2021') }}
union all 
select '2022' as season, * from {{ ref('s__season_stats_2022') }}
union all 
select '2023' as season, * from {{ ref('s__season_stats_2023') }}
union all 
select '2024' as season, * from {{ ref('s__season_stats_2024') }}
)


select 
    
    {{ dbt_utils.generate_surrogate_key(['season', 'player_id','week_num' ]) }} as sk_id, 
    
    season,
    cast(player_id as string) as player_id,
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

from cte_union_all
