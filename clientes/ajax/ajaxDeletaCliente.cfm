<cfquery name="clienteAlvo" datasource="dataGioia">
	delete from clientes where id = '#url.idCliente#'
</cfquery>