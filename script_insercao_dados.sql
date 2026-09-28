INSERT INTO pessoa (nome_completo, cpf, telefone, email, tipo_pessoa) VALUES
('Eloísa dos Santos Zeferino', '12345678901', '79988887777', 'eloisa@email.com', 'CLIENTE'),
('Alisson Freire Batista', '98765432100', '79999998888', 'alisson@senai.br', 'CLIENTE'),
('Carlos Eduardo Souza', '45612378922', '79977776666', 'carlos@email.com', 'CLIENTE'),
('Mariana Costa', '11122233344', '79911112222', 'mariana@email.com', 'CLIENTE'),
('João Pedro Silva', '55566677788', '79955556666', 'joao.pedro@email.com', 'CLIENTE'),
('Ana Clara Mendes', '99988877766', '79944445555', 'ana.clara@email.com', 'CLIENTE'),
('Lucas Fernandes', '22233344455', '79922223333', 'lucas.f@email.com', 'CLIENTE'),
('Beatriz Rocha', '66677788899', '79966667777', 'beatriz.r@email.com', 'CLIENTE'),
('Rafael Gomes', '33344455566', '79933334444', 'rafael.g@email.com', 'CLIENTE'),
('Juliana Martins', '77788899900', '79977778888', 'juliana.m@email.com', 'CLIENTE'),
('Diego Almeida', '44455566677', '79944449999', 'diego.a@email.com', 'CLIENTE'),
('Camila Ribeiro', '88899900011', '79988881111', 'camila.r@email.com', 'CLIENTE'),
('Bruno Cardoso', '12121212121', '79912121212', 'bruno.c@email.com', 'CLIENTE'),
('Vanessa Lima', '34343434343', '79934343434', 'vanessa.l@email.com', 'CLIENTE'),
('Thiago Barros', '56565656565', '79956565656', 'thiago.b@email.com', 'CLIENTE');

INSERT INTO veiculo (marca, modelo, cor, placa, ano_fabricacao, idpessoa) VALUES
('Peugeot', '208', 'Branco', 'ABC1D23', 2024, 1),
('JAC', 'J3', 'Prata', 'JAC3E45', 2015, 1), 
('Honda', 'Civic', 'Preto', 'XYZ9W87', 2022, 2),
('Yamaha', 'MT-03', 'Azul', 'MOT0B12', 2025, 3),
('Toyota', 'Corolla', 'Prata', 'COR1A22', 2023, 4),
('Volkswagen', 'Polo', 'Branco', 'POL2B33', 2021, 5),
('Hyundai', 'HB20', 'Vermelho', 'HBA3C44', 2020, 6),
('Chevrolet', 'Onix', 'Preto', 'ONI4D55', 2024, 7),
('Jeep', 'Renegade', 'Verde', 'JEP5E66', 2022, 8),
('Fiat', 'Argo', 'Branco', 'ARG6F77', 2021, 9),
('Nissan', 'Kicks', 'Cinza', 'NIC7G88', 2023, 10),
('Ford', 'Ka', 'Preto', 'FOR8H99', 2019, 11),
('Honda', 'HR-V', 'Prata', 'HRV9I00', 2024, 12),
('Renault', 'Kwid', 'Laranja', 'KWI0J11', 2023, 13),
('BMW', 'X1', 'Branco', 'BMW1K22', 2025, 14);

INSERT INTO vagas (codigo_vaga, localizacao, tipo, status) VALUES
('A01', 'Térreo - Setor A', 'COMUM', 'DISPONIVEL'),
('A02', 'Térreo - Setor A', 'COMUM', 'DISPONIVEL'),
('A03', 'Térreo - Setor A', 'COMUM', 'DISPONIVEL'),
('A04', 'Térreo - Setor A', 'COMUM', 'DISPONIVEL'),
('A05', 'Térreo - Setor A', 'COMUM', 'DISPONIVEL'),
('B01', 'Térreo - Setor B', 'COMUM', 'DISPONIVEL'),
('B02', 'Térreo - Setor B', 'COMUM', 'DISPONIVEL'),
('B03', 'Térreo - Setor B', 'COMUM', 'DISPONIVEL'),
('M01', 'Térreo - Motos', 'MOTOCICLETA', 'DISPONIVEL'),
('M02', 'Térreo - Motos', 'MOTOCICLETA', 'DISPONIVEL'),
('M03', 'Térreo - Motos', 'MOTOCICLETA', 'DISPONIVEL'),
('V01', 'Cobertura - VIP', 'ESPECIAL', 'DISPONIVEL'),
('V02', 'Cobertura - VIP', 'ESPECIAL', 'DISPONIVEL'),
('P01', 'Subsolo - PCD', 'ESPECIAL', 'DISPONIVEL'),
('P02', 'Subsolo - PCD', 'ESPECIAL', 'DISPONIVEL');

INSERT INTO tarifa (descricao, valor, cobranca) VALUES
('Hora Carro Simples', 12.00, 'POR HORA'),
('Diária Carro Simples', 60.00, 'DIARIA'),
('Hora Moto', 6.00, 'POR HORA'),
('Diária Moto', 30.00, 'DIARIA'),
('Hora SUV/Caminhonete', 15.00, 'POR HORA'),
('Diária SUV/Caminhonete', 75.00, 'DIARIA'),
('Período 4h Carro', 40.00, 'PERIODO'),
('Período 4h Moto', 20.00, 'PERIODO'),
('Período 12h Carro', 50.00, 'PERIODO'),
('Período 12h Moto', 25.00, 'PERIODO'),
('Hora VIP Cobertura', 20.00, 'POR HORA'),
('Diária VIP Cobertura', 100.00, 'DIARIA'),
('Hora Especial PCD', 10.00, 'POR HORA'),
('Diária Especial PCD', 50.00, 'DIARIA'),
('Período Madrugada', 35.00, 'PERIODO');

-- Simular movimentos de estacionamento para testar a View de ocupação

INSERT INTO movimento_estacionamento 
(data_hora_entrada, data_hora_saida, status_permanencia, valor_pago, idveiculo, idvaga, idtarifa) 
VALUES
-- Veículos atualmente estacionados 
('2026-09-27 10:00:00', NULL, 'ATIVO', NULL, 1, 1, 1),   
('2026-09-27 11:30:00', NULL, 'ATIVO', NULL, 3, 3, 1),   
('2026-09-27 14:15:00', NULL, 'ATIVO', NULL, 4, 9, 3),   

-- Veículos que já saíram do estacionamento 
('2026-09-26 14:00:00', '2026-09-26 16:00:00', 'FINALIZADO', 24.00, 5, 2, 1), 
('2026-09-26 09:00:00', '2026-09-26 10:00:00', 'FINALIZADO', 12.00, 6, 4, 1), 
('2026-09-26 22:00:00', '2026-09-27 08:00:00', 'FINALIZADO', 35.00, 15, 12, 15); 
