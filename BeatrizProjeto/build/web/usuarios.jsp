<%-- 
    Document   : usuarios
    Created on : 09/12/2020, 16:22:11
    Author     : Estudo
--%>
<%@page import="config.Conexao"%>
<%@page import="java.sql.*"%>
<%@page import="config.Conexao.*"%>
<%@page import="com.mysql.jdbc.Driver"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="estilo.css" rel="stylesheet">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>


<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
integrity="sha384-
DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
crossorigin="anonymous"></script>
<script
src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.m
in.js" integrity="sha384-
9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
crossorigin="anonymous"></script>
<script
src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.
min.js" integrity="sha384-
w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s"
crossorigin="anonymous"></script>

        <title>Usuários</title>
    </head>
    <body>
        <nav class="main-navigation">
        <div class="navbar-header animated fadeInUp">
            <a class="navbar-brand" href="#"><h1>Usuários</h1></a>
        </div>
        <ul class="nav-list">
            <li class="nav-list-item">
                <a href="#" class="nav-link">Home</a>
            </li>
            <li class="nav-list-item">
                <a href="#" class="nav-link"></a>
            </li>
            
            <li class="nav-list-item">
                <a href="#" class="nav-link"> Olá, <% 
            String nome = (String) session.getAttribute("nomeUsuario");
            out.println(nome);
            
            if(nome == null){
                response.sendRedirect("index.jsp");
            }
        %></a>
            </li>
            <li class="nav-list-item">
                <a  href="logout.jsp" class="nav-link">Sair</a>
            </li>
        </ul>

    </nav>
            <div class="btn-toolbar">
                <!--<a type="button" class="btn" href="usuarios.jsp?funcao=novo">Novo Usuário</a>-->
               
   <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#ExemploModalCentralizado">
  Novo Usuário
</button>
    <form class="form-inline my-2 my-lg-0" method="post">
 <input class="form-control mr-sm-2" type="search" name="txtbuscar" placeholder="Digite um nome" aria-label="Search">
 <button class="btn btn-outline-info my-2 my-sm-0" name="btn_buscar" type="submit">Buscar</button>
 </form>

</div> 
<div class="well">
    <table class="table">
      <thead>
        <tr>
          <th>id</th>
          <th>Nome</th>
          <th>Email</th>
          <th>Senha</th>
          <th>Nível</th>
          <th style="width: 36px;"></th>
        </tr>
      </thead>
      <tbody>
          <% 
          Statement st = null;
          ResultSet rs = null;
          String id_usuario = "";
          String nome_usuario = "";
          String email_usuario = "";
          String senha_usuario = "";
          String nivel_usuario = "";
          
          try{
              st = new Conexao() .conectar() .createStatement();
              if(request.getParameter("btn_buscar") != null){
                  String busca = '%' + request.getParameter("txtbuscar") + '%';
                  rs = st.executeQuery("SELECT * FROM usuarios WHERE nome LIKE '" + busca + "' ");
              }
              else{
              rs = st.executeQuery("SELECT * FROM usuarios");
              }
              while (rs.next()){ %>
                <tr>
          <td><%= rs.getString(1)%></td>
          <td><%= rs.getString(2)%></td>
          <td><%= rs.getString(3)%></td>
          <td><%= rs.getString(4)%></td>
          <td><%= rs.getString(5)%></td>
          <td>
              <a href="usuarios.jsp?funcao=excluir&id=<%= rs.getString(1)%>"><i class="icon-remove"></i></i></a>
              
              <a href="usuarios.jsp?funcao=atualizar&id=<%= rs.getString(1)%>"><i class="icon-pencil"></i></i></a>
          </td>
        </tr>  
        <%
              }
          } catch (Exception e){
              out.println(e);
          }
          %>
          
          <%
          if(request.getParameter("funcao") != null && 
                  request.getParameter("funcao") .equals("excluir")){
              //out.print("<script>alert('Função Excluir!');</script>");
              String id = request.getParameter("id");
              try{
                  st = new Conexao() .conectar() .createStatement();
                  st.executeUpdate("DELETE FROM usuarios WHERE id = '" + id + "' ");
                  response.sendRedirect("usuarios.jsp");
              }
              catch(Exception e) {
                  out.println(e);
              }
          }
          %>
          
          
          
        
       
      </tbody>
    </table>
