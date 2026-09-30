DROP TRIGGER IF EXISTS tg_atualizar_vaga_entrada

DELIMITER //

CREATE TRIGGER tg_atualizar_vaga_entrada
AFTER INSERT ON movimento_estacionamento
FOR EACH ROW
BEGIN
    DECLARE v_status_atual VARCHAR(20);
    
    SELECT status INTO v_status_atual FROM vagas WHERE idvaga = NEW.idvaga;
    
    IF v_status_atual = 'OCUPADA' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Operação impedida: A vaga já se encontra ocupada.';
    ELSE
        UPDATE vagas 
        SET status = 'OCUPADA' 
        WHERE idvaga = NEW.idvaga;
    END IF;
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

DROP TRIGGER IF EXISTS tg_atualizar_estoque_lavagem
DELIMITER //

CREATE TRIGGER tg_atualizar_estoque_lavagem
AFTER INSERT ON ordem_lavagem_produto
FOR EACH ROW
BEGIN
    DECLARE v_qtd_disponivel INT;
    
    SELECT quantidade INTO v_qtd_disponivel 
    FROM estoque 
    WHERE idproduto = NEW.idproduto;
    
    IF NEW.quantidade_utilizada > v_qtd_disponivel THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Não existe estoque suficiente para realizar o serviço.';
    ELSE
        UPDATE estoque 
        SET quantidade = quantidade - NEW.quantidade_utilizada 
        WHERE idproduto = NEW.idproduto;
    END IF;
END //

DELIMITER ;

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


DELIMITER //

CREATE TRIGGER tg_criacao_automatica_estoque
AFTER INSERT ON produto
FOR EACH ROW
BEGIN
    INSERT INTO estoque (quantidade, idproduto) 
    VALUES (0, NEW.idproduto);
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER tg_entrada_produtos
AFTER INSERT ON entrada_produto
FOR EACH ROW
BEGIN
    DECLARE v_per_lucro DECIMAL(10,2);
    
    UPDATE estoque 
    SET quantidade = quantidade + NEW.quantidade 
    WHERE idproduto = NEW.produto_idproduto;
    
    SELECT per_lucro INTO v_per_lucro 
    FROM produto 
    WHERE idproduto = NEW.produto_idproduto;
    
    UPDATE produto 
    SET 
        custo = NEW.valor_unitario,
        valor_cobranca = NEW.valor_unitario + (NEW.valor_unitario * (v_per_lucro / 100))
    WHERE idproduto = NEW.produto_idproduto;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER tg_atualiza_status_lavagem
AFTER INSERT ON ordem_lavagem_produto
FOR EACH ROW
BEGIN
    UPDATE ordem_lavagem 
    SET status = 'EM_EXECUCAO' 
    WHERE idordem_lavagem = NEW.idordem_lavagem 
    AND status = 'AGUARDANDO';
END //

DELIMITER ;