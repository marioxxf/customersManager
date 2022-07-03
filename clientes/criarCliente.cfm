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
        <cfif isDefined('form.hdnSalvar') and '#form.hdnSalvar#' eq 1>
            <cfset dataInserida = "#form.txtDataNasc#">
            <cfset dataNascimento = #lsParseDateTime(#dataInserida#)#>
            <cfset dataNascimento = #lsDateFormat(dataNascimento, "yyyy-dd-mm hh:mm:ss")#>
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
                    ) values(
                    '#form.txtNome#',
                    '#form.txtCpf#',
                    '#form.txtEmail#',
                    '#form.txtRg#',
                    '#form.txtNomePai#',
                    '#form.txtNomeMae#',
                    '#form.txtLogradouro#',
                    '#form.txtCidade#',
                    '#form.txtBairro#',
                    '#form.txtNumero#',
                    '#form.txtCep#',
                    '#form.txtNumeroCelular#',
                    '#dataNascimento#'
                );
            </cfquery>
            <cfquery name="buscaUltimoRegistro" datasource="dataGioia">
                select id from clientes where nome = '#form.txtNome#' and cpf = '#form.txtCpf#' and email = '#form.txtEmail#' and rg = '#form.txtRg#' and nomePai = '#form.txtNomePai#' and nomeMae = '#form.txtNomeMae#' and logradouro = '#form.txtLogradouro#' and cidade = '#form.txtCidade#' and bairro = '#form.txtBairro#' and numeroResidencia = '#form.txtNumero#' and cep = '#form.txtCep#' and numeroCelular = '#form.txtNumeroCelular#' and dataNasci = '#dataNascimento#'
            </cfquery>
        
            <cfset usuarioLogado = getAuthUser()>
            <cfquery name="buscaIdUsuarioLogado" datasource="dataGioia">
                select id from users where usuario = '#usuarioLogado#'
            </cfquery>
        
            <cfquery datasource="dataGioia">
                insert into logCadastros(
                    modalidade,
                    idClienteCriado,
                    idUsuarioCriador,
                    dataCadastro
                ) values(
                    'Manual',
                    #buscaUltimoRegistro.id#,
                    #buscaIdUsuarioLogado.id#,
                    getdate()
                )
            </cfquery>
        
            <script> 
                alert("Cliente cadastrado com sucesso!");
                window.location.href = 'http://127.0.0.1:8500/testes/clientes/clientes.cfm';
            </script>
        </cfif>
        
        <div style="margin-left: 50px; margin-top: 50px; margin-right: 50px;">
            <a href="/testes/clientes/clientes.cfm" class="btn btn-primary">Voltar à lista de clientes</a><br>
        </div>
        <div class="container" style="margin-top: 1%" align="center">
            <div class="col-6">
                <h1>Cadastro de cliente</h1><br>
                <form id="formulario" name="formulario" action="" method="POST">
                    <div class="form-group">
                        <label>Nome completo</label>
                        <input type="hidden" name="hdnSalvar" id="hdnSalvar" value="0"/>
                        <input class="form-control" type="text" name="txtNome" id="txtNome" placeholder="Ex: Mario Everett Gioia"> <br>
                    </div>
        
                    <div class="form-group">
                        <label>CPF</label>
                        <input class="form-control" type="text" name="txtCpf" id="txtCpf" placeholder="Insira apenas números"> <br>
                    </div>
        
                    <div class="form-group">
                        <label>RG</label>
                        <input class="form-control" type="text" name="txtRg" id="txtRg" placeholder="Insira apenas números"> <br>
                    </div>
        
                    <div class="form-group">
                        <label>E-mail</label>
                        <input class="form-control" type="text" name="txtEmail" id="txtEmail" placeholder="Ex: mario@gmail.com"> <br>
                    </div>
        
                    <div class="form-group">
                        <label>Número de celular</label>
                        <input class="form-control" type="text" name="txtNumeroCelular" id="txtNumeroCelular" placeholder="Insira apenas números"> <br>
                    </div>
        
                    <div class="form-group">
                        <label>Data de nascimento</label>
                        <input class="form-control" type="text" name="txtDataNasc" id="txtDataNasc" placeholder="Ex: 16/01/1982"> <br>
                    </div>
        
                    <div class="form-group">
                        <label>Nome do pai</label>
                        <input class="form-control" type="text" name="txtNomePai" id="txtNomePai" placeholder="Ex: Josh Campbell Clark"> <br>
                    </div>
        
                    <div class="form-group">
                        <label>Nome da mãe</label>
                        <input class="form-control" type="text" name="txtNomeMae" id="txtNomeMae" placeholder="Ex: Elsa Fonte Orueis"> <br>
                    </div>
        
                    <div class="form-group">
                        <label>CEP</label>
                        <input class="form-control" type="text" name="txtCep" id="txtCep" placeholder="Insira apenas números"> <br>
                    </div>
        
                    <div class="form-group">
                        <label>Logradouro</label>
                        <input class="form-control" type="text" name="txtLogradouro" id="txtLogradouro" placeholder=""> <br>
                    </div>
        
                    <div class="form-group">
                        <label>Cidade</label>
                        <input class="form-control" type="text" name="txtCidade" id="txtCidade" placeholder=""> <br>
                    </div>
        
                    <div class="form-group">
                        <label>Bairro</label>
                        <input class="form-control" type="text" name="txtBairro" id="txtBairro" placeholder=""> <br>
                    </div>
        
                    <div class="form-group">
                        <label>Estado</label>
                        <input class="form-control" type="text" name="txtUf" id="txtUf" placeholder=""> <br>
                    </div>
        
                    <div class="form-group">
                        <label>Número</label>
                        <input class="form-control" type="text" name="txtNumero" id="txtNumero" placeholder="Insira apenas números"> <br>
                    </div>
                    <div class="form-group text-center">
                        <button name="botaocadastro" id="botaocadastro" type="submit" class="btn btn-primary" onclick="cadastrar()">Cadastrar cliente</button>
                    </div>
                </form>
            </div>
        </div>
        <script>
            function cadastrar(){
                document.getElementById('hdnSalvar').value = '1';
                document.getElementById('formulario').submit();
            }
        
            $(document).ready(function(){
                $("#txtDataNasc").mask("00/00/0000")
            });
        
            jQuery(function ($) {
                $("input[name='txtCep']").change(function () {
                    var cep_code = $(this).val();
                    if (cep_code.length <= 0) return;
                    $.get("http://viacep.com.br/ws/" + cep_code + "/json/", { code: cep_code }, function (resultado) {
                        if (resultado.erro == 1) {
                            alert("Endereço não encontrado!")
                            $("input[name='txtCep']").val("");
                            $("input[name='txtCidade']").val("");
                            $("input[name='txtBairro']").val("");
                            $("input[name='txtLogradouro']").val("");
                            $("input[name='txtUf']").val("");
                        }
                        else {
                            $("input[name='txtCidade']").val(resultado.localidade);
                            $("input[name='txtBairro']").val(resultado.bairro);
                            $("input[name='txtLogradouro']").val(resultado.logradouro);
                            $("input[name='txtUf']").val(resultado.uf);
                        }
                    });
                });
            });
        </script>
        
        <!--- JQuery's Masks --->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.11/jquery.mask.min.js"></script>
</cfif>