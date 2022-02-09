CREATE TABLE IF NOT EXISTS Pessoa (
	cpf varchar(11),
	nome varchar(30) NOT NULL,
	idade integer NOT NULL,
	telefone varchar(11),
	PRIMARY KEY (cpf)
);
--CPF foi escolhido como chave primária por ser único a cada pessoa

CREATE TABLE IF NOT EXISTS Cargo (
	cargo varchar(30),
	salario_padrao integer,
	PRIMARY KEY (cargo)
);

CREATE TABLE IF NOT EXISTS PessoaCargo (
	cpf varchar(11),
	cargo varchar(30),
	salario integer,
	PRIMARY KEY (cpf, cargo),
	FOREIGN KEY (cpf) REFERENCES Pessoa ON DELETE RESTRICT,
	FOREIGN KEY (cargo) REFERENCES Cargo ON DELETE RESTRICT
);

insert into Pessoa values ('18483639528', 'João Garcia', 24, '47994730648');
insert into Pessoa values ('30583490572', 'Maria Vieira', 32, '47982049473');
insert into Pessoa values ('92723984280', 'Renato Espindola', 25, '47992374239');
insert into Pessoa values ('49028240540', 'Daniel Fischer', 30, '47920384785');

insert into Cargo values ('Professor', 3400);
insert into Cargo values ('Cozinheiro', 2700);
insert into Cargo values ('Motorista', 2300);

insert into PessoaCargo values ('18483639528', 'Motorista', 2400);
insert into PessoaCargo values ('18483639528', 'Professor', 3000);
insert into PessoaCargo values ('30583490572', 'Cozinheiro', 2500);
insert into PessoaCargo values ('92723984280', 'Motorista', 2300)

create view v1 as
select nome, coalesce(sum(salario), 0) as soma_salarios, coalesce(sum(salario_padrao),0) as soma_salarios_base
from ((pessoa
left join pessoacargo on pessoa.cpf = pessoacargo.cpf)
left join cargo on cargo.cargo = pessoacargo.cargo)
group by nome
order by nome

--create view v2 as
--select nome, sum(salario) as soma_salarios, sum(salario_padrao) as soma_salarios_base
--from pessoa, cargo, pessoacargo
--where pessoa.cpf = pessoacargo.cpf and cargo.cargo = pessoacargo.cargo
--group by nome
--order by nome