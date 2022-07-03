<cfprocessingdirective pageencoding = "utf-8"/>
<cfmodule template="../imports.cfm">
<cfmodule template="../topmenu.cfm">

<cfquery name="clienteAlvo" datasource="dataGioia">
	select * from clientes where id = '#url.idCliente#'
</cfquery>

<div style="margin-left: 50px; margin-top: 50px; margin-right: 50px;">
    <a href="/testes/clientes/clientes.cfm" class="btn btn-primary">Voltar à lista de clientes</a>
	<h1>Informações de <cfoutput>#clienteAlvo.nome#</cfoutput></h1>
	<table class="table">
		<tr>
            <td><b>ID</b></td>
			<td><b>Nome</b></td>
			<td><b>CPF</b></td>
			<td><b>Email</b></td>
			<td><b>RG</b></td>
			<td><b>Nome do Pai</b></td>
			<td><b>Nome da Mãe</b></td>
			<td><b>Endereço</b></td>
			<td><b>Cidade</b></td>
			<td><b>Bairro</b></td>
			<td><b>Número da Residência</b></td>
			<td><b>CEP</b></td>
			<td><b>Número do Celular</b></td>
			<td><b>Data de Nascimento</b></td>
		</tr>
        <tr>
            <td><cfoutput>#clienteAlvo.id#</cfoutput></td>
            <td><cfoutput>#clienteAlvo.nome#</cfoutput></td>
            <td name="txtCpf" id="txtCpf"><cfoutput>#clienteAlvo.cpf#</cfoutput></td>
            <td><cfoutput>#clienteAlvo.email#</cfoutput></td>
			<td name="txtRg" id="txtRg"><cfoutput>#clienteAlvo.rg#</cfoutput></td>
			<td><cfoutput>#clienteAlvo.nomePai#</cfoutput></td>
			<td><cfoutput>#clienteAlvo.nomeMae#</cfoutput></td>
			<td><cfoutput>#clienteAlvo.logradouro#</cfoutput></td>
			<td><cfoutput>#clienteAlvo.cidade#</cfoutput></td>
			<td><cfoutput>#clienteAlvo.bairro#</cfoutput></td>
			<td><cfoutput>#clienteAlvo.numeroResidencia#</cfoutput></td>
			<td name="txtCep" id="txtCep"><cfoutput>#clienteAlvo.cep#</cfoutput></td>
			<td name="txtCelular" id="txtCelular"><cfoutput>#clienteAlvo.numeroCelular#</cfoutput></td>
			<td><cfoutput>#lsDateFormat(clienteAlvo.dataNasci, "dd/mm/yyyy")#</cfoutput></td>
        </tr>
	</table>
</div>

<script>
	$(document).ready(function(){
        $("#txtCpf").mask("000.000.000-00")
    });

	$(document).ready(function(){
        $("#txtRg").mask("00.000.000-0")
    });

	$(document).ready(function(){
        $("#txtCep").mask("00000-000")
    });

	$(document).ready(function(){
        $("#txtCelular").mask("(00) 00000-0000")
    });

	
</script>

<!--- JQuery's Masks --->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.11/jquery.mask.min.js"></script>