import sys
import os
from sistema import Sistema, Cadastro

#executar este arquivo

sist = Sistema()

class Menu:
    def __init__(self):
        sist.load()
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
        print(sist.validacao(Cadastro(cpf, nome, idade, telefone)))
        input("Aperte Enter para continuar")

    def consulta(self):
        cpf = input("Digite o CPF a ser consultado: ")
        print(sist.consulta(cpf))
        input("Aperte Enter para continuar")
    
    def excluir(self):
        cpf = input("Digite o CPF a ser excluído: ")
        print(sist.excluir(cpf))
        input("Aperte Enter para continuar")
    
    def relatorio1(self):
        print("Idade:\t\tPessoas com esta idade:\n")
        sist.relatorio1()
        input("Aperte Enter para continuar")
    
    def relatorio2(self):
        print(sist.relatorio2())
        input("Aperte Enter para continuar")
    
    def sair(self):
        sist.save()
        print("Saiu")
        sys.exit(0)

m = Menu()
m.run()