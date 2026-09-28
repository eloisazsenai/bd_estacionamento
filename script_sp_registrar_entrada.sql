DELIMITER //

CREATE PROCEDURE sp_registrar_entrada(
    IN p_id_veiculo INT,
    IN p_id_vaga INT,
    IN p_id_tarifa INT
)
BEGIN
    INSERT INTO movimento_estacionamento (
        data_hora_entrada,
        status_permanencia,
        idveiculo,
        idvaga,
        idtarifa
    ) VALUES (
        NOW(), 
        'ATIVO', 
        p_id_veiculo, 
        p_id_vaga,
        p_id_tarifa
    );
END //

DELIMITER ;

# testando
CALL sp_registrar_entrada(2, 5, 1);