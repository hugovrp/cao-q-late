<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
   
<!DOCTYPE html>
<html lang="pt-BR">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Cão Q-Late - Cadastrar Cliente</title>
	    <link rel="stylesheet" href="./static/css/client.css">
	    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
	</head>
	
	<body>
	    <div class="sidebar">
	        <div class="sidebar-header">
	            <h1>🐕 Cão Q-Late</h1>
	        </div>
	
	        <ul>
	            <li><a href="index.jsp">📊 <span>Dashboard</span></a></li>
	            <li><a href="client_home.jsp" class="active">👥 <span>Clientes</span></a></li>
	            <li><a href="dog_home.jsp">🐶 <span>Cães</span></a></li>
	            <li><a href="service_home.jsp">✂️ <span>Serviços</span></a></li>
	            <li><a href="scheduling_home.jsp">📅 <span>Agendamentos</span></a></li>
	            <li><a href="service_provision_home.jsp">🎯 <span>Prestar Serviços</span></a></li>
	        </ul>
	
	        <div class="sidebar-footer">
	            <c:if test="${sessionScope.status == true}">
	                <a href="controller?handler=Logout" class="logout-btn">
	                    🚪 <span>Sair</span>
	                </a>
	            </c:if>
	        </div>
	    </div>
	
	    <div class="main-content">
	        <div class="top-bar">
	            <h2>➕ Cadastrar Cliente</h2>
	            <a href="client_home.jsp" class="back-btn">← Voltar</a>
	        </div>
	
	        <div class="form-container">
	            <div id="alertBox" class="alert" 
				     data-success="${not empty param.success}" 
				     data-error="${not empty param.error}">
				</div>
	
	            <form id="clientForm" action="controller" method="post" novalidate>
	                <div class="form-group">
	                    <label for="cpf">CPF <span class="required">*</span></label>
	                    <div class="input-wrapper">
	                        <input type="text" id="cpf" name="cpf" maxlength="14" required>
	                    </div>
	                    <div class="error-message" id="cpfError">
	                        ⚠️ <span>CPF inválido</span>
	                    </div>
	                    <div class="helper-text">Formato: 000.000.000-00</div>
	                </div>
	
	                <div class="form-group">
	                    <label for="name">Nome Completo <span class="required">*</span></label>
	                    <div class="input-wrapper">
	                        <input type="text" id="name" name="name" required>
	                    </div>
	                    <div class="error-message" id="nameError">
	                        ⚠️ <span>Nome deve ter pelo menos 3 caracteres</span>
	                    </div>
	                </div>
	
	                <div class="form-group">
	                    <label for="email">E-mail <span class="required">*</span></label>
	                    <div class="input-wrapper">
	                        <input type="email" id="email" name="email" required>
	                    </div>
	                    <div class="error-message" id="emailError">
	                        ⚠️ <span>E-mail inválido</span>
	                    </div>
	                </div>
	
	                <div class="form-group">
	                    <label for="telephone">Telefone <span class="required">*</span></label>
	                    <div class="input-wrapper">
	                        <input type="text" id="telephone" name="telephone" maxlength="15" required>
	                    </div>
	                    <div class="error-message" id="telephoneError">
	                        ⚠️ <span>Telefone inválido</span>
	                    </div>
	                    <div class="helper-text">Formato: (00) 00000-0000</div>
	                </div>
	
	                <div class="form-group">
	                    <label for="birth_date">Data de Nascimento <span class="required">*</span></label>
	                    <div class="input-wrapper">
	                        <input type="text" id="birth_date" name="birth_date" maxlength="10" required>
	                    </div>
	                    <div class="error-message" id="birthDateError">
	                        ⚠️ <span>Data inválida</span>
	                    </div>
	                    <div class="helper-text">Formato: DD/MM/AAAA</div>
	                </div>
	
	                <input type="hidden" name="handler" value="RegisterClient">
	
	                <div class="form-actions">
	                    <button type="submit" class="submit-btn">✅ Cadastrar Cliente</button>
	                    <a href="client_home.jsp" class="cancel-btn">❌ Cancelar</a>
	                </div>
	            </form>
	        </div>
	    </div>
	
		<script type="module" src="./static/js/client_register.js"></script>
	</body>
</html>