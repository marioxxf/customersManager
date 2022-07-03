<cfprocessingdirective pageencoding = "utf-8"/>
<cfmodule template="../imports.cfm">
<cfmodule template="../topmenu.cfm">

<style>
    .cliente:hover {
        background-color: #0d6efd;
    }
</style>

<cfquery name="clientesCadastrados" datasource="dataGioia">
	select * from clientes
</cfquery>

<div style="margin-left: 50px; margin-top: 50px; margin-right: 50px;">
    <a href="/testes/clientes/criarCliente.cfm" class="btn btn-primary">Cadastrar novo cliente</a>
	<h1>Clientes cadastrados</h1><br>
    <table id="tabelaGioia" name="tabelaGioia" class="display" style="width:100%">
        <thead>
            <tr>
                <th>Nome</th>
                <th>CPF</th>
                <th>Perfil do cliente</th>
                <th>Editar</th>
                <th>Excluir</th>
            </tr>
        </thead>
        <tbody>
            <cfloop query="#clientesCadastrados#">
                <tr class="cliente">
                    <td><cfoutput>#clientesCadastrados.nome#</cfoutput></td>
                    <td><cfoutput>#clientesCadastrados.cpf#</cfoutput></td>
                    <td onclick="buscarCliente(<cfoutput>#clientesCadastrados.id#</cfoutput>);"><input type="button" class="btn-info" value="Acesso" style="color: rgba(0,0,0,.5); background-color: white; border-color: white;"/></td>
                    <td onclick="editaCliente(<cfoutput>#clientesCadastrados.id#</cfoutput>);"><img src="src/edit.png" width="23px" height="23px"></td>
                    <td onclick="deletaCliente(<cfoutput>#clientesCadastrados.id#</cfoutput>, '<cfoutput>#clientesCadastrados.nome#</cfoutput>');"><img src="src/delete.png" width="23px" height="23px"></td>
                </tr>
            </cfloop>
        </tbody>
        <tfoot>
            <tr>
                <th>Nome</th>
                <th>CPF</th>
                <th>Perfil do cliente</th>
                <th>Editar</th>
                <th>Excluir</th>
            </tr>
        </tfoot>
    </table><br>
</div>

<script>
	function buscarCliente(clienteId){
		$.ajax({
			url: 'ajax/ajaxCliente.cfm?',
			async: false,
			data : {"idCliente": clienteId},
			cache: false,
			contentType: "application/json; charset=utf-8",
			success: function(retorno){
				console.log('Cliente buscado!');
			}
		});
        window.location.href = 'http://127.0.0.1:8500/testes/clientes/cliente.cfm?idCliente=' + clienteId;
	}

    function editaCliente(clienteId){
        window.location.href = 'http://127.0.0.1:8500/testes/clientes/editarCliente.cfm?idCliente=' + clienteId;
    }

    function deletaCliente(clienteId, clienteNome){
        swal({
            title: "Você realmente quer deletar o cliente " + clienteNome + " da lista?",
            text: "É você quem sabe...",
            icon: "warning",
            buttons: true,
            buttons: ["Não, eu desisti.", "Sim, deletar."],
            dangerMode: true,
        })
            .then((willDelete) => {
                if (willDelete) {
                    $.ajax({
			url: 'ajax/ajaxDeletaCliente.cfm?',
			async: false,
			data : {"idCliente": clienteId},
			cache: false,
			contentType: "application/json; charset=utf-8",
			success: function(retorno){
				console.log('Cliente deletado!');
			}
		});
            swal("Pronto! O cliente foi deletado.", {
                icon: "success",
            });
            setTimeout(function () {
                location.reload();
            }, 2000);
        } else {
            swal("Ok, o cliente não será deletado.");
        }
            });
    }

$(document).ready(function() {
    $('#tabelaGioia').DataTable( {
        "language": {
            "url": "http://cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Portuguese-Brasil.json"
        }, 
        dom: 'Blfrtip',
        lengthMenu: [
            [-1, 2, 7, 15],
            ['Mostrar todos', '2', '7', '15']
        ],
        buttons: [
            'copy',
            'print',
            'csv',
            'excel',
            {
                title: 'dadosExportados',
                extend: 'pdfHtml5',
                messageTop: 'PDF criado pelo PDFMake do DataTable do JQuery.'
            },
            {
                extend: 'spacer',
                style: 'bar',
                text: '<br><br>'
            },
        ]
        });
});

<!---$('#tabelaGioia tbody').on('click', 'tr', function () {
        var table = $('#tabelaGioia').DataTable();
        var data = table.row(this).data();
        alert('You clicked on ' + data[0] + "'s row");
    });--->
</script>