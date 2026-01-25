<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-BR">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Cão Q-Late - Agendamentos</title>
	    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
	    <link rel="stylesheet" href="./static/css/global.css">
	    <link rel="stylesheet" href="./static/css/scheduling.css">
	</head>
	
	<body>
	    <jsp:useBean id="now" class="java.util.Date" scope="page" />
	
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
	            <h2>📋 Lista de Agendamentos</h2>
	            <a href="scheduling_home.jsp" class="back-btn">← Voltar</a>
	        </div>
	
	        <div class="filter-section">
	            <h3>🔍 Filtrar Agendamentos</h3>
	            <form action="controller" method="post" class="filter-form">
	                <input type="hidden" name="handler" value="ListScheduling">
	                <div class="form-group">
	                    <label for="start_date">Data Inicial</label>
	                    <input type="date" id="start_date" name="start_date" class="date-input" 
	                           value="${startDate}" required>
	                </div>
	                <button type="submit" class="filter-btn">🔍 Filtrar</button>
	            </form>
	        </div>
	
	        <div id="alertBox" class="alert" 
			     data-success="${not empty param.success}" 
			     data-error="${not empty param.error}">
			</div>
	
	        <div class="schedulings-container">
	            <div class="schedulings-header">
	                <h3>Agendamentos</h3>
	            </div>
	
	            <c:choose>
	                <c:when test="${not empty schedulings}">
	                    <c:forEach var="s" items="${schedulings}">
	                        <div class="scheduling-item">
	                            <div class="scheduling-header">
	                                <div>
	                                    <div class="scheduling-date">
	                                        📅 <fmt:formatDate value="${s.date}" pattern="dd/MM/yyyy"/>
	                                    </div>
	                                    <div class="dog-name">
	                                        🐶 ${s.dog.name}
	                                    </div>
	                                </div>
	                                <span class="status-badge status-${s.status.toLowerCase()}">${s.status}</span>
	                            </div>
	
	                            <div class="scheduling-details">
	                                <div class="services-list">
	                                    <h4>✂️ Serviços Agendados:</h4>
	                                    <c:forEach var="svc" items="${s.servicesList}">
	                                        <div class="service-item">
	                                            ${svc.name} - <span class="service-price">R$ <fmt:formatNumber value="${svc.price}" pattern="#,##0.00"/></span>
	                                        </div>
	                                    </c:forEach>
	                                </div>
	                            </div>
	
	                            <div class="scheduling-actions">
	                                <c:choose>
	                                    <c:when test="${s.status eq 'Cancelado'}">
	                                        <span class="cannot-cancel">❌ Agendamento cancelado</span>
	                                    </c:when>
	                                    <c:otherwise>
	                                        <c:choose>
	                                            <c:when test="${s.date.time - now.time > 86400000}">
	                                                <form action="controller" method="post" style="display:inline;">
	                                                    <input type="hidden" name="handler" value="CancelScheduling">
	                                                    <input type="hidden" name="id" value="${s.id}">
	                                                    <input type="hidden" name="date" value="${s.date}">
	                                                    <button type="submit" class="cancel-btn" onclick="return confirm('Tem certeza que deseja cancelar este agendamento?')">
	                                                        ❌ Cancelar Agendamento
	                                                    </button>
	                                                </form>
	                                            </c:when>
	                                            <c:otherwise>
	                                                <span class="cannot-cancel">⏰ Não pode cancelar (menos de 24h)</span>
	                                            </c:otherwise>
	                                        </c:choose>
	                                    </c:otherwise>
	                                </c:choose>
	                            </div>
	                        </div>
	                    </c:forEach>
	                </c:when>
	                <c:otherwise>
	                    <div class="empty-state">
	                        <div class="empty-state-icon">📅</div>
	                        <h3>Nenhum agendamento encontrado</h3>
	                        <p>Não há agendamentos para a data selecionada</p>
	                    </div>
	                </c:otherwise>
	            </c:choose>
	        </div>
	    </div>
	
		<script type="module" src="./static/js/scheduling_list.js"></script>
	</body>
</html>