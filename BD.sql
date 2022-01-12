CREATE TABLE Pessoa (
	cpf varchar(11),
	nome varchar(30),
	idade integer,
	telefone varchar(11),
	PRIMARY KEY (cpf)
);
--CPF foi escolhido como chave primária por ser único a cada pessoa

CREATE TABLE Cargo (
	cargo varchar(30),
	salario_padrao integer,
	PRIMARY KEY (cargo)
);

CREATE TABLE PessoaCargo (
	cpf varchar(11),
	cargo varchar(30),
	salario integer,
	PRIMARY KEY (cpf, cargo),
	FOREIGN KEY (cpf) REFERENCES Pessoa,
	FOREIGN KEY (cargo) REFERENCES Cargo
);

insert into Pessoa values ('18483639528', 'João Garcia', 24, '47994730648');
insert into Pessoa values ('30583490572', 'Maria Vieira', 32, '47982049473');
insert into Pessoa values ('92723984280', 'Renato Espindola', 25, '47992374239');

insert into Cargo values ('Professor', 3400);
insert into Cargo values ('Cozinheiro', 2700);
insert into Cargo values ('Motorista', 2300);

insert into PessoaCargo values ('18483639528', 'Motorista', 2400);
insert into PessoaCargo values ('18483639528', 'Professor', 3000);
insert into PessoaCargo values ('30583490572', 'Cozinheiro', 2500);
insert into PessoaCargo values ('92723984280', 'Motorista', 2300)