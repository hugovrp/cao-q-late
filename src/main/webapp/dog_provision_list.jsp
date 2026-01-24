<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
   
<!DOCTYPE html>
<html lang="pt-BR">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Cão Q-Late - Histórico de Serviços</title>
	    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
	    <link rel="stylesheet" href="./static/css/global.css">
		<link rel="stylesheet" href="./static/css/dog.css">
	</head>
	
	<body>
	    <jsp:useBean id="dogDao" class="br.petshop.dao.DogDAO"/>
	    
	    <c:if test="${not empty param.dog_id}">
	        <c:set var="dog" value="${dogDao.find_dog(param.dog_id)}" />
	        <c:set var="serviceHistory" value="${dogDao.dog_service_history(param.dog_id)}" />
	    </c:if>
	
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
	            <h2>📊 Histórico de Serviços</h2>
	            <a href="dog_home.jsp" class="back-btn">← Voltar</a>
	        </div>
	
	        <div class="search-section">
	            <h3>🔍 Buscar Histórico por Cão</h3>
	            <form class="search-form" action="" method="get">
	                <div class="form-group">
	                    <label for="dog_id">ID do Cão</label>
	                    <input type="number" id="dog_id" name="dog_id" class="search-input" 
	                           value="${param.dog_id}" min="1" placeholder="Digite o ID do cão">
	                </div>
	                <button type="submit" class="search-btn">🔍 Buscar</button>
	            </form>
	        </div>
	
	        <c:choose>
	            <c:when test="${not empty param.dog_id}">
	                <c:choose>
	                    <c:when test="${not empty dog}">
	                        <div class="dog-info-card">
	                            <div class="dog-avatar">🐶</div>
	                            <div class="dog-details">
	                                <h3>${dog.name}</h3>
	                                <div class="dog-meta">
	                                    <span>🔖 ${dog.breed}</span>
	                                    <span>📏 
	                                        <c:choose>
	                                            <c:when test="${dog.size.name() == 'SMALL'}">Pequeno</c:when>
	                                            <c:when test="${dog.size.name() == 'MEDIUM'}">Médio</c:when>
	                                            <c:when test="${dog.size.name() == 'LARGE'}">Grande</c:when>
	                                        </c:choose>
	                                    </span>
	                                    <span>👤 ${dog.owner.name}</span>
	                                    <span>📞 ${dog.owner.telephone}</span>
	                                </div>
	                            </div>
	                        </div>
	
	                        <div class="history-container">
	                            <div class="history-header">
	                                <h3>Histórico de Atendimentos</h3>
	                                <span class="provision-count">${serviceHistory.size()} atendimento(s)</span>
	                            </div>
	
	                            <c:choose>
	                                <c:when test="${empty serviceHistory}">
	                                    <div class="empty-state">
	                                        <div class="empty-state-icon">📋</div>
	                                        <h3>Nenhum serviço prestado</h3>
	                                        <p>Este cão ainda não possui histórico de atendimentos</p>
	                                    </div>
	                                </c:when>
	                                <c:otherwise>
	                                    <div class="provision-list">
	                                        <c:forEach var="provision" items="${serviceHistory}">
	                                            <div class="provision-item">
	                                                <div class="provision-header">
	                                                    <div class="provision-date">
	                                                        📅 <fmt:formatDate value="${provision.date}" pattern="dd/MM/yyyy"/>
	                                                    </div>
	                                                    <div class="provision-value">
	                                                        R$ <fmt:formatNumber value="${provision.amountCharged}" 
	                                                                           pattern="#,##0.00"/>
	                                                    </div>
	                                                </div>
	
	                                                <div class="services-list">
	                                                    <h4>✂️ Serviços realizados:</h4>
	                                                    <c:forEach var="service" items="${provision.servicesList}">
	                                                        <span class="service-tag">
	                                                            ${service.name} - R$ <fmt:formatNumber value="${service.price}" 
	                                                                                                  pattern="#,##0.00"/>
	                                                        </span>
	                                                    </c:forEach>
	                                                </div>
	
	                                                <c:if test="${provision.discount}">
	                                                    <div>
	                                                        <span class="discount-badge">
	                                                            🎉 Desconto de 10% aplicado (3+ serviços)
	                                                        </span>
	                                                    </div>
	                                                </c:if>
	                                            </div>
	                                        </c:forEach>
	                                    </div>
	                                </c:otherwise>
	                            </c:choose>
	                        </div>
	                    </c:when>
	                    <c:otherwise>
	                        <div class="history-container">
	                            <div class="empty-state">
	                                <div class="empty-state-icon">❌</div>
	                                <h3>Cão não encontrado</h3>
	                                <p>Não foi possível encontrar um cão com este ID</p>
	                            </div>
	                        </div>
	                    </c:otherwise>
	                </c:choose>
	            </c:when>
	            <c:otherwise>
	                <div class="history-container">
	                    <div class="empty-state">
	                        <div class="empty-state-icon">🔍</div>
	                        <h3>Busque por um cão</h3>
	                        <p>Informe o ID de um cão acima para visualizar seu histórico de serviços</p>
	                    </div>
	                </div>
	            </c:otherwise>
	        </c:choose>
	    </div>
	</body>
</html>