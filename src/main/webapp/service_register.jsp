<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-BR">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Cão Q-Late - Cadastrar Serviço</title>
	    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
	    <link rel="stylesheet" href="./static/css/global.css">
		<link rel="stylesheet" href="./static/css/service.css">
	</head>
	
	<body>
	    <div class="sidebar">
	        <div class="sidebar-header">
	            <h1>🐕 Cão Q-Late</h1>
	        </div>
	
	        <ul>
	            <li><a href="index.jsp">📊 <span>Dashboard</span></a></li>
	            <li><a href="client_home.jsp">👥 <span>Clientes</span></a></li>
	            <li><a href="dog_home.jsp">🐶 <span>Cães</span></a></li>
	            <li><a href="service_home.jsp" class="active">✂️ <span>Serviços</span></a></li>
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
	            <h2>➕ Cadastrar Serviço</h2>
	            <a href="service_home.jsp" class="back-btn">← Voltar</a>
	        </div>
	
	        <div class="form-container">
	            <div id="alertBox" class="alert" 
				     data-success="${not empty param.success}" 
				     data-error="${not empty param.error}">
				</div>
	
	            <form id="serviceForm" action="controller" method="post" novalidate>
	                <div class="form-group">
	                    <label for="name">Nome do Serviço <span class="required">*</span></label>
	                    <div class="input-wrapper">
	                        <input type="text" id="name" name="name" required>
	                    </div>
	                    <div class="error-message" id="nameError">
	                        ⚠️ <span>Nome deve ter pelo menos 3 caracteres</span>
	                    </div>
	                </div>
	
	                <div class="form-group">
	                    <label for="price">Preço <span class="required">*</span></label>
	                    <div class="input-wrapper">
	                        <span class="currency-symbol">R$</span>
	                        <input type="text" id="price" name="price" class="currency-input" required>
	                    </div>
	                    <div class="error-message" id="priceError">
	                        ⚠️ <span>Preço deve ser maior que R$ 0,00</span>
	                    </div>
	                    <div class="helper-text">Use vírgula para centavos (ex: 50,00)</div>
	                </div>
	
	                <input type="hidden" name="handler" value="RegisterService">
	
	                <div class="form-actions">
	                    <button type="submit" class="submit-btn">✅ Cadastrar Serviço</button>
	                    <a href="service_home.jsp" class="cancel-btn">❌ Cancelar</a>
	                </div>
	            </form>
	        </div>
	    </div>
	
		<script type="module" src="./static/js/service_search.js"></script>
	</body>
</html>