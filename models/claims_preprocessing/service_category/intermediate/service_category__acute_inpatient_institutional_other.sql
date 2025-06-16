{{ config(
     enabled = var('claims_preprocessing_enabled',var('claims_enabled',var('tuva_marts_enabled',False))) | as_bool
   )
}}


--simplified by setting lowest priority instead of explicitly doing all the joins
select distinct
  s.claim_id
  , 'inpatient' as service_category_1
, 'acute inpatient' as service_category_2
, 'acute inpatient - other' as service_category_3
, '{{ this.name }}' as source_model_name
, '{{ var('tuva_last_run') }}' as tuva_last_run
from {{ ref('service_category__stg_inpatient_institutional') }} as s
