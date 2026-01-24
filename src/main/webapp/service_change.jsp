<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   
<!DOCTYPE html>
<html lang="pt-BR">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Cão Q-Late - Alterar Preço</title>
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
	            <h2>✏️ Alterar Preço do Serviço</h2>
	            <a href="service_home.jsp" class="back-btn">← Voltar</a>
	        </div>
	
	        <div class="form-container">
	            <div class="service-info-card">
	                <h3>✂️ ${requestScope.service.name}</h3>
	                <div>ID: #${requestScope.service.id}</div>
	                <div class="current-price">
	                    Preço Atual: R$ <fmt:formatNumber value="${requestScope.service.price}" pattern="#,##0.00"/>
	                </div>
	            </div>
	
	            <div id="alertBox" class="alert"></div>
	
	            <form id="changeForm" action="controller" method="post" novalidate>
	                <input type="hidden" name="id" value="${requestScope.service.id}">
	                <input type="hidden" name="name" value="${requestScope.service.name}">
	
	                <div class="form-group">
	                    <label>ID do Serviço</label>
	                    <div class="input-wrapper">
	                        <input type="text" value="#${requestScope.service.id}" disabled>
	                    </div>
	                </div>
	
	                <div class="form-group">
	                    <label>Nome do Serviço</label>
	                    <div class="input-wrapper">
	                        <input type="text" value="${requestScope.service.name}" disabled>
	                    </div>
	                </div>
	
	                <div class="form-group">
	                    <label for="price">Novo Preço <span class="required">*</span></label>
	                    <div class="input-wrapper">
	                        <span class="currency-symbol">R$</span>
	                        <input type="text" id="price" name="price" class="currency-input" 
	                               value="<fmt:formatNumber value="${requestScope.service.price}" pattern="0.00"/>" required>
	                    </div>
	                    <div class="error-message" id="priceError">
	                        ⚠️ <span>Preço deve ser maior que R$ 0,00</span>
	                    </div>
	                    <div class="helper-text">Use vírgula para centavos (ex: 50,00)</div>
	                </div>
	
	                <input type="hidden" name="handler" value="ChangeService">
	
	                <div class="form-actions">
	                    <button type="submit" class="submit-btn">✅ Alterar Preço</button>
	                    <a href="service_home.jsp" class="cancel-btn">❌ Cancelar</a>
	                </div>
	            </form>
	        </div>
	    </div>
	
		<script type="module" src="./static/js/service_change.js"></script>
	</body>
</html>