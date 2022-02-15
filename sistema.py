import psycopg
from pydantic import BaseModel

#class Cadastro():
#    def __init__(self, cpf, nome, idade, telefone):
#        self.cpf = cpf
#        self.nome = nome
#        self.idade = idade
#        self.telefone = telefone

class Pessoa(BaseModel):
    cpf: str
    nome: str
    idade: int
    telefone: str

class Sistema:
    def __init__(self):
        self.pessoas = {}
        self.info = 'postgresql://postgres:postgres@localhost:5432/Pessoa'
        self.connection = psycopg.connect(conninfo=self.info)
        #self.connection = psycopg.connect(user="postgres",
	    #								  password="postgres",
        #                              port="5432",
		#							  #host="127.0.0.1",
        #                              host="localhost",
		#							  database="SRS")

    def validacao(self, cpf, idade = 0, telefone = 0):
        try:
            cpf = int(cpf)
            idade = int(idade)
            telefone = int(telefone)
        except ValueError:
            return False
        else:
            cpf = str(cpf)
            telefone = str(telefone)
            return True

    def consulta(self, cpf):
        return self.pessoas.get(cpf)
        for c in self.pessoas:
            if c.cpf == cpf:
                return c
            else:
                return None

    def get(self, cpf):
        pessoa = self.consulta(cpf)
        if pessoa == None:
            cursor = self.connection.cursor()
            consulta = f"SELECT CPF, NOME, IDADE, TELEFONE FROM PESSOA WHERE CPF = %s"
            cursor.execute(consulta, (cpf,))
            encontrado = cursor.fetchone()
            if encontrado != None:
                cpf = encontrado[0]
                nome = encontrado[1]
                idade = encontrado[2]
                telefone = encontrado[3]
                pessoa = Pessoa(cpf=cpf, nome=nome, idade=idade, telefone=telefone)
                self.pessoas[cpf] = pessoa
                cursor.close()
                return pessoa
            else:
                cursor.close()
                return None
        else:
            return pessoa

    def getall(self):
        cursor = self.connection.cursor()
        consulta = "SELECT * FROM PESSOA"
        cursor.execute(consulta)
        all = cursor.fetchall()
        self.connection.commit()
        cursor.close()
        return all

    def add_pessoa(self, pessoa: Pessoa):
        if self.get(pessoa.cpf) == None:
            self.create_pessoa(pessoa)
            return True
        else:
            return False

    def create_pessoa(self, pessoa: Pessoa):
        self.pessoas[pessoa.cpf] = pessoa
        #self.pessoas.append(pessoa)
        cursor = self.connection.cursor()
        consulta = "INSERT INTO PESSOA VALUES (%s, %s, %s, %s)"
        cursor.execute(consulta, (pessoa.cpf, pessoa.nome, pessoa.idade, pessoa.telefone))
        self.connection.commit()
        cursor.close()

    def excluir(self, cpf):
        self.pessoas.pop(cpf, None)
        cursor = self.connection.cursor()
        consulta = "DELETE FROM PESSOA WHERE CPF = %s"
        cursor.execute(consulta, (cpf,))
        excluido = cursor.rowcount
        self.connection.commit()
        cursor.close()
        if excluido == 1:
            return True
        else:
            return False

    def update(self, cpf, pessoa: Pessoa):
        self.pessoas.pop(cpf, None)
        self.pessoas[pessoa.cpf] = pessoa
        cursor = self.connection.cursor()
        consulta = """UPDATE PESSOA
                    SET CPF = %s, NOME = %s, IDADE = %s, TELEFONE = %s
                    WHERE CPF = %s"""
        cursor.execute(consulta, (pessoa.cpf, pessoa.nome, pessoa.idade, pessoa.telefone, cpf))
        self.connection.commit()
        update = cursor.rowcount
        cursor.close()
        return update

    def relatorio1(self):
        cursor = self.connection.cursor()
        consulta = "SELECT IDADE, COUNT(CPF) FROM PESSOA GROUP BY IDADE ORDER BY IDADE"
        relatorio = cursor.execute(consulta).fetchall()
        cursor.close()
        return relatorio

    def relatorio2(self):
        cursor = self.connection.cursor()
        consulta = """SELECT CPF, NOME, IDADE, TELEFONE FROM PESSOA WHERE IDADE = (SELECT MIN(IDADE) FROM PESSOA)
                    UNION ALL
                    SELECT CPF, NOME, IDADE, TELEFONE FROM PESSOA WHERE IDADE = (SELECT MAX(IDADE) FROM PESSOA)"""
        relatorio = cursor.execute(consulta).fetchall()
        consulta = "SELECT AVG(IDADE) FROM PESSOA"
        media_idades = cursor.execute(consulta).fetchone()
        cursor.close()
        return (relatorio, media_idades[0])