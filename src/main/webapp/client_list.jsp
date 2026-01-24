<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   
<!DOCTYPE html>
<html lang="pt-BR">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Cão Q-Late - Lista de Clientes</title>
	    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
	    <link rel="stylesheet" href="./static/css/global.css">
	    <link rel="stylesheet" href="./static/css/client.css">
	</head>
	
	<body>
	    <jsp:useBean id="dao" class="br.petshop.dao.ClientDAO"></jsp:useBean>
	
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
	            <h2>📋 Lista de Clientes</h2>
	            <a href="client_home.jsp" class="back-btn">← Voltar</a>
	        </div>
	
	        <div class="search-section">
	            <input type="text" id="searchInput" class="search-input" placeholder="🔍 Buscar por nome, CPF, e-mail ou telefone...">
	        </div>
	
	        <div class="table-container">
	            <div class="table-header">
	                <h3>Clientes Cadastrados</h3>
	                <c:set var="clientList" value="${dao.clients_list()}" />
	                <span class="client-count">${clientList.size()} cliente(s)</span>
	            </div>
	
	            <c:choose>
	                <c:when test="${empty clientList}">
	                    <div class="empty-state">
	                        <div class="empty-state-icon">👥</div>
	                        <h3>Nenhum cliente cadastrado</h3>
	                        <p>Comece adicionando o primeiro cliente do seu petshop</p>
	                        <a href="client_register.jsp" class="add-client-btn">➕ Cadastrar Cliente</a>
	                    </div>
	                </c:when>
	                <c:otherwise>
	                    <table id="clientTable">
	                        <thead>
	                            <tr>
	                                <th>Nome</th>
	                                <th>CPF</th>
	                                <th>E-mail</th>
	                                <th>Telefone</th>
	                                <th>Data de Nascimento</th>
	                            </tr>
	                        </thead>
	                        <tbody>
	                            <c:forEach var="client" items="${clientList}">
	                                <tr>
	                                    <td>${client.name}</td>
	                                    <td>${client.cpf}</td>
	                                    <td>
	                                        <c:choose>
	                                            <c:when test="${not empty client.email}">
	                                                <a href="mailto:${client.email}" class="email-link">${client.email}</a>
	                                            </c:when>
	                                            <c:otherwise>
	                                                <span class="no-email">E-mail não informado</span>
	                                            </c:otherwise>
	                                        </c:choose>
	                                    </td>
	                                    <td>${client.telephone}</td>
	                                    <td><fmt:formatDate value="${client.birthDate}" pattern="dd/MM/yyyy"/></td>
	                                </tr>
	                            </c:forEach>
	                        </tbody>
	                    </table>
	                </c:otherwise>
	            </c:choose>
	        </div>
	    </div>
	
	    <script type="module" src="./static/js/client_list.js"></script>
	</body>
</html>