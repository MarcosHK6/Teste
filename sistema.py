import psycopg
from pydantic import BaseModel

class Cadastro():
    def __init__(self, cpf, nome, idade, telefone):
        self.cpf = cpf
        self.nome = nome
        self.idade = idade
        self.telefone = telefone

class Sistema:
    def __init__(self):
        self.cadastros = []
        self.info = 'postgresql://postgres:postgres@localhost:5432/Pessoa'
        self.connection = psycopg.connect(conninfo=self.info)
        #self.connection = psycopg.connect(user="postgres",
	    #								  password="postgres",
        #                              port="5432",
		#							  #host="127.0.0.1",
        #                              host="localhost",
		#							  database="SRS")

    def validacao(self, cpf, idade, telefone):
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
        for c in self.cadastros:
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
                pessoa = Cadastro(cpf, nome, idade, telefone)
                self.cadastros.append(pessoa)
                return pessoa
            else:
                return None
        else:
            return pessoa

    def put(self, cpf, nome, idade, telefone):
        if self.validacao(cpf, idade, telefone):
            if self.get(cpf) == None:
                self.create_pessoa(cpf, nome, idade, telefone)
                return 0
            else:
                return 1
        else:
            return 2

    def create_pessoa(self, cpf, nome, idade, telefone):
        self.cadastros.append(Cadastro(cpf, nome, idade, telefone))
        cursor = self.connection.cursor()
        consulta = "INSERT INTO PESSOA VALUES (%s, %s, %s, %s)"
        cursor.execute(consulta, (cpf, nome, idade, telefone))
        self.connection.commit()
        cursor.close()

    def excluir(self, cpf):
        cursor = self.connection.cursor()
        consulta = f"DELETE FROM PESSOA WHERE CPF = %s"
        cursor.execute(consulta, (cpf,))
        excluido = cursor.rowcount
        self.connection.commit()
        cursor.close()
        if excluido == 1:
            return True
        else:
            return False

    def relatorio1(self):
        cursor = self.connection.cursor()
        consulta = f"SELECT IDADE, COUNT(CPF) FROM PESSOA GROUP BY IDADE ORDER BY IDADE"
        relatorio = cursor.execute(consulta).fetchall()
        cursor.close()
        return relatorio

    def relatorio2(self):
        cursor = self.connection.cursor()
        consulta = f"""SELECT CPF, NOME, IDADE, TELEFONE FROM PESSOA WHERE IDADE = (SELECT MIN(IDADE) FROM PESSOA)
                    UNION ALL
                    SELECT CPF, NOME, IDADE, TELEFONE FROM PESSOA WHERE IDADE = (SELECT MAX(IDADE) FROM PESSOA)"""
        relatorio = cursor.execute(consulta).fetchall()
        consulta = "SELECT AVG(IDADE) FROM PESSOA"
        media_idades = cursor.execute(consulta).fetchone()
        cursor.close()
        return (relatorio, media_idades[0])