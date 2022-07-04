<cfprocessingdirective pageencoding = "utf-8"/>
<cfmodule template="imports.cfm">

<style>
  .hovs:hover {
      background-color: #7ba8ec;
      border-radius: 9px;
  }

  <!--- Estilização do Dropdown --->
  .sec-center {
    position: relative;
    max-width: 100%;
    text-align: center;
    z-index: 200;
  }
  [type="checkbox"]:checked,
  [type="checkbox"]:not(:checked){
    position: absolute;
    left: -9999px;
    opacity: 0;
    pointer-events: none;
  }
  .dropdown:checked + label,
  .dropdown:not(:checked) + label{
    position: relative;
    line-height: 2;
    height: 50px;
    transition: all 200ms linear;
    border-radius: 4px;
    width: 220px;
    letter-spacing: 1px;
    display: inline-flex;
    -webkit-align-items: center;
    -moz-align-items: center;
    -ms-align-items: center;
    align-items: center;
    -webkit-justify-content: center;
    -moz-justify-content: center;
    -ms-justify-content: center;
    justify-content: center;
    -ms-flex-pack: center;
    text-align: center;
    border: none;
    background-color: #7ba8ec;
    cursor: pointer;
    color: white;
    box-shadow: 0 12px 35px 0 rgba(255,235,167,.15);
  }
  .dark-light:checked ~ .sec-center .for-dropdown{
    background-color: #102770;
    color: #ffeba7;
    box-shadow: 0 12px 35px 0 rgba(16,39,112,.25);
  }
  .dropdown:checked + label:before,
  .dropdown:not(:checked) + label:before{
    position: fixed;
    top: 0;
    left: 0;
    content: '';
    width: 100%;
    height: 100%;
    z-index: -1;
    cursor: auto;
    pointer-events: none;
  }
  .dropdown:checked + label:before{
    pointer-events: auto;
  }
  .dropdown:not(:checked) + label .uil {
    margin-left: 10px;
    transition: transform 200ms linear;
  }
  .dropdown:checked + label .uil {
    transform: rotate(180deg);
    margin-left: 10px;
    transition: transform 200ms linear;
  }
  .section-dropdown {
    position: absolute;
    padding: 5px;
    background-color: #111;
    top: 70px;
    left: 0;
    width: 100%;
    border-radius: 4px;
    display: block;
    box-shadow: 0 14px 35px 0 rgba(9,9,12,0.4);
    z-index: 2;
    opacity: 0;
    pointer-events: none;
    transform: translateY(20px);
    transition: all 200ms linear;
  }
  .dark-light:checked ~ .sec-center .section-dropdown {
    background-color: #fff;
    box-shadow: 0 14px 35px 0 rgba(9,9,12,0.15);
  }
  .dropdown:checked ~ .section-dropdown{
    opacity: 1;
    pointer-events: auto;
    transform: translateY(0);
  }
  .section-dropdown:before {
    position: absolute;
    top: -20px;
    left: 0;
    width: 100%;
    height: 20px;
    content: '';
    display: block;
    z-index: 1;
  }

  .aspecial {
    position: relative;
    color: white;
    transition: all 200ms linear;
    font-weight: 500;
    font-size: 15px;
    border-radius: 2px;
    padding: 5px 0;
    padding-left: 20px;
    padding-right: 15px;
    margin: 2px 0;
    text-align: left;
    text-decoration: none;
    display: -ms-flexbox;
    display: flex;
    -webkit-align-items: center;
    -moz-align-items: center;
    -ms-align-items: center;
    align-items: center;
    justify-content: space-between;
      -ms-flex-pack: distribute;
  }
  .dark-light:checked ~ .sec-center .section-dropdown a {
    color: #0d6efd;
  }
  .aspecial:hover {
    color: #102770;
    background-color: #0d6efd;
  }
  .dropdown-sub:checked + label,
  .dropdown-sub:not(:checked) + label{
    position: relative;
    color: #fff;
    transition: all 200ms linear;
    border-radius: 2px;
    padding: 5px 0;
    padding-left: 20px;
    padding-right: 15px;
    text-align: left;
    text-decoration: none;
    display: -ms-flexbox;
    display: flex;
    -webkit-align-items: center;
    -moz-align-items: center;
    -ms-align-items: center;
    align-items: center;
    justify-content: space-between;
      -ms-flex-pack: distribute;
      cursor: pointer;
  }
  .dropdown-sub:checked + label .uil,
  .dropdown-sub:not(:checked) + label .uil{
  }
  .dropdown-sub:not(:checked) + label .uil {
    transition: transform 200ms linear;
  }
  .dropdown-sub:checked + label .uil {
    transform: rotate(135deg);
    transition: transform 200ms linear;
  }
  .dropdown-sub:checked + label:hover,
  .dropdown-sub:not(:checked) + label:hover{
    color: #102770;
    background-color: #0d6efd;
  }
</style>

<cfset usuarioLogado = getAuthUser()>

