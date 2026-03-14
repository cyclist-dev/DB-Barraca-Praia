CREATE TABLE cliente (
idCliente INT PRIMARY KEY AUTO_INCREMENT,
nomeCliente VARCHAR(50) NOT NULL,
cpf CHAR(11) NOT NULL UNIQUE
)



ALTER TABLE cliente
ADD COLUMN email VARCHAR(50) NOT NULL,
ADD COLUMN cidade VARCHAR(50) NOT NULL,
ADD COLUMN estado CHAR(2) NOT NULL,
ADD COLUMN cep CHAR(8),
ADD COLUMN tipoLogradouro VARCHAR (15) NOT NULL,
ADD COLUMN nomeLogradouro VARCHAR (50) NOT NULL,
ADD COLUMN numero VARCHAR (6) NOT NULL,
ADD COLUMN complemento VARCHAR(30)




CREATE TABLE funcionario(
idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
nomeFuncionario VARCHAR (50) NOT NULL,
cpf CHAR(11) NOT NULL UNIQUE,
celular CHAR(11) NOT NULL
)

INSERT INTO funcionario
(nomeFuncionario, cpf, celular)
VALUES
('Cebolinha', '13254874510', '13954477845'),
('Cascão', '51487962458', '11958475485'),
('Chico Bento', '65847912485', '21548795487')


CREATE TABLE equipamento(
idEquipamento INT PRIMARY KEY AUTO_INCREMENT,
nomeEquipamento VARCHAR(50) NOT NULL,
qtd INT NOT NULL,
valorHora DECIMAL(5,2) NOT NULL
)

INSERT INTO equipamento
(nomeEquipamento, qtd, valorHora)
VALUES
('Cadeira 2 posições', '50', '2,00'),
('Cadeiras 04 posições', '100', '3,50'),
('Guarda Sol P', '40 unidades', '2,00'),
('Guarda Sol G', '60 unidades', '3,00'),
('Mesinha', '30 unidades', '1,50')



CREATE TABLE aluguel(
idAluguel INT PRIMARY KEY AUTO_INCREMENT,
idCliente INT NOT NULL,
idFuncionario INT NOT NULL,
dataHoraRetirada DATETIME NOT NULL, 
dataHoraDevolucao DATETIME NOT NULL, 
valorAPagar DECIMAL(10,2),
valorPago DECIMAL(10,2) NOT NULL,
pago BIT NOT NULL,
formaPagamento VARCHAR(50),
qtVezes TINYINT,
CONSTRAINT fk_Aluguel_Cliente FOREIGN KEY (idCliente) REFERENCES cliente(idCliente),
CONSTRAINT fk_Aluguel_Funcionario FOREIGN KEY (idFuncionario) REFERENCES funcionario(idFuncionario),
CONSTRAINT ck_pago CHECK ("1" OR "0")
)



CREATE TABLE aluguelEquipamento(
idAluguelEquipamento INT PRIMARY KEY AUTO_INCREMENT,
idEquipamento INT NOT NULL,
idAluguel INT NOT NULL,
valorItem DECIMAL(10,2) NOT NULL,
valorUnitario DECIMAL(10,2) NOT NULL,
qtd INT NOT NULL,
CONSTRAINT fk_aluguelEquipamento_Equipamento FOREIGN KEY (idEquipamento) REFERENCES equipamento(idEquipamento),
CONSTRAINT fk_aluguelEquipamento_Aluguel FOREIGN KEY (idAluguel) REFERENCES aluguel(idAluguel)
)

SHOW TABLES;

SELECT
f.nomefuncionario,
f.cpf,
DATE(a.datahoraretirada) AS dataAluguel,
e.nomeEquipamento
FROM funcionario f
JOIN aluguel a
   ON f.idfuncionario = a.idfuncionario
JOIN  aluguelequipamento ae
   ON ae.idAluguel = ae.idaluguel
JOIN equipamento e
   ON ae.idEquipamento = e.idequipamento;


SELECT
c.nomeCliente,
c.cpf,
DATE(a.dataHoraRetirada) AS dataPraia,
f.nomeFuncionario
FROM cliente c
JOIN aluguel a
   ON c.idCliente = a.idCliente
JOIN funcionario f
   ON a.idFuncionario = f.idFuncionario
WHERE MONTH(a.dataHoraRetirada) = 12
AND YEAR(a.dataHoraRetirada) = 2024
ORDER BY a.dataHoraRetirada DESC;

SELECT
e.nomeEquipamento,
SUM(ae.qtd) AS totalAlugado
FROM equipamento e
LEFT JOIN aluguelEquipamento ae
   ON e.idEquipamento = ae.idEquipamento
GROUP BY e.nomeEquipamento
ORDER BY totalAlugado DESC;

SELECT
SUM(valorPago) AS arrecadacao
FROM aluguel
WHERE dataHoraRetirada BETWEEN '2024-12-25' AND '2024-12-31';


UPDATE equipamento
SET valorHora = valorHora * 1.10;

SELECT
formaPagamento,
COUNT(*) AS quantidade
FROM aluguel
GROUP BY formaPagamento
ORDER BY quantidade DESC;

