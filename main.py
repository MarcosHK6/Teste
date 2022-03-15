from fastapi import FastAPI, Request
from fastapi.templating import Jinja2Templates
from fastapi.encoders import jsonable_encoder
from fastapi.responses import HTMLResponse
from fastapi.middleware.cors import CORSMiddleware
from sistema import Pessoa, Sistema
from pydantic import BaseModel

sist = Sistema()
app = FastAPI()
templates = Jinja2Templates(directory="templates")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

@app.get("/", response_class=HTMLResponse)
def root(request: Request):
    return templates.TemplateResponse("home.html", {"request": request})
    return {"Hello": "World"}

@app.get("/pessoa/getall")
def get_all():
    return sist.getall()

@app.get("/pessoa/consulta/{cpf}")
def consulta(request: Request, cpf: str):
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
        return {"Mensagem": "CPF, idade e telefone devem ser informados exclusivamente por números",
                "status": 0}
    if sist.add_pessoa(pessoa):
        return {"Mensagem": "Cadastro efetuado com sucesso!", "status": 1}
    else:
        return {"Mensagem": "Este CPF já está cadastrado no sistema", "status": 2}

@app.delete("/pessoa/delete/")
def delete_pessoa(data: dict):
    excluido = sist.excluir(data["cpf"])
    if excluido:
        return {"Mensagem": "Cadastro excluído", "status": 1}
    else:
        return {"Mensagem": "Cadastro não encontrado", "status": 0}

@app.put("/pessoa/update")
def update_pessoa(pessoa: Pessoa):
    if not sist.validacao(pessoa.cpf, pessoa.idade, pessoa.telefone):
        return {"Mensagem": "CPF, idade e telefone devem ser informados exclusivamente por números", "status": 0}
    status = sist.update(pessoa.cpf, pessoa)
    if status == 1:
        return {"Mensagem": "Alteração de cadastro ocorreu com sucesso!", "status": 1}
    else:
        return {"Mensagem": "Cadastro não encontrado", "status": 2}

@app.get("/relatorio/1")
def relatorio1():
    return sist.relatorio1()

@app.get("/relatorio/2")
def relatorio2():
    return sist.relatorio2()