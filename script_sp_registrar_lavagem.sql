DELIMITER //

DROP PROCEDURE IF EXISTS sp_registrar_lavagem //

CREATE PROCEDURE sp_registrar_lavagem(
    IN p_idcliente INT,
    IN p_idveiculo INT,
    IN p_idservico INT
)
BEGIN
    INSERT INTO ordem_lavagem (data_hora_entrada, status, idservico, idveiculo, idpessoa)
    VALUES (NOW(), 'AGUARDANDO', p_idservico, p_idveiculo, p_idcliente);
END //

DELIMITER ;