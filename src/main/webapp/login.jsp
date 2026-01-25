<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="pt-BR">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Cão Q-Late - Login</title>
	    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600&family=Inter:wght@400;500&display=swap" rel="stylesheet">
	    <link rel="stylesheet" href="./static/css/login.css">
	</head>
	<body>
	    <div class="login-container">
	        <div class="login-image">
	            <h1>Cão Q-Late</h1>
	            <p>Sistema de Gerenciamento do Petshop</p>
	        </div>
	
	        <div class="login-form">
	            <div class="form-header">
	                <h2>Bem-vindo!</h2>
	                <p>Faça login para gerenciar seu petshop</p>
	            </div>
	
	            <div id="alertBox" class="alert"></div>
	
	            <form id="loginForm" action="controller" method="post" novalidate>
	                <div class="form-group">
	                    <label for="login">Login</label>
	                    <div class="input-wrapper">
	                        <input type="text" id="login" name="login" required>
	                        <span class="input-icon">👤</span>
	                    </div>
	                    <div class="error-message" id="loginError">
	                        ⚠️ <span>Por favor, insira seu login</span>
	                    </div>
	                </div>
	
	                <div class="form-group">
	                    <label for="password">Senha</label>
	                    <div class="input-wrapper">
	                        <input type="password" id="password" name="password" required>
	                        <span class="input-icon">🔒</span>
	                    </div>
	                    <div class="error-message" id="passwordError">
	                        ⚠️ <span>Por favor, insira sua senha</span>
	                    </div>
	                </div>
	
	                <input type="hidden" name="handler" value="Login">
	                <input type="hidden" id="hashedPassword" name="hashedPassword">
	                
	                <button type="submit" class="submit-btn">Entrar</button>
	            </form>
	        </div>
	    </div>
	
		<script type="module" src="./static/js/login.js"></script>
	</body>
</html>