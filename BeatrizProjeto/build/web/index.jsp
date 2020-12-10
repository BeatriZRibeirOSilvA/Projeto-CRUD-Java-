<%-- 
    Document   : index
    Created on : 08/12/2020, 18:36:35
    Author     : Estudo
--%>

<%@page import="java.sql.*"%>
<%@page import="config.Conexao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="newcss.css" rel="stylesheet">
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        
        <% 
       // Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        %>
        
        <title>Login</title>
    </head>
    <body>
        <div class="container login-container">
            <div class="row">
                <div class="col-md-6 login-form-1">
                    <h3>Faça seu login</h3>
                    <form>
                        <div class="form-group">
                            <input  type="text" name="email" class="form-control" placeholder="Email" value="" />
                        </div>
                        <div class="form-group">
                            <input type="password" name="senha" class="form-control" placeholder="Password" value="" />
                        </div>
                        <div class="form-group">
                            <input type="submit" class="btnSubmit" value="Entrar" />
                        </div>
                        <div class="form-group">
                            <a href="#" class="ForgetPwd">Esqueceu a senha?</a>
                        </div>
                        <p align="center" >
                    <% 
                       String user = request.getParameter("email");
                       String pass = request.getParameter("senha");
                       String nomeUsuario = "";
                       String usuario = "";
                       String senha = "";
                       
                       int i = 0;
                       
                       try {
                       //Class.forName("com.mysql.jdbc.Driver");
                       //con = DriverManager.getConnection("jdbc:mysql://localhost/javaweb?user=root&password=");
                       st = new Conexao() .conectar() .createStatement();
                       rs = st.executeQuery("SELECT * FROM usuarios WHERE email = '"+user+"' and senha = '"+pass+"'");
                       while(rs.next()){
                           //out.println(rs.getString(2));
                         usuario = rs.getString(3);
                         senha = rs.getString(4);
                         nomeUsuario = rs.getString(2);
                         rs.last();
                         i = rs.getRow();
                       }
                       } catch(Exception e){
                           out.println(e);
                       }
                       
                       if((user == "") || (pass == "")){
                           out.println("Preencha os dados!!!!");
                       } else {
                           if (i>0){
                            //out.println("LOGIN REALIZADO COM SUCESSO!!");
                            session.setAttribute("nomeUsuario", nomeUsuario);
                            response.sendRedirect("usuarios.jsp");
                           }else{
                            out.println("DADOS INCORRETOS!");
                       }
                       } 
                    %>
                </p>
                    </form>
                </div>
                <div class="col-md-6 login-form-2">
                    <h3>Não tem cadastro?</h3>
                    <form>
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="Nome *" value="" />
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" placeholder="Email *" value="" />
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control" placeholder="Senha *" value="" />
                        </div>
                        <div class="form-group">
                            <input type="submit" class="btnSubmit" value="Cadastrar" />
                        </div>
                        <div class="form-group">

                           <!-- <a href="#" class="ForgetPwd" value="Login">Forget Password?</a>-->
                        </div>
                    </form>
                </div>
                
            </div>
        </div>
    </body>
</html>
