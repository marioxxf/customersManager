<cflogout>

<cfquery name="validaLogin" datasource="dataGioia">
    update users set statusLogin = 0 where usuario = '#url.usuario#'
</cfquery>