<cfprocessingdirective pageencoding = "utf-8"/>
<cfmodule template="../imports.cfm">
<cfmodule template="../topmenu.cfm">

<cfset usuarioLogado = getAuthUser()>
<cfif usuarioLogado eq "">
    <div class="container" style="margin-top: 1%; margin-right: 250px;" align="center">
        <div class="col-6">
            <h1><a href="/testes/autenticacao/cadastro.cfm">Cadastre-se</a> ou <a href="/testes/autenticacao/login.cfm">faça login</a> para realizar algum cadastro</h1><br>
        <div>
    </div>
    <cfelse>
        <cfif isDefined('form.hdnvalida') and form.hdnvalida eq '1'>
            <cffile action="upload" destination="C:/ColdFusion2021/cfusion/wwwroot/testes/clientes/arquivoXls" fileField="form.campoArquivo" nameConflict="overwrite">
            <cfscript>
                arquivo={};
                arquivo.key = generateSecretKey("AES");
                nomeArquivo = "#arquivo.key##cffile.SERVERFILE#";
            </cfscript>
            <cffile action="rename" source="C:/ColdFusion2021/cfusion/wwwroot/testes/clientes/arquivoXls/#cffile.SERVERFILE#" destination="C:/ColdFusion2021/cfusion/wwwroot/testes/clientes/arquivoXls/#nomeArquivo#" attributes="normal">
            <cfspreadsheet excludeHeaderRow="true" headerrow="1" action="read" src="#cffile.SERVERDIRECTORY#\#nomeArquivo#" query="retornoExcel"> 
            <br>
            <br>
            <cfset cont = 1>
            <cfloop query="retornoExcel">	
                <cfset dataInserida = #dataNascimento#>
                <cfset dataTransformada = #lsParseDateTime(#dataInserida#)#>
                <cfset dataTransformada = #lsDateFormat(dataTransformada, "yyyy-dd-mm hh:mm:ss")#>
                <cfquery datasource="dataGioia">
                    insert into clientes(
                    nome,
                    cpf,
                    email,
                    rg,
                    nomePai,
                    nomeMae,
                    logradouro,
                    cidade,
                    bairro,
                    numeroResidencia,
                    cep,
                    numeroCelular,
                    dataNasci
                    )values(
                        '<cfoutput>#nome#</cfoutput>',
                        '<cfoutput>#cpf#</cfoutput>',
                        '<cfoutput>#email#</cfoutput>',
                        '<cfoutput>#rg#</cfoutput>',
                        '<cfoutput>#nomeDoPai#</cfoutput>',
                        '<cfoutput>#nomeDaMae#</cfoutput>',
                        '<cfoutput>#logradouro#</cfoutput>',
                        '<cfoutput>#cidade#</cfoutput>',
                        '<cfoutput>#bairro#</cfoutput>',
                        '<cfoutput>#numeroResidencia#</cfoutput>',
                        '<cfoutput>#cep#</cfoutput>',
                        '<cfoutput>#numeroCelular#</cfoutput>',
                        '<cfoutput>#dataTransformada#</cfoutput>'
                    )
                </cfquery>
        
                <cfquery name="buscaUltimoRegistro" datasource="dataGioia">
                    select id from clientes where nome = '#nome#' and cpf = '#cpf#' and email = '#email#' and rg = '#rg#' and nomePai = '#nomeDoPai#' and nomeMae = '#nomeDaMae#' and logradouro = '#logradouro#' and cidade = '#cidade#' and bairro = '#bairro#' and numeroResidencia = '#numeroResidencia#' and cep = '#cep#' and numeroCelular = '#numeroCelular#' and dataNasci = '#dataTransformada#'
                </cfquery>
        
                <cfset usuarioLogado = getAuthUser()>
                <cfquery name="buscaIdUsuarioLogado" datasource="dataGioia">
                    select id from users where usuario = '#usuarioLogado#'
                </cfquery>
        
                <cfquery datasource="dataGioia">
                    insert into logCadastros(
                        modalidade,
                        pathArquivo,
                        nomeArquivo,
                        idClienteCriado,
                        idUsuarioCriador,
                        dataCadastro
                    ) values(
                        'Automático',
                        '#cffile.SERVERDIRECTORY#\#nomeArquivo#',
                        '#nomeArquivo#',
                        #buscaUltimoRegistro.id#,
                        #buscaIdUsuarioLogado.id#,
                        getdate()
                    )
                </cfquery>
                <cfset cont = cont + 1>
            </cfloop>
            <br>
            <br>
            <script>
                alert("Cadastro(s) realizado(s)!");
                window.location.href = 'http://127.0.0.1:8500/testes/clientes/clientes.cfm';
            </script>
        </cfif>
        
            <div style="margin-left: 50px; margin-top: 50px; margin-right: 50px;">
                <a href="/testes/clientes/clientes.cfm" class="btn btn-primary">Voltar à lista de clientes</a><br>
            </div>
            <div class="container" style="margin-top: 1%; margin-right: 250px;" align="center">
                <div class="col-6">
                    <h1>Cadastro de cliente(s) automatizado</h1><br>
                    <div>
                        <label><b>Modelo de planilha para realizar o cadastro</b></label><br>
                        <div>
                            <a href="arquivoXls/modelo.xlsx" download>Download do modelo</a><br><br>
                        </div>
                        <div>
                            <label><b>Anexe a planilha preenchida abaixo</b></label><br><br>
                        </div>
                    </div>
                    <form name="formArquivo" id="formArquivo" enctype="multipart/form-data" method="post" >
                        <input type="hidden" name="hdnvalida" id="hdnvalida" value="0"> 
                        <input type="file" name="campoArquivo" ><br><br>
                        <button type="button" onclick="envia()" class="btn btn-primary">Cadastrar cliente(s)</button>
                    </form>
                </div>
            </div>
        
        <script>
            function envia(){
                document.getElementById('hdnvalida').value = 1;
                document.getElementById('formArquivo').submit();
            }
        </script>
</cfif>
    
