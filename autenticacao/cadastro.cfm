<cfprocessingdirective pageencoding = "utf-8"/>
<cfmodule template="../imports.cfm">
<cfmodule template="../topmenu.cfm">

<cfif isDefined('form.hdnSalvar') and '#form.hdnSalvar#' eq 1>
    
  <cfset senhaInserida = hash("#form.txtSenha#", "SHA-256", "UTF-8")>
    <cfquery datasource="dataGioia">
        insert into users(
            usuario,
            senha,
            dataCriacao
            ) values(
            '#form.txtUsuario#',
            '#senhaInserida#',
            getdate()
        );
    </cfquery>

    <cflogin> 
        <cfloginuser name="#form.txtUsuario#" password="#senhaInserida#" roles = "admin"> 
    </cflogin>
    <script> 
        alert("Conta registrada com sucesso!");
        window.location.href = 'http://127.0.0.1:8500/testes/autenticacao/usuario.cfm';
    </script>
</cfif>

<div style="margin-left: 50px; margin-top: 50px; margin-right: 50px;">
    <a href="/testes/clientes/clientes.cfm" class="btn btn-primary">Voltar à lista de clientes</a><br>
</div>
<div class="container" style="margin-top: 1%" align="center">
    <div class="col-6">
        <h1>Cadastro de usuário</h1><br>
        <form id="formulario" name="formulario" action="" method="POST">
            <div class="form-group">
                <label>Usuário</label>
                <input type="hidden" name="hdnSalvar" id="hdnSalvar" value="0"/>
                <input class="form-control" type="text" name="txtUsuario" id="txtUsuario"> <br>
            </div>

            <div class="form-group">
                <label>Senha</label>
                <input class="form-control" type="password" name="txtSenha" id="txtSenha"> <br>
            </div>
            <div class="form-group text-center">
                <button name="btnCadastro" id="btnCadastro" type="submit" class="btn btn-primary" onclick="cadastrar()">Criar conta</button>
            </div>
        </form>
    </div>
</div>
<script>
    function cadastrar(){
        document.getElementById('hdnSalvar').value = '1';
        document.getElementById('formulario').submit();
    }
</script>