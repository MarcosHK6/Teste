import pickle
import psycopg

class Cadastro:
    def __init__(self, cpf, nome, idade, telefone):
        self.cpf = cpf
        self.nome = nome
        self.idade = idade
        self.telefone = telefone

class Sistema:
    def __init__(self):
        self.cadastros = []
        self.idadelist = []
        self.connection = psycopg.connect(user="postgres",
									  password="postgres",
                                      port="5432",
									  #host="127.0.0.1",
                                      host="localhost"
									  database="SRS")

    def validacao(self, c: Cadastro):
        try:
            c.cpf = int(c.cpf)
            c.idade = int(c.idade)
            c.telefone = int(c.telefone)
        except ValueError:
            del c
            return "\nCPF, idade e telefone devem ser informados exclusivamente por números\n"
        except:
            del c
            return "\nAlgum erro ocorreu, CPF, idade ou telefone inválidos\n"
        else:
            if self.consulta(c.cpf) != "\nCadastro não encontrado\n":
                return "\nEste CPF já está cadastrado\n"
            else:
                self.cadastros.append(c)
                return "\nCadastro ocorreu com sucesso!\n"
    
    def save(self):
        cpflist = []
        nomelist = []
        idadelist= []
        telefonelist = []
        for c in self.cadastros:
            cpflist.append(c.cpf)
            nomelist.append(c.nome)
            idadelist.append(c.idade)
            telefonelist.append(c.telefone)
        with open("savefile","wb") as f:
            data = [cpflist, nomelist, idadelist, telefonelist]
            pickle.dump(data, f)

    def load(self):
        try:
            with open("savefile","rb") as f:
                data = pickle.load(f)
            for i in range(len(data[0])):
                self.cadastros.append(Cadastro(data[0][i], data[1][i], data[2][i], data[3][i]))
        except (FileNotFoundError, EOFError):
            pass
        
    def consulta(self, cpf):
        cpf = int(cpf)
        for c in self.cadastros:
            if c.cpf == cpf:
                return f"""
Cadastro encontrado!
                
CPF: {cpf}
Nome: {c.nome}
Idade: {c.idade}
Telefone: {c.telefone}
                
"""
        return "\nCadastro não encontrado\n"

    def excluir(self, cpf):
        cpf = int(cpf)
        for i in range(len(self.cadastros)):
            if self.cadastros[i].cpf == cpf:
                x = self.cadastros.pop(i)
                del x
                return "\nCadastro excluído\n"
        return "\nCadastro não encontrado\n"

    def relatorio1(self):
        lista_idades = [0]*125
        for c in self.cadastros:
            lista_idades[c.idade]+=1
        for i in range(len(lista_idades)):
            if lista_idades[i] != 0:
                print(f"{i}\t\t{lista_idades[i]}")
        print("")
        print(f"Total de pessoas cadastradas: {len(self.cadastros)}\n")

    def relatorio2(self):
        nova = 125
        p_nova = 0
        velha = 0
        p_velha = 0
        soma = 0
        media = 0
        for c in self.cadastros:
            if c.idade > velha:
                velha = c.idade
                p_velha = c
            if c.idade < nova:
                nova = c.idade
                p_nova = c
            soma += c.idade
        if len(self.cadastros) == 0:
            return "\nNão existem pessoas cadastradas\n"
        else:
            media = soma/len(self.cadastros)
            media = round(media, 2)
            return f"""
Pessoa mais nova:

CPF: {p_nova.cpf}
Nome: {p_nova.nome}
Idade: {p_nova.idade}
Telefone: {p_nova.telefone}

Pessoa mais velha:

CPF: {p_velha.cpf}
Nome: {p_velha.nome}
Idade: {p_velha.idade}
Telefone: {p_velha.telefone}

Média de todas as idades: {media} anos
"""
