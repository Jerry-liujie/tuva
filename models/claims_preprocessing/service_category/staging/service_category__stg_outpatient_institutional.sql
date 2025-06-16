{{ config(
     enabled = var('claims_preprocessing_enabled',var('claims_enabled',var('tuva_marts_enabled',False))) | as_bool
   )
}}

with inpatient as (
    select distinct
      i.claim_id
    from {{ ref('service_category__stg_inpatient_institutional') }} as i
)

select a.*
, 'outpatient' as service_type
from {{ ref('service_category__stg_medical_claim') }} as a
where a.claim_type = 'institutional'
and a.claim_id not in (
    select claim_id
    from inpatient
)

