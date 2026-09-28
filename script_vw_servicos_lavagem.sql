CREATE OR REPLACE VIEW vw_servicos_lavagem AS
SELECT
	ol.idordem_lavagem AS id_ordem,
    p.nome_completo AS nome_cliente,
    v.placa,
    v.marca,
    v.modelo,
    s.nome AS servico_solicitado,
    ol.data_hora_entrada,
    ol.status,
    ol.valor_cobrado AS valor_servico
FROM ordem_lavagem ol
JOIN veiculo v ON ol.idveiculo = v.idveiculo
JOIN pessoa p ON v.idpessoa = p.idpessoa
JOIN servico s ON ol.idservico = s.idservico;

SELECT * FROM vw_servicos_lavagem;