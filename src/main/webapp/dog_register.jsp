<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
   
<!DOCTYPE html>
<html lang="pt-BR">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Cão Q-Late - Cadastrar Cão</title>
	    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
	    <link rel="stylesheet" href="./static/css/global.css">
		<link rel="stylesheet" href="./static/css/dog.css">
	</head>
	
	<body>
	    <div class="sidebar">
	        <div class="sidebar-header">
	            <h1>🐕 Cão Q-Late</h1>
	        </div>
	
	        <ul>
	            <li><a href="index.jsp">📊 <span>Dashboard</span></a></li>
	            <li><a href="client_home.jsp">👥 <span>Clientes</span></a></li>
	            <li><a href="dog_home.jsp" class="active">🐶 <span>Cães</span></a></li>
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
	            <h2>➕ Cadastrar Cão</h2>
	            <a href="dog_home.jsp" class="back-btn">← Voltar</a>
	        </div>
	
	        <div class="form-container">
	            <div id="alertBox" class="alert" 
				     data-success="${not empty param.success}" 
				     data-error="${not empty param.error}">
				</div>
	
	            <form id="dogForm" action="controller" method="post" novalidate>
	                <div class="form-group">
	                    <label for="name">Nome do Cão <span class="required">*</span></label>
	                    <div class="input-wrapper">
	                        <input type="text" id="name" name="name" required>
	                    </div>
	                    <div class="error-message" id="nameError">
	                        ⚠️ <span>Nome deve ter pelo menos 2 caracteres</span>
	                    </div>
	                </div>
	
	                <div class="form-group">
	                    <label for="breed">Raça <span class="required">*</span></label>
	                    <div class="input-wrapper">
	                        <input type="text" id="breed" name="breed" required>
	                    </div>
	                    <div class="error-message" id="breedError">
	                        ⚠️ <span>Raça deve ter pelo menos 2 caracteres</span>
	                    </div>
	                </div>
	
	                <div class="form-group">
	                    <label>Porte <span class="required">*</span></label>
	                    <div class="radio-group">
	                        <div class="radio-option">
	                            <input type="radio" id="small" name="size" value="SMALL" required>
	                            <label for="small" class="radio-label">🐕 Pequeno</label>
	                        </div>
	                        <div class="radio-option">
	                            <input type="radio" id="medium" name="size" value="MEDIUM">
	                            <label for="medium" class="radio-label">🐕 Médio</label>
	                        </div>
	                        <div class="radio-option">
	                            <input type="radio" id="large" name="size" value="LARGE">
	                            <label for="large" class="radio-label">🐕 Grande</label>
	                        </div>
	                    </div>
	                    <div class="error-message" id="sizeError">
	                        ⚠️ <span>Selecione o porte do cão</span>
	                    </div>
	                </div>
	
	                <div class="form-group">
	                    <label for="owner_id">ID do Dono <span class="required">*</span></label>
	                    <div class="input-wrapper">
	                        <input type="number" id="owner_id" name="owner_id" min="1" required>
	                    </div>
	                    <div class="error-message" id="ownerError">
	                        ⚠️ <span>ID do dono deve ser um número válido</span>
	                    </div>
	                </div>
	
	                <input type="hidden" name="handler" value="RegisterDog">
	
	                <div class="form-actions">
	                    <button type="submit" class="submit-btn">✅ Cadastrar Cão</button>
	                    <a href="dog_home.jsp" class="cancel-btn">❌ Cancelar</a>
	                </div>
	            </form>
	        </div>
	    </div>
	
		<script type="module" src="./static/js/dog_register.js"></script>
	</body>
</html>