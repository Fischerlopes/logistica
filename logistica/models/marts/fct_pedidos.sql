with stg as (
    select * from {{ ref('stg_base_geral') }}
)

select
    -- identificação
    waybill_no,
    pais,
    rota,
    tipo_pedido,

    -- datas principais
    pedido_criado_em::timestamp      as pedido_criado_em,
    coletado_em::timestamp           as coletado_em,
    entregue_em::timestamp           as entregue_em,
    entregue_em_real::timestamp      as entregue_em_real,

    -- centros pelos quais passou
    pds_codigo,
    pds_nome,
    pds_cidade,
    rdc_codigo,
    rdc_nome,
    dc1_codigo,
    dc1_nome,
    ddc_codigo,
    ddc_nome,
    dds_codigo,
    dds_nome,
    dds_cidade,

    -- indicadores de atraso (1 = atrasou, 0 = no prazo)
    case when atraso_coleta     = 'Y' then 1 else 0 end as atrasou_coleta,
    case when pds_atraso_saida  = 'Y' then 1 else 0 end as atrasou_pds,
    case when rdc_atraso_saida  = 'Y' then 1 else 0 end as atrasou_rdc,
    case when dc1_atraso_saida  = 'Y' then 1 else 0 end as atrasou_dc1,
    case when dds_atraso_entrega = 'Y' then 1 else 0 end as atrasou_entrega,

    -- ageing e troca de romaneio
    dds_ageing,
    houve_troca_romaneio

from stg