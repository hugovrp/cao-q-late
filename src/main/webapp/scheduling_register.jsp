<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-BR">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Cão Q-Late - Novo Agendamento</title>
	    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
	   	<link rel="stylesheet" href="./static/css/global.css">
	    <link rel="stylesheet" href="./static/css/scheduling.css">
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
	            <li><a href="service_home.jsp">✂️ <span>Serviços</span></a></li>
	            <li><a href="scheduling_home.jsp" class="active">📅 <span>Agendamentos</span></a></li>
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
	            <h2>➕ Novo Agendamento</h2>
	            <a href="scheduling_home.jsp" class="back-btn">← Voltar</a>
	        </div>
	
	        <div class="form-container">
	            <div id="alertBox" class="alert" 
				     data-success="${not empty param.success}" 
				     data-error="${not empty param.error}">
				</div>
	
	            <form id="schedulingForm" action="controller" method="post" novalidate>
	                <div class="form-group">
	                    <label for="client_id">ID do Cliente <span class="required">*</span></label>
	                    <div class="input-wrapper">
	                        <input type="number" id="client_id" name="client_id" min="1" required>
	                    </div>
	                    <div class="error-message" id="clientError">
	                        ⚠️ <span>ID do cliente deve ser um número válido</span>
	                    </div>
	                </div>
	
	                <div class="form-group">
	                    <label for="dog_id">ID do Cão <span class="required">*</span></label>
	                    <div class="input-wrapper">
	                        <input type="number" id="dog_id" name="dog_id" min="1" required>
	                    </div>
	                    <div class="error-message" id="dogError">
	                        ⚠️ <span>ID do cão deve ser um número válido</span>
	                    </div>
	                    <div class="helper-text">O cão deve pertencer ao cliente informado</div>
	                </div>
	
	                <div class="form-group">
	                    <label for="date">Data do Agendamento <span class="required">*</span></label>
	                    <div class="input-wrapper">
	                        <input type="date" id="date" name="date" required>
	                    </div>
	                    <div class="error-message" id="dateError">
	                        ⚠️ <span>Data inválida</span>
	                    </div>
	                    <div class="helper-text">A data deve ser igual ou posterior a hoje</div>
	                </div>
	
	                <div class="form-group-register">
	                    <label>Serviços <span class="required">*</span></label>
	                    <div class="services-grid">
	                        <c:forEach var="s" items="${services}">
	                            <div class="service-checkbox">
	                                <input type="checkbox" id="service_${s.id}" name="services_id" value="${s.id}">
	                                <label for="service_${s.id}" class="service-label">
	                                    <span class="service-name">${s.name}</span>
	                                    <span class="service-price">R$ <fmt:formatNumber value="${s.price}" pattern="#,##0.00"/></span>
	                                </label>
	                            </div>
	                        </c:forEach>
	                    </div>
	                    <div class="error-message" id="servicesError">
	                        ⚠️ <span>Selecione pelo menos um serviço</span>
	                    </div>
	                </div>
	
	                <input type="hidden" name="handler" value="RegisterScheduling">
	
	                <div class="form-actions">
	                    <button type="submit" class="submit-btn">✅ Confirmar Agendamento</button>
	                    <a href="scheduling_home.jsp" class="cancel-btn-register">❌ Cancelar</a>
	                </div>
	            </form>
	        </div>
	    </div>
	
		<script type="module" src="./static/js/scheduling_register.js"></script>
	</body>
</html>