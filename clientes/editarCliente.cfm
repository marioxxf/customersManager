<cfprocessingdirective pageencoding = "utf-8"/>
<cfmodule template="../imports.cfm">
<cfmodule template="../topmenu.cfm">

<cfif isDefined('form.hdnEditar') and '#form.hdnEditar#' eq 1>
    <cfquery datasource="dataGioia">
        update clientes set nome = '#form.nome#',
                            cpf = '#form.cpf#',
                            email = '#form.email#'
        where id = #url.idCliente#
    </cfquery>

    <script> 
        alert("Dados atualizados com sucesso!");
        window.location.href = 'http://127.0.0.1:8500/testes/clientes/clientes.cfm';
    </script>
</cfif>

<cfquery name="clienteAlvo" datasource="dataGioia">
	select * from clientes where id = '#url.idCliente#'
</cfquery>

<div style="margin-left: 50px; margin-top: 50px; margin-right: 50px;">
    <a href="/testes/clientes/clientes.cfm" class="btn btn-primary">Voltar à lista de clientes</a><br>
</div>
<div class="container" style="margin-top: 1%" align="center">
    <div class="col-6">
        <h1>Edição de dados do cliente</h1><br>
        <form id="formulario" name="formulario" action="" method="POST">
            <div class="form-group">
                <label>Nome completo</label>
                <input type="hidden" name="hdnEditar" id="hdnEditar" value="0"/>
                <input class="form-control" value="<cfoutput>#clienteAlvo.nome#</cfoutput>" type="text" name="nome" id="nome" placeholder="Ex: Mario Everett Gioia"> <br>
            </div>

            <div class="form-group">
                <label>CPF</label>
                <input class="form-control" value="<cfoutput>#clienteAlvo.cpf#</cfoutput>" type="text" name="cpf" id="cpf" placeholder="Insira apenas números"> <br>
            </div>

            <div class="form-group">
                <label>E-mail</label>
                <input class="form-control" value="<cfoutput>#clienteAlvo.email#</cfoutput>" type="text" name="email" id="email" placeholder="Digite a data de validade do produto..."> <br>
            </div>
            <div class="form-group text-center">
                <button name="botaocadastro" id="botaocadastro" type="submit" class="btn btn-primary" onclick="editar()">Editar dados</button>
            </div>
        </form>
    </div>
</div>
<script>
    function editar(){
        document.getElementById('hdnEditar').value = '1';
        document.getElementById('formulario').submit();
    }
</script>