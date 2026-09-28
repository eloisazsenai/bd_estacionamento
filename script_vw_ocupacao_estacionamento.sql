CREATE VIEW vw_ocupacao_estacionamento AS
SELECT
	v.idvaga AS id_vaga,
    v.codigo_vaga,
    v.tipo AS tipo_vaga,
    ve.placa,
    ve.marca,
    ve.modelo,
    p.nome_completo AS nome_cliente,
    m.data_hora_entrada
FROM vagas v
LEFT JOIN movimento_estacionamento m ON v.idvaga = m.idvaga AND m.status_permanencia = 'ATIVO'
LEFT JOIN veiculo ve on m.idveiculo = ve.idveiculo
LEFT JOIN pessoa p ON ve.idpessoa = p.idpessoa;

SELECT * FROM vw_ocupacao_estacionamento;