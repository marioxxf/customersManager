<cfprocessingdirective pageencoding = "utf-8"/>
<cfmodule template="../imports.cfm">
<cfmodule template="../topmenu.cfm">

<cfset usuarioLogado = getAuthUser()>

<cfquery name="buscaUsuarioLogado" datasource="dataGioia">
    select * from users where usuario = '#usuarioLogado#'
</cfquery>

<cfquery name="buscaAtividades" datasource="dataGioia">
    select *, DATEPART(minute,dataCadastro) 'minuto' 
    from logCadastros where idUsuarioCriador = 1
</cfquery>

<cfif usuarioLogado neq "">
    <div style="margin-left: 50px; margin-top: 50px; margin-right: 50px;">
        <h1>Minha Conta</h1>
        <table class="table" style="width:100%">
            <tr>
                <td><b>Usuário</b></td>
                <td><b>Usuário desde</b></td>
            </tr>
            <tr>
                <td><cfoutput>#buscaUsuarioLogado.usuario#</cfoutput></td>
                <td><cfoutput>#lsDateFormat(buscaUsuarioLogado.dataCriacao, "dd/mm/yyyy")#</cfoutput></td>
            </tr>
        </table><br>
        <h1>Minha Atividade</h1>
        <table class="table" style="width:100%">
            <tr>
                <td><b>ID do registro</b></td>
                <td><b>Tipo de registro</b></td>
                <td><b>Acesso ao arquivo utilizado para registro</b></td>
                <td><b>Cliente registrado</b></td>
                <td><b>Registrado em</b></td>
                <td><center><b>Acesso ao perfil do cliente registrado</b></center></td>
            </tr>
            <cfloop query="buscaAtividades">
                <cfquery name="buscaNomeClienteRegistrado" datasource="dataGioia">
                    select nome from clientes where id = #buscaAtividades.idClienteCriado#
                </cfquery>
                <tr>
                    <td><cfoutput>#buscaAtividades.id#</cfoutput></td>
                    <td><cfoutput>#buscaAtividades.modalidade#</cfoutput></td>
                    <td>
                        <cfif buscaAtividades.modalidade eq 'Automático'>
                            <center><a href="../clientes/arquivoXls/<cfoutput>#buscaAtividades.nomeArquivo#</cfoutput>" download>Download</a><br><br></center>
                        <cfelse>
                            <center>Registro não foi automático</center>
                        </cfif>
                    </td>
                    <td><cfoutput>#buscaNomeClienteRegistrado.nome#</cfoutput></td>
                    <cfquery name="buscaMinutagemCorreta" datasource="dataGioia">
                        select dataCadastro 'Today', DATEPART(minute,dataCadastro) 'minuto' from logCadastros
                    </cfquery>
                    <td><cfoutput>#lsDateFormat(buscaAtividades.dataCadastro, "dd/mm/yyyy HH:#buscaAtividades.minuto#:ss")#</cfoutput></td>
                    <td onclick="buscarCliente(<cfoutput>#buscaAtividades.idClienteCriado#</cfoutput>);"><center><input type="button" class="btn-info" value="Acesso" style="color: rgba(0,0,0,.5); background-color: white; border-color: white;"/></center></td>
                </tr>
            </cfloop>
        </table>
    </div>
<cfelse>
    <div style="margin-left: 50px; margin-top: 50px; margin-right: 50px;">
        <h3>Cadastre-se ou faça login para ter acesso a essa página</h3>
    </div>
</cfif>

<script>
    function buscarCliente(clienteId){
		$.ajax({
			url: 'ajaxCliente.cfm?',
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
</script>