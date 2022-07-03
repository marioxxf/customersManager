<cfprocessingdirective pageencoding = "utf-8"/>
<cfmodule template="../imports.cfm">
<cfmodule template="../topmenu.cfm">

<cfif isDefined('form.hdnLogar') and '#form.hdnLogar#' eq 1>
    <cfquery name="buscaUsuario" datasource="dataGioia">
        select * from users where usuario = '#form.txtUsuario#'
    </cfquery>

    <cfif buscaUsuario.recordCount neq 0>
        <cfif buscaUsuario.senha eq hash("#form.txtSenha#", "SHA-256", "UTF-8")>
            <cflogin> 
                <cfloginuser name="#form.txtUsuario#" password="#form.txtSenha#" roles = "admin"> 
            </cflogin>
            <script>
                swal({
              title: "Login realizado com êxito!",
              text: "Você está conectado.",
              icon: "success",
              buttons: false
                    });
            setTimeout(function () {
              window.location.href = 'http://127.0.0.1:8500/testes/clientes/clientes.cfm';
                }, 2000);
            </script>
            <cfelse>
                <script>
                    swal({
                        title: "Usuário e/ou senha está(ão) incorreto(s)!",
                        text: "Tente novamente ou procure um administrador para recuperar sua senha.",
                        icon: "error",
                        buttons: false
                    });
                    setTimeout(function () {
                        window.location.href = 'http://127.0.0.1:8500/testes/autenticacao/login.cfm';
                    }, 5000);
                </script>
        </cfif>
    <cfelse>
        <script>
            swal({
                title: "Usuário e/ou senha está(ão) incorreto(s)!",
                text: "Tente novamente ou procure um administrador para recuperar sua senha.",
                icon: "error",
                buttons: false
            });
            setTimeout(function () {
                window.location.href = 'http://127.0.0.1:8500/testes/autenticacao/login.cfm';
            }, 5000);
        </script>
    </cfif>
</cfif>
<div class="container" style="margin-top: 1%" align="center">
    <div class="col-6">
        <h1>Logar-se</h1><br>
        <form id="formulario" name="formulario" action="" method="POST">
            <input type="hidden" name="hdnLogar" id="hdnLogar" value="0">
            <div class="form-group">
                <label>Usuário</label>
                <input class="form-control" type="text" name="txtUsuario" id="txtUsuario"><br>
            </div>
            <div class="form-group">
                <label>Senha</label>
                <input class="form-control" type="password" name="txtSenha" id="txtSenha"><br>
            </div>
            <div class="form-group text-center">
                <button name="btnLogin" id="btnLogin" type="submit" class="btn btn-primary" onclick="logar()">Fazer login</button>
            </div>
        </form>
    </div>
</div>
<script>
    function logar(){
        document.getElementById('hdnLogar').value = '1';
        document.getElementById('formulario').submit();
    }
</script>