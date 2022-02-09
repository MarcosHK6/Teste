import sys
import os
from sistema import Sistema, Cadastro

#executar este arquivo

sist = Sistema()

class Menu:
    def __init__(self):
        self.choices = {
            "1": self.cadastro,
            "2": self.consulta,
            "3": self.excluir,
            "4": self.relatorio1,
            "5": self.relatorio2,
            "6": self.sair}
    
    def display_menu(self):
        print("""
-----------------------------------------------------------------------------------
Página Principal

1. Realizar cadastro
2. Consultar cadastro
3. Excluir cadastro
4. Exibir relatório 1
5. Exibir relatório 2
6. Sair
""")

    def run(self):
        while True:
            self.display_menu()
            choice = input("\nEscolha uma opção:\n\n" )
            action = self.choices.get(choice)
            if action:
                os.system('cls' if os.name == 'nt' else 'clear')
                action()
                os.system('cls' if os.name == 'nt' else 'clear')
            else:
                print(f"{choice} Não é uma opção válida")
    
    def cadastro(self):
        cpf = input("Insira o CPF: ")
        nome = input("Insira o nome: ")
        idade = input("Insira a idade: ")
        telefone = input("Insira o telefone: ")
        cadastro = sist.put(cpf, nome, idade, telefone)
        if cadastro == 0:
            print("\nCadastro efetuado com sucesso!\n")
        elif cadastro == 1:
            print("\nEste CPF já está cadastrado no sistema\n")
        else:
            print("\nCPF, idade e telefone devem ser informados exclusivamente por números\n")
        input("Aperte Enter para continuar")

    def consulta(self):
        cpf = input("Digite o CPF a ser consultado: ")
        pessoa = sist.get(cpf)
        if pessoa == None:
            print("\nCadastro não encontrado\n")
        else:
            print(f"""\nCadastro encontrado!

CPF: {cpf}
Nome: {pessoa.nome}
Idade: {pessoa.idade}
Telefone: {pessoa.telefone}\n""")
        input("Aperte Enter para continuar")

    def excluir(self):
        cpf = input("Digite o CPF a ser excluído: ")
        excluir = sist.excluir(cpf)
        if excluir:
            print("\nCadastro excluído\n")
        else:
            print("\nCadastro não encontrado\n")
        #print(sist.excluir(cpf))
        input("Aperte Enter para continuar")
    
    def relatorio1(self):
        print("Idade:\t\tPessoas com esta idade:\n")
        relatorio1 = sist.relatorio1()
        if relatorio1 == []:
            print("\nNão existem pessoas cadastradas\n")
        else:
            for pessoa in relatorio1:
                print(f"{pessoa[0]}\t\t{pessoa[1]}")
        print()
        input("Aperte Enter para continuar")
    
    def relatorio2(self):
        relatorio2 = sist.relatorio2()
        if relatorio2[0] == []:
            print("\nNão existem pessoas cadastradas\n")
        else:
            p_nova = relatorio2[0][0]
            p_velha = relatorio2[0][1]
            media = relatorio2[1]
            print(f"""
Pessoa mais nova:

CPF: {p_nova[0]}
Nome: {p_nova[1]}
Idade: {p_nova[2]}
Telefone: {p_nova[3]}

Pessoa mais velha:

CPF: {p_velha[0]}
Nome: {p_velha[1]}
Idade: {p_velha[2]}
Telefone: {p_velha[3]}

Média de todas as idades: {round(media,2)} anos
""")
        input("Aperte Enter para continuar")
    
    def sair(self):
        print("Saiu")
        sys.exit(0)

m = Menu()
m.run()