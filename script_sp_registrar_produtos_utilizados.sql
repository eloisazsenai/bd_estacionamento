DELIMITER //

DROP PROCEDURE IF EXISTS sp_registrar_produtos_utilizados //

CREATE PROCEDURE sp_registrar_produtos_utilizados(
    IN p_idordem_lavagem INT,
    IN p_produtos_json JSON
)
BEGIN
    DECLARE v_i INT DEFAULT 0;
    DECLARE v_total INT;
    DECLARE v_idproduto INT;
    DECLARE v_quantidade INT;
    DECLARE v_valor DECIMAL(10,2);

    SET v_total = JSON_LENGTH(p_produtos_json);

    WHILE v_i < v_total DO
        SET v_idproduto = JSON_UNQUOTE(JSON_EXTRACT(p_produtos_json, CONCAT('$[', v_i, '].idproduto')));
        SET v_quantidade = JSON_UNQUOTE(JSON_EXTRACT(p_produtos_json, CONCAT('$[', v_i, '].quantidade')));
        SET v_valor = JSON_UNQUOTE(JSON_EXTRACT(p_produtos_json, CONCAT('$[', v_i, '].valor')));

        INSERT INTO ordem_lavagem_produto (idordem_lavagem, idproduto, quantidade_utilizada, valor_considerado)
        VALUES (p_idordem_lavagem, v_idproduto, v_quantidade, v_valor);

        SET v_i = v_i + 1;
    END WHILE;
END //

DELIMITER ;

# teste
CALL sp_registrar_produtos_utilizados(
    1, 
    '[{"idproduto": 1, "quantidade": 2, "valor": 15.00}]'
);