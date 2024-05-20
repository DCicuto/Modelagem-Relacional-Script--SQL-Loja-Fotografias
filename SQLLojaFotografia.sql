create table Cliente
(
codigo int NOT NULL, 
nome varchar (60) NOT NULL,
telefoneResidencial varchar (13),
telefoneComercial varchar (13), 
telefoneCelular varchar (14) NOT NULL,
CONSTRAINT PKCliente PRIMARY KEY (codigo),
)

INSERT INTO Cliente (codigo, nome, telefoneResidencial, telefoneComercial, telefoneCelular) 
VALUES
	(1, 'Bruno Gomes', NULL, NULL, '01516996159307'),
	(2, 'Daiane Cicuto', '0151633320000', NULL, '01516997028977');

create table PessoaFisica
( 
cpf char (11) NOT NULL,
rg varchar (10),
dataNascimento DATE,
sexocliente char (1),
codigoCliente int,
CONSTRAINT AKPessoaFisica UNIQUE (cpf),
CONSTRAINT FKClientePessoaFisica FOREIGN KEY (codigoCliente) REFERENCES Cliente(codigo)
)

INSERT INTO PessoaFisica (cpf, rg, dataNascimento, sexocliente, codigoCliente)
VALUES
	('12312312312', '12123123X', '1990-12-01', 'M', 1)

create table PessoaJuridica
(
  cnpj char (14) NOT NULL,
  inscricaoEstadual char (9),
  nomeRepresentanteLegal varchar (60) NOT NULL,
  codigoCliente int,
 CONSTRAINT AKPesosaJuridica UNIQUE (cnpj),
 CONSTRAINT FKClientePessoaJuridica FOREIGN KEY (codigoCliente) REFERENCES Cliente(codigo)
)

INSERT INTO PessoaJuridica (cnpj, inscricaoEstadual, nomeRepresentanteLegal, codigoCliente)
VALUES
	('12312312312312', '123456789', 'Daiane Cicuto', 2)

create table Produto
(codigo int NOT NULL,
descricao varchar (110) NOT NULL,
precoCusto int NOT NULL, 
precoVenda int NOT NULL,
quantidadeEstoque int NOT NULL,
quantidadeMinina int NOT NULL, 
tipo varchar (60) NOT NULL,
CONSTRAINT PKProduto PRIMARY KEY (codigo)
)

INSERT INTO Produto (codigo, descricao, precoCusto, precoVenda, quantidadeEstoque, quantidadeMinina, tipo)
VALUES
	(1, 'Foto 3x4', 1000, 1500, 50, 1, 'Fotografia'),
	(2, 'Foto 10x10', 3000, 5000, 100, 1, 'Impressao');

create table Funcionario
(
    codigoFuncionario int NOT NULL,
	nome varchar (60) NOT NULL, 
    telefone varchar (14) NOT NULL,
	telefoneParaContato varchar (14) NOT NULL, 
	funcao varchar (30) NOT NULL,
	departamento varchar (30) NOT NULL,
	CONSTRAINT PKFuncionario PRIMARY KEY (codigoFuncionario)
)

INSERT INTO Funcionario (codigoFuncionario, nome, telefone, telefoneParaContato, funcao, departamento) 
VALUES
	(3, 'Pedro de Pacas', '01516996159307', '01516996159307', 'Fotografo', 'Fotografia'),
	(4, 'Maria das Flores', '01516992920909', '01516992920909', 'Vendedora', 'Vendas');

create table Endereco 
(
    codigo int NOT NULL, 
    logradouro varchar (60) NOT NULL,
    numero int NOT NULL,
    bairro varchar (20) NOT NULL,
    cep char (8) NOT NULL,
    cidade varchar (60) NOT NULL,
    estado char (2) NOT NULL,
	codigoCliente int,
	codigoFuncionario int,
	CONSTRAINT PKEndereco PRIMARY KEY (codigo, numero, cep),
	CONSTRAINT FKClienteEndereco FOREIGN KEY (codigoCliente) REFERENCES Cliente(codigo),
	CONSTRAINT FKFuncionarioEndereco FOREIGN KEY (codigoFuncionario) REFERENCES Funcionario(codigoFuncionario)
)

INSERT INTO Endereco (codigo, logradouro, numero, bairro, cep, cidade, estado, codigoCliente, codigoFuncionario)
VALUES
	(1, 'Rua do bruno', 10, 'Centro', '13000000', 'Araraquara', 'SP', 1, NULL),
	(2, 'Rua da daiane', 10, 'Centro', '13000000', 'Araraquara', 'SP', 2, NULL),
	(3, 'Rua do pedro', 12, 'Centro', '13000000', 'Araraquara', 'SP', NULL, 3),
	(4, 'Rua da maria', 13, 'Centro', '13000000', 'Araraquara', 'SP', NULL, 4);

create table Venda
(numeroVenda int NOT NULL,
dataVenda DATE,
valorVenda int NOT NULL, --armazenei campo inteiro e será formatado no backend ou front
formaDePagamento varchar (15),
codigoCliente int,
codigoFuncionario int,
CONSTRAINT PKVenda PRIMARY KEY (numeroVenda),
CONSTRAINT FKClienteVenda FOREIGN KEY (codigoCliente) REFERENCES Cliente(codigo),
	CONSTRAINT FKFuncionarioVenda FOREIGN KEY (codigoFuncionario) REFERENCES Funcionario(codigoFuncionario)
)

INSERT INTO Venda (numeroVenda, dataVenda, valorVenda, formaDePagamento, codigoCLiente, codigoFuncionario)
VALUES
	(1, GETDATE(), 3000, 'Cartao credito', 1, 4),
	(2, GETDATE(), 50000, 'Dinheiro', 2, 4);

create table ItemVenda (
	codigoVenda int NOT NULL,
	codigoProduto int NOT NULL,
	CONSTRAINT FKItemVenda FOREIGN KEY (codigoVenda) REFERENCES Venda(numeroVenda),
	CONSTRAINT FKItemProduto FOREIGN Key (codigoProduto) REFERENCES Produto(codigo)
)

INSERT INTO ItemVenda (codigoVenda, codigoProduto)
VALUES 
	(1, 1),
	(2, 2);


SELECT * FROM Cliente;
SELECT * FROM PessoaFisica;
SELECT * FROM PessoaJuridica;
SELECT * FROM Funcionario;
SELECT * FROM Endereco;
SELECT * FROM Produto;
SELECT * FROM Venda;
SELECT * FROM ItemVenda;