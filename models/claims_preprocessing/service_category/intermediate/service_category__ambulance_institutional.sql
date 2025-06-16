{{ config(
     enabled = var('claims_preprocessing_enabled', var('claims_enabled', var('tuva_marts_enabled', False))) | as_bool
   )
}}

select distinct
    med.claim_id
  , med.claim_line_number
  , med.claim_line_id
  , 'ancillary' as service_category_1
  , 'ambulance' as service_category_2
  , 'ambulance' as service_category_3
  , '{{ this.name }}' as source_model_name
  , '{{ var('tuva_last_run') }}' as tuva_last_run
from {{ ref('service_category__stg_outpatient_institutional') }} as med
where
  (med.hcpcs_code between 'A0425' and 'A0436')
  or med.revenue_center_code = '0540'
