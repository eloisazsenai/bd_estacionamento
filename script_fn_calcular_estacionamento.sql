DELIMITER //

CREATE FUNCTION fn_calcular_estacionamento(
    p_data_entrada DATETIME,
    p_data_saida DATETIME,
    p_id_tarifa INT
) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE v_valor_tarifa DECIMAL(10,2);
    DECLARE v_criterio VARCHAR(50);
    DECLARE v_horas INT;
    DECLARE v_dias INT;
    DECLARE v_total DECIMAL(10,2);

    SELECT valor, cobranca INTO v_valor_tarifa, v_criterio 
    FROM tarifa WHERE idtarifa = p_id_tarifa;

    IF v_valor_tarifa IS NULL THEN
        RETURN 0.00;
    END IF;

    IF v_criterio = 'HORA' THEN
        SET v_horas = CEIL(TIMESTAMPDIFF(MINUTE, p_data_entrada, p_data_saida) / 60);
        IF v_horas <= 0 THEN SET v_horas = 1; END IF;
        SET v_total = v_horas * v_valor_tarifa;
        
    ELSEIF v_criterio = 'DIARIA' THEN
        SET v_dias = CEIL(TIMESTAMPDIFF(HOUR, p_data_entrada, p_data_saida) / 24);
        IF v_dias <= 0 THEN SET v_dias = 1; END IF;
        SET v_total = v_dias * v_valor_tarifa;
        
    ELSE
        SET v_total = v_valor_tarifa;
    END IF;

    RETURN v_total;
END //

DELIMITER ;

# testando
SELECT fn_calcular_estacionamento('2026-09-27 08:00:00', '2026-09-27 11:30:00', 1) AS valor_calculado;