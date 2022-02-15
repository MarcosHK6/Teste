from fastapi import FastAPI
from sistema import Pessoa, Sistema
from pydantic import BaseModel

sist = Sistema()
app = FastAPI()

@app.get("/")
def root():
    return {"Hello": "World"}

@app.get("/pessoa/getall")
def get_all():
    return sist.getall()

@app.get("/pessoa/consulta/{cpf}")
def consulta(cpf: str):
    if not sist.validacao(cpf):
        return {"Mensagem": "CPF deve ser informado exclusivamente por números"}
    pessoa = sist.get(cpf)
    if pessoa == None:
        return {"Mensagem": "Cadastro não encontrado"}
    else:
        return pessoa

@app.post("/pessoa/add")
def add_pessoa(pessoa: Pessoa):
    if not sist.validacao(pessoa.cpf, pessoa.idade, pessoa.telefone):
        return {"Mensagem": "CPF, idade e telefone devem ser informados exclusivamente por números"}
    if sist.add_pessoa(pessoa):
        return {"Mensagem": "Cadastro efetuado com sucesso!"}
    else:
        return {"Mensagem": "Este CPF já está cadastrado no sistema"}

@app.delete("/pessoa/delete/{cpf}")
def delete_pessoa(cpf: str):
    excluido = sist.excluir(cpf)
    if excluido:
        return {"Mensagem": "Cadastro excluído"}
    else:
        return {"Mensagem": "Cadastro não encontrado"}

@app.put("/pessoa/update/{cpf}")
def update_pessoa(cpf: str, pessoa: Pessoa):
    if not sist.validacao(pessoa.cpf, pessoa.idade, pessoa.telefone):
        return {"Mensagem": "CPF, idade e telefone devem ser informados exclusivamente por números"}
    status = sist.update(cpf, pessoa)
    if status == 1:
        return {"Mensagem": "Alteração de cadastro ocorreu com sucesso!"}
    else:
        return {"Mensagem": "Cadastro não encontrado"}

@app.get("/relatorio/1")
def relatorio1():
    return sist.relatorio1()

@app.get("/relatorio/2")
def relatorio2():
    return sist.relatorio2()