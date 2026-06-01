with source as (
    select * from {{ source('public', 'base_geral') }}
),

renamed as (
    select
        -- identificação do pedido
        "waybillNo"                         as waybill_no,
        "country"                           as pais,
        "routeCode"                         as rota,
        "type"                              as tipo_pedido,

        -- datas do pedido
        "Order Create Time"                 as pedido_criado_em,
        "signTime"                          as entregue_em,
        "signTime-actual"                   as entregue_em_real,

        -- coleta (pickup)
        "expect PickTime"                   as coleta_prevista_em,
        "PickTime"                          as coletado_em,
        "timeOut(pickup)"                   as atraso_coleta,

        -- pds (ponto de saída)
        "code(pds)"                         as pds_codigo,
        "name(pds)"                         as pds_nome,
        "city(pds)"                         as pds_cidade,
        "cutoffTime(pds)"                   as pds_cutoff,
        "receiveTime(pds)"                  as pds_recebido_em,
        "departureTime(pds)"                as pds_saida_prevista,
        "departureTime-actual(pdc)"         as pds_saida_real,
        "timeOut(pds)"                      as pds_atraso_cutoff,
        "timeOut(pds-departure)"            as pds_atraso_saida,

        -- rdc (centro de distribuição regional)
        "code(rdc)"                         as rdc_codigo,
        "name(rdc)"                         as rdc_nome,
        "cut-off Time(rdc)"                 as rdc_cutoff,
        "receiveTime(rdc)"                  as rdc_recebido_em,
        "departureTime(rdc)"                as rdc_saida_prevista,
        "departureTime-actual(rdc)"         as rdc_saida_real,
        "timeOut(rdc-cut-off)"              as rdc_atraso_cutoff,
        "timeOut(rdc-departure)"            as rdc_atraso_saida,

        -- dc1
        "code(dc1)"                         as dc1_codigo,
        "name(dc1)"                         as dc1_nome,
        "cutoffTime(dc1)"                   as dc1_cutoff,
        "receiveTime(dc1)"                  as dc1_recebido_em,
        "departureTime(dc1)"                as dc1_saida_prevista,
        "timeOut(dc1-cut-off)"              as dc1_atraso_cutoff,
        "timeOut(dc1-departure)"            as dc1_atraso_saida,

        -- ddc (centro de distribuição de destino)
        "code(ddc)"                         as ddc_codigo,
        "name(ddc)"                         as ddc_nome,
        "cutoffTime(ddc)"                   as ddc_cutoff,
        "receiveTime(ddc)"                  as ddc_recebido_em,
        "timeOut(ddc-cut-off)"              as ddc_atraso_cutoff,
        "timeOut(ddc-arrive-car)"           as ddc_atraso_chegada,

        -- dds (última milha)
        "code(dds)"                         as dds_codigo,
        "name(dds)"                         as dds_nome,
        "city(dds)"                         as dds_cidade,
        "cutoffTime(dds)"                   as dds_cutoff,
        "arriveTime(dds)"                   as dds_chegada_em,
        "InboundTime(dds)"                  as dds_inbound_em,
        "outBoundTime(dds)"                 as dds_outbound_em,
        "cityAgeing(dds)"                   as dds_ageing,
        "timeOut(dds-cut-off)"              as dds_atraso_cutoff,
        "timeOut(dds-sign)"                 as dds_atraso_entrega,

        -- indicadores
        "change bill or not"                as houve_troca_romaneio

    from source
)

select * from renamed