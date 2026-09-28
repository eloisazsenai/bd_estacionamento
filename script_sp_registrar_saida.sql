DELIMITER //

CREATE PROCEDURE sp_registrar_saida(
    IN p_idveiculo INT
)
BEGIN
    UPDATE movimento_estacionamento
    SET 
        data_hora_saida = NOW(),
        valor_pago = fn_calcular_estacionamento(data_hora_entrada, NOW(), idtarifa),
        status_permanencia = 'FINALIZADO'
    WHERE 
        idveiculo = p_idveiculo 
        AND status_permanencia = 'ATIVO';
END //

DELIMITER ;

# testes
SELECT v.idvaga, v.codigo_vaga, v.status 
FROM vagas v
JOIN movimento_estacionamento m ON v.idvaga = m.idvaga
WHERE m.idveiculo = 1 AND m.status_permanencia = 'ATIVO';

CALL sp_registrar_saida(1);

SELECT idmovimento, data_hora_entrada, data_hora_saida, valor_pago, status_permanencia 
FROM movimento_estacionamento 
WHERE idveiculo = 1;

SELECT idvaga, codigo_vaga, status FROM vagas WHERE idvaga = 1;

# apagar
drop procedure sp_registrar_saida;
