DELIMITER //

CREATE TRIGGER tg_atualizar_vaga_entrada
AFTER INSERT ON movimento_estacionamento
FOR EACH ROW
BEGIN
    UPDATE vagas 
    SET status = 'OCUPADA' 
    WHERE idvaga = NEW.idvaga;
END //

DELIMITER ;

# testando
SELECT idvaga, codigo_vaga, status FROM vagas WHERE idvaga = 5;

CALL sp_registrar_entrada(2, 5, 1);

SELECT idvaga, codigo_vaga, status FROM vagas WHERE idvaga = 5;


DELIMITER //

CREATE TRIGGER tg_atualizar_vaga_saida
AFTER UPDATE ON movimento_estacionamento
FOR EACH ROW
BEGIN
    IF NEW.status_permanencia <> OLD.status_permanencia AND NEW.status_permanencia = 'FINALIZADO' THEN
        UPDATE vagas 
        SET status = 'DISPONÍVEL' 
        WHERE idvaga = NEW.idvaga;
    END IF;
END //

DELIMITER ;

# testando
UPDATE movimento_estacionamento 
SET status_permanencia = 'FINALIZADO', data_hora_saida = NOW() 
WHERE idveiculo = 2 AND idvaga = 5 AND status_permanencia = 'ATIVO';

SELECT idvaga, codigo_vaga, status FROM vagas WHERE idvaga = 5;



# testando

INSERT INTO servico (idservico, nome, descricao, duracao, valor) 
VALUES (1, 'Lavagem Completa', 'lavagem geral', 30, 50.00);

INSERT INTO veiculo (idveiculo, modelo, marca, cor, placa, ano_fabricacao, idpessoa) 
VALUES (16, 'uno', 'fiat', 'preto', 'ABC-1234', '2010', 15);

INSERT INTO produto (idproduto, nome, descricao, un_medida, custo, per_lucro) 
VALUES (1, 'Champô Automóvel', 'Produto de limpeza externa', 'Litro', 5.00, 200.00);

INSERT INTO estoque (idestoque, quantidade, idproduto) 
VALUES (1, 50, 1);

INSERT INTO ordem_lavagem (data_hora_entrada, status, idservico, idveiculo) 
VALUES (NOW(), 'EM_ANDAMENTO', 1, 16); 

SELECT idestoque, idproduto, quantidade AS estoque_antes 
FROM estoque 
WHERE idproduto = 1;

INSERT INTO ordem_lavagem_produto (idordem_lavagem, idproduto, valor_considerado, quantidade_utilizada) 
VALUES (1, 1, 15.00, 2);

SELECT idestoque, idproduto, quantidade AS estoque_depois 
FROM estoque 
WHERE idproduto = 1;