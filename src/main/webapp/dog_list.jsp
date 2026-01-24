<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   
<!DOCTYPE html>
<html lang="pt-BR">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Cão Q-Late - Lista de Cães</title>
	    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
	    <link rel="stylesheet" href="./static/css/global.css">
		<link rel="stylesheet" href="./static/css/dog.css">
	</head>
	
	<body>
	    <jsp:useBean id="dao" class="br.petshop.dao.DogDAO"/>
	    <jsp:useBean id="client" class="br.petshop.model.Client"/>
	    <jsp:setProperty property="id" name="client" value="${param.id}"/>
	
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
	            <h2>📋 Lista de Cães</h2>
	            <a href="dog_home.jsp" class="back-btn">← Voltar</a>
	        </div>
	
	        <div class="search-section">
	            <h3>🔍 Buscar Cães por Cliente</h3>
	            <form class="search-form" action="" method="get">
	                <div class="form-group">
	                    <label for="id">ID do Cliente</label>
	                    <input type="number" id="id" name="id" class="search-input" value="${param.id}" min="1" placeholder="Digite o ID do cliente">
	                </div>
	                <button type="submit" class="search-btn">🔍 Buscar</button>
	            </form>
	        </div>
	
	        <div class="table-container">
	            <c:choose>
	                <c:when test="${not empty param.id}">
	                    <c:set var="dogList" value="${dao.dog_list(client)}" />
	                    <div class="table-header">
	                        <h3>Cães Cadastrados</h3>
	                        <span class="dog-count">${dogList.size()} cão(ães)</span>
	                    </div>
	                    
	                    <c:choose>
	                        <c:when test="${empty dogList}">
	                            <div class="empty-state">
	                                <div class="empty-state-icon">🐶</div>
	                                <h3>Nenhum cão encontrado</h3>
	                                <p>Este cliente não possui cães cadastrados</p>
	                            </div>
	                        </c:when>
	                        <c:otherwise>
	                            <table>
	                                <thead>
	                                    <tr>
	                                        <th>Nome</th>
	                                        <th>Raça</th>
	                                        <th>Porte</th>
	                                        <th>Dono</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                    <c:forEach var="dog" items="${dogList}">
	                                        <tr>
	                                            <td><strong>${dog.name}</strong></td>
	                                            <td>${dog.breed}</td>
	                                            <td>
	                                                <c:choose>
	                                                    <c:when test="${dog.size.name() == 'SMALL'}">
	                                                        <span class="size-badge size-small">🐕 Pequeno</span>
	                                                    </c:when>
	                                                    <c:when test="${dog.size.name() == 'MEDIUM'}">
	                                                        <span class="size-badge size-medium">🐕 Médio</span>
	                                                    </c:when>
	                                                    <c:when test="${dog.size.name() == 'LARGE'}">
	                                                        <span class="size-badge size-large">🐕 Grande</span>
	                                                    </c:when>
	                                                </c:choose>
	                                            </td>
	                                            <td>${dog.owner.name}</td>
	                                        </tr>
	                                    </c:forEach>
	                                </tbody>
	                            </table>
	                        </c:otherwise>
	                    </c:choose>
	                </c:when>
	                <c:otherwise>
	                    <div class="empty-state">
	                        <div class="empty-state-icon">🔍</div>
	                        <h3>Busque por um cliente</h3>
	                        <p>Informe o ID de um cliente acima para listar seus cães cadastrados</p>
	                    </div>
	                </c:otherwise>
	            </c:choose>
	        </div>
	    </div>
	</body>
</html>