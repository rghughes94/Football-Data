{{
  config(
    materialized = "view"
  )
}}

{{ dbt_utils.union_relations(

    relations=[ref('base_fb__weekly_stats_2022'), ref('base_fb__weekly_stats_2021')]

)}}