from fastapi import FastAPI
from sistema import Cadastro, Sistema

sist = Sistema()
app = FastAPI()

@app.get("/")
def root():
    return

@app.post("/pessoa/add")

@app.get("/consulta/{cpf}")
def consulta(cpf: str):
    pessoa = sist.get(cpf)
    if pessoa == None:
        return "Cadastro não encontrado"
    else:
        return pessoa

@app.post("/pessoa/add")
def add_pessoa():
    return

@app.delete("/pessoa/{cpf}/delete")
def delete_pessoa(cpf: str):
    excluido = sist.excluir(cpf)
    if excluido:
        return "Cadastro excluído"
    else:
        return "Cadastro não encontrado"

@app.get("/relatorio/1")
def relatorio1():
    return sist.relatorio1()

@app.get("/relatorio/2")
def relatorio2():
    return sist.relatorio2()