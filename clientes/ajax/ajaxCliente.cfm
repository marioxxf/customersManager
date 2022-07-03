<cfquery name="clienteAlvo" datasource="dataGioia">
	select * from clientes where id = '#url.idCliente#'
</cfquery>