</div>
<div class="pagination">
    <ul>
        <!-- <li><a href="#">Prev</a></li>
        <li><a href="#">1</a></li>
        <li><a href="#">2</a></li>
        <li><a href="#">3</a></li>
        <li><a href="#">4</a></li>
        <li><a href="#">Next</a></li> -->
    </ul>
</div>
<div class="modal small hide fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="myModalLabel">Delete Confirmation</h3>
    </div>
    <div class="modal-body">
        <p class="error-text">Are you sure you want to delete the user?</p>
    </div>
    <div class="modal-footer">
        <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
        <button class="btn btn-danger" data-dismiss="modal">Delete</button>
    </div>
</div>
        
        
        
    </body>
</html>
<!-- Botão para acionar modal -->


<!-- Modal -->
<div class="modal fade" id="ExemploModalCentralizado" tabindex="-1" role="dialog" aria-labelledby="TituloModalCentralizado" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
          
          <%
              String titulo = null;
              String id_novo = "";
              String name_novo = "";
              String email_novo = "";
              String senha_novo = "";
              String nivel_novo = "";
              
             if(request.getParameter("funcao") != null && 
             request.getParameter("funcao") .equals("atualizar")){
                 //out.println("<script>$('#ExemploModalCentralizado').modal('show');</script>");
             id_novo = request.getParameter("id"); 
             String usuarioSessao = "";
             titulo = "Alterar informações do Usuário";
             try{
               st = new Conexao() .conectar() .createStatement();
               rs = st.executeQuery("SELECT * FROM usuarios WHERE " + "id = '" + id_novo + "' ");
               while(rs.next()){
                   name_novo = rs.getString(2);
                   email_novo = rs.getString(3);
                   senha_novo = rs.getString(4);
                   nivel_novo = rs.getString(5);
                   usuarioSessao = rs.getString(2);
                   
               }
             
             }catch(Exception e){
             }
             } else {
                 titulo = "Inserir novo Usuário";
             }
            %>
            
           
            
            
        <h5 class="modal-title" id="TituloModalCentralizado"> <%=titulo%> </h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Fechar">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      
                        <form>
                            <div class="modal-body">
                         
                            <input type="text" name="nome" class="form-control" placeholder="Nome *" value="<%=name_novo %>" />
                            <input type="text" name="email" class="form-control" placeholder="Email *" value="<%=email_novo %>" />
                            <input type="password" name="senha" class="form-control" placeholder="Senha *" value="<%=senha_novo %>" />
                            <input type="text" name="nivel" class="form-control" placeholder="Nível *" value="<%=nivel_novo %>" >
                            
                             
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Fechar</button>
        <button type="submit" name="btn-concluir" class="btn btn-primary"><%=titulo %></button>
        </form>
      </div>
    </div>
  </div>
</div>



<% 
    if(request.getParameter("btn-concluir") != null){
        String name = request.getParameter("nome");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String nivel = request.getParameter("nivel");
        
        try {
            st = new Conexao().conectar() .createStatement();
            //executeQuery para pesquisar um valor no bd
            rs = st.executeQuery("SELECT * FROM usuarios WHERE email = '" + email + "' ");
            while(rs.next()){
                rs.getRow(); //recupera os registros achados
                if(rs.getRow() > 0){
                    out.print("<script>alert('Usuário já cadastrado!');</script>");
                    return; //mostra a mensagem e sai do método
                }
            }
            //fim da consulta
            st.executeUpdate("INSERT INTO usuarios (nome, email, senha, nivel) " 
                            + "VALUES ('" + name + "', '" + email + "', '" + senha + "', '" + nivel + "');");
            response.sendRedirect("usuarios.jsp");
        } catch(Exception e){
            out.println(e);
        }
        
        
        
        
    }

%>

