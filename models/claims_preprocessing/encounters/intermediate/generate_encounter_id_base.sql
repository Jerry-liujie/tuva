{{ config(
     enabled = var('claims_preprocessing_enabled',var('claims_enabled',var('tuva_marts_enabled',False))) | as_bool
   )
}}


with claim_start_end as (
  select
    claim_id
    , patient_data_source_id
    , min(start_date) as start_date
    , max(end_date) as end_date
  from {{ ref('encounters__stg_medical_claim') }}
  group by claim_id, patient_data_source_id
)

  select distinct
    enc.claim_id
    , enc.patient_data_source_id
    , c.start_date
    , c.end_date
    , enc.facility_id
    , enc.discharge_disposition_code
    , enc.service_category_2
    , enc.claim_type
  from {{ ref('encounters__stg_medical_claim') }} as enc
  inner join claim_start_end as c
    on enc.claim_id = c.claim_id
    and c.patient_data_source_id = enc.patient_data_source_id