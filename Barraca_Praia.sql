
CREATE TABLE cliente (
idCliente INT PRIMARY KEY AUTO_INCREMENT,
nomeCliente VARCHAR(50) NOT NULL,
cpf CHAR(11) NOT NULL UNIQUE
)

CREATE TABLE funcionario(
idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
nomeFuncionario VARCHAR (50) NOT NULL,
cpf CHAR(11) NOT NULL UNIQUE,
celular CHAR(11) NOT NULL
)

CREATE TABLE equipamento(
idEquipamento INT PRIMARY KEY AUTO_INCREMENT,
nomeEquipamento VARCHAR(50) NOT NULL,
qtd INT NOT NULL,
valorHora DECIMAL(5,2) NOT NULL
)

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