<cfif usuarioLogado neq "">
  <cfquery name="validaLogin" datasource="dataGioia">
    update users set statusLogin = 1 where usuario = '#usuarioLogado#'
  </cfquery>
</cfif>

<cfquery name="contaLogados" datasource="dataGioia">
  select COUNT(*) as 'qtd' from users where statusLogin = 1
</cfquery>

<nav class="navbar navbar-expand-lg bg-light" style="margin-top: 15px;">
    <div class="container-fluid">
      <a class="navbar-brand hovs" href="http://127.0.0.1:8500/testes/clientes/clientes.cfm">&nbspInício&nbsp</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
          <li class="nav-item hovs">
            <a class="nav-link active" aria-current="page" href="http://127.0.0.1:8500/testes/clientes/criarCliente.cfm">Cadastro de novo cliente (Manual)</a>
          </li>
          <li class="nav-item hovs">
            <a class="nav-link active" aria-current="page" href="http://127.0.0.1:8500/testes/clientes/criarClienteXls.cfm">Cadastro de novo(s) cliente(s) (Excel)</a>
          </li>
          <cfif usuarioLogado neq "">
            <li class="nav-item">
              <a class="nav-link active" aria-current="page">Olá, <b><cfoutput>#usuarioLogado#</cfoutput></b></a>
            </li>
            <!--- Gambiarra --->
            <li class="nav-item">
              <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
            </li>
            <li class="nav-item">
              <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
            </li>
            <li class="nav-item">
              <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
            </li>
            <li class="nav-item">
              <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
            </li>
            <li class="nav-item">
              <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
            </li>
            <li class="nav-item">
              <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
            </li>
            <li class="nav-item">
              <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
            </li>
            <li class="nav-item">
              <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
            </li>
            <!--- Gambiarra --->
            <li class="nav-item hovs">
              <a class="nav-link active" href="http://127.0.0.1:8500/testes/autenticacao/usuario.cfm" aria-current="page">Minha Conta</a>
            </li>
            <li class="nav-item hovs">
                <a class="nav-link active" aria-current="page" onclick="desconectar()">Desconectar</a>
            </li>
            <li class="nav-item">
              <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
            </li>
            <li class="nav-item">
              <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
            </li>
            <li class="nav-item">
              Usuário(s) conectado(s): <cfoutput>#contaLogados.qtd#</cfoutput>
            </li>
          <cfelse>
            <!--- Gambiarra --->
            <li class="nav-item">
              <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
            </li>
            <li class="nav-item">
              <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
            </li>
            <li class="nav-item">
              <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
            </li>
            <li class="nav-item">
              <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
            </li>
            <li class="nav-item">
              <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
            </li>
            <li class="nav-item">
              <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
            </li>
            <li class="nav-item">
              <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
            </li>
            <li class="nav-item">
              <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
            </li>
            <li class="nav-item">
              <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
            </li>
            <li class="nav-item">
              <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
            </li>
            <!--- Gambiarra --->
            <li>
              <div class="sec-center"> 	
                <input class="dropdown" type="checkbox" id="dropdown" name="dropdown"/>
                <label class="for-dropdown" for="dropdown">Autenticar-se<i class="uil uil-arrow-down" style="color:black;"></i></label>
                <div class="section-dropdown"> 
                    <a class="aspecial" href="/testes/autenticacao/cadastro.cfm">Cadastrar-se<i class="uil uil-arrow-right"></i></a>
                    <a class="aspecial" href="/testes/autenticacao/login.cfm">Fazer login<i class="uil uil-arrow-right"></i></a>
                </div>
              </div>
              <li class="nav-item">
                <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
              </li>
              <li class="nav-item">
                <a style="color: white;" class="nav-link active" aria-current="page">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</a>
              </li>
              <li class="nav-item">
                Usuário(s) conectados(s): <cfoutput>#contaLogados.qtd#</cfoutput>
              </li>
            </li>
          </cfif>
        </ul>
      </div>
    </div>
  </nav>
  <hr class="my-4">
  <script>
    function desconectar(){
      swal({
            title: "Você quer desconectar-se?",
            text: "Estaremos te esperando quando decidir voltar.  ",
            icon: "warning",
            buttons: true,
            buttons: ["Não, eu desisti.", "Sim, depois eu volto."],
            dangerMode: true,
        })
            .then((willDelete) => {
                if (willDelete) {
                  $.ajax({
                    url: 'http://127.0.0.1:8500/testes/autenticacao/ajaxDesconectaUser.cfm',
                    async: false,
                    data : {"usuario": '<cfoutput>#usuarioLogado#</cfoutput>'},
                    cache: false,
                    contentType: "application/json; charset=utf-8",
                    success: function(retorno){
                      swal({
                        title: "Pronto!",
                        text: "Você foi desconectado.",
                        icon: "success",
                        buttons: false
                              });
                      setTimeout(function () {
                        window.location.href = 'http://127.0.0.1:8500/testes/clientes/clientes.cfm';
                          }, 2000);
                    }
                  });
                } else {
                    swal("Ok, você ainda está logado");
                }
            });
  }
  </script>