SELECT
DATE(dataHoraRetirada) AS dia,
SUM(valorPago) AS faturamento
FROM aluguel
WHERE MONTH(dataHoraRetirada) = 12
AND YEAR(dataHoraRetirada) = 2024
GROUP BY dia;

DELETE FROM aluguelEquipamento
WHERE idAluguel = 1;

DELETE FROM aluguel
WHERE idAluguel = 1;


INSERT INTO cliente
(nomeCliente, email, cpf, cidade, estado, cep, tipoLogradouro, nomeLogradouro, numero, complemento)
VALUES
('Donald', 'donald@uol.com', '111.111.111-01', 'Santos', 'SP', '11000-000', 'Rua', 'das Flores', '100', 'Casa'), 
('Margarida', 'margarida@uol.com', '222.222.222-02', 'São Vicente', 'SP', '11300-000', 'Avenida', 'Brasil', '200', 'APT15'), 
('Patinhas', 'patinhas@uol.com', '333.333.333-03', 'Florianópolis', 'SC', '88000-000', 'Rua', 'Beira Mar', '300', 'Casa'), 
('Huguinho', 'huguinho@gmail.com', '444.444.444-04', 'Santos', 'SP', '11010-000', 'Rua', 'XV de Novembro', '150', 'APT23'), 
('Luizinho', 'luizinho@gmail.com', '555.555.555-05', 'Praia Grande', 'SP', '11700-000', 'Avenida', 'Presidente Kennedy', '250', 'APT81'), 
('Zezinho', 'zezinho@gmail.com', '666.666.666-06', 'São Vicente', 'SP', '11310-000', 'Rua', 'Itararé', '400', 'Casa'), 
('Pardal', 'pardal@uol.com', '777.777.777-07', 'Santos', 'SP', '11020-000', 'Rua', 'Afonso Pena', '500', 'Casa'), 
('Zé Carioca', 'zecarioca@email.com', '888.888.888-08', 'Rio de Janeiro', 'RJ', '20000-000', 'Rua', 'Copacabana', '600', 'Casa'), 
('Mickey', 'mickey@hotmail.com', '999.999.999-09', 'Recife', 'PE', '50000-000', 'Avenida', 'Boa Viagem', '700', 'APT53'), 
('Minie', 'minie@gmail.com', '123.123.123-10', 'Recife', 'PE', '50010-000', 'Rua', 'Aurora', '800', 'SALA12'), 
('Pateta', 'pateta@gmail.com', '234.234.234-11', NULL, NULL, NULL, NULL, NULL, NULL, NULL), 
('Branca de Neve', 'brancadeneve@hotmail.com', '345.345.345-12', 'São Joaquim', 'SC', '88600-000', 'Rua', 'das Maçãs', '900', 'APT173'), 
('Aladin', 'aladin@gmail.com', '456.456.456-13', 'Belém', 'PA', '66000-000', 'Travessa', 'dos Mercadores', '1000', 'APT35'), 
('Cinderela', 'cinderela@hotmail.com', '567.567.567-14', 'Goiania', 'GO', '74000-000', 'Rua', 'Encantada', '1100', 'Casa'), 
('Mulan', 'mulan@gmail.com', '678.678.678-15', 'Rio das Ostras', 'RJ', '28890-000', 'Rua', 'Dragão Vermelho', '1200', 'APT154'), 
('Moana', 'moana@gmail.com', '789.789.789-16', 'Parati', 'RJ', '23970-000', 'Rua', 'Mar Azul', '1300', 'APT13'), 
('Asnésio', 'asnesio@uol.com', '890.890.890-17', 'Belo Horizonte', 'MG', '30000-000', 'Avenida', 'Afonso Pena', '1400', 'FUNDOS'), 
('Maga Patalógica', 'magapatalogica@gmail.com', '901.901.901-18', 'Cubatão', 'SP', '11500-000', 'Rua', 'Misteriosa', '1500', 'LOJA2'), 
('Capitão Boeing', 'capitaoboeing@uol.com', '012.012.012-19', 'Manaus', 'AM', '69000-000', 'Avenida', 'Amazonas', '1600', 'Casa'), 
('Pão Duro Mac Money', 'paoduromacmoney@ig.com', '321.321.321-20', 'Osasco', 'SP', '06000-000', 'Rua', 'Economia', '1700', 'SALA3');





INSERT INTO aluguel (idCliente, idFuncionario, dataHoraRetirada, dataHoraDevolucao, valorPago, pago) 
VALUES (11, 1, '2024-11-08 10:00:00', '2024-11-08 19:00:00', 0.00, 0);
INSERT INTO aluguelEquipamento (idEquipamento, idAluguel, valorItem, valorUnitario, qtd) 
VALUES (1, LAST_INSERT_ID(), 2.00, 2.00, 1);
UPDATE equipamento SET qtd = qtd - 1 WHERE idEquipamento = 1;


INSERT INTO aluguel (idCliente, idFuncionario, dataHoraRetirada, dataHoraDevolucao), valorPago, pago)




