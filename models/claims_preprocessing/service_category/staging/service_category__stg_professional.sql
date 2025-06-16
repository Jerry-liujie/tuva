{{ config(
     enabled = var('claims_preprocessing_enabled',var('claims_enabled',var('tuva_marts_enabled',False))) | as_bool
   )
}}

select a.*
  , 'professional' as service_type
from {{ ref('service_category__stg_medical_claim') }} as a
where a.claim_type = 'professional'
