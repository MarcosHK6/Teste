var selectedRow = null

async function onFormSubmit() {
    if (validate()) {
        var data = readFormData();
        if (selectedRow == null)
            await post(data);
        else
            await update(data);
        resetForm();
    }
}

function readFormData() {
    var pessoa = {};
    pessoa["cpf"] = document.getElementById("cpf").value;
    pessoa["nome"] = document.getElementById("nome").value;
    pessoa["idade"] = document.getElementById("idade").value;
    pessoa["telefone"] = document.getElementById("telefone").value;
    return pessoa;
}

function insertNew(data) {
    var table = document.getElementById("personList").getElementsByTagName('tbody')[0];
    var newRow = table.insertRow();
    cell1 = newRow.insertCell(0);
    cell1.innerHTML = data.cpf;
    cell2 = newRow.insertCell(1);
    cell2.innerHTML = data.nome;
    cell3 = newRow.insertCell(2);
    cell3.innerHTML = data.idade;
    cell4 = newRow.insertCell(3);
    cell4.innerHTML = data.telefone;
    cell4 = newRow.insertCell(4);
    cell4.innerHTML = `<a onClick="onEdit(this)">Editar</a>
                       <a onClick="onDelete(this)">Excluir</a>`;
}

function resetForm() {
    document.getElementById("cpf").value = "";
    document.getElementById("nome").value = "";
    document.getElementById("idade").value = "";
    document.getElementById("telefone").value = "";
    selectedRow = null;
}

function onEdit(td) {
    selectedRow = td.parentElement.parentElement;
    document.getElementById("cpf").value = selectedRow.cells[0].innerHTML;
    document.getElementById("cpf").readOnly = true;
    document.getElementById("nome").value = selectedRow.cells[1].innerHTML;
    document.getElementById("idade").value = selectedRow.cells[2].innerHTML;
    document.getElementById("telefone").value = selectedRow.cells[3].innerHTML;
}
function updateRecord(formData) {
    selectedRow.cells[0].innerHTML = formData.cpf;
    selectedRow.cells[1].innerHTML = formData.nome;
    selectedRow.cells[2].innerHTML = formData.idade;
    selectedRow.cells[3].innerHTML = formData.telefone;
    document.getElementById("cpf").readOnly = false;
}

async function onDelete(td) {
    if (confirm('Certeza que quer excluir este cadastro?')) {
        selectedRow = td.parentElement.parentElement;
        await del();
        row = td.parentElement.parentElement;
        document.getElementById("personList").deleteRow(row.rowIndex);
        resetForm();
        selectedRow = null;
    }
}

function validate() {
    isValid = true;
    if (document.getElementById("cpf").value == "") {
        isValid = false;
        document.getElementById("CpfValidationError").style.display = "inline";
    } else {
        if (document.getElementById("CpfValidationError").style.display == "inline")
            document.getElementById("CpfValidationError").style.display = "none";
    }
    if (document.getElementById("nome").value == "") {
        isValid = false;
        document.getElementById("NameValidationError").style.display = "inline";
    } else {
        if (document.getElementById("NameValidationError").style.display == "inline")
            document.getElementById("NameValidationError").style.display = "none";
    }
    return isValid;
}

(async function getAll() {
    var data = await getapi("http://127.0.0.1:8000/pessoa/getall");
    for (let i = 0; i < data.length; i++) {
        insertNew(data[i]);
    }
})();

async function post(data) {
    const settings = {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(data)
    }
    const response = await postapi("http://127.0.0.1:8000/pessoa/add", settings);
    window.alert(response["Mensagem"]);
    if (response["status"] == 1) {
        insertNew(data);
    }
}    

async function update(data) {
    const settings = {
        method: 'PUT',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(data)
    }
    const response = await postapi("http://127.0.0.1:8000/pessoa/update", settings);
    window.alert(response["Mensagem"]);
    if (response["status"] == 1) {
        updateRecord(data);
    }
}

async function del() {
    data = {"cpf": selectedRow.cells[0].innerHTML};
    const settings = {
        method: 'delete',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(data)
    }
    const response = await postapi("http://127.0.0.1:8000/pessoa/delete", settings);
    window.alert(response["Mensagem"]);
}

async function getapi(url) {
    const response = await fetch(url);
    var data = response.json();
    return data;
}

async function postapi(url, settings = "") {
    const response = await fetch(url, settings);
    var data = response.json();
    return data;
}
