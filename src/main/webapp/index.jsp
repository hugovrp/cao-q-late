<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    
<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html lang="pt-BR">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Cão Q-Late - Dashboard</title>
	    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
	    <link rel="stylesheet" href="./static/css/global.css">
		<link rel="stylesheet" href="./static/css/dashboard.css">
	</head>
	
	<body>
		<jsp:useBean id="clientDAO" class="br.petshop.dao.ClientDAO"></jsp:useBean>
		<jsp:useBean id="dogDAO" class="br.petshop.dao.DogDAO"></jsp:useBean>
		<jsp:useBean id="provisionDAO" class="br.petshop.dao.ServiceProvisionDAO"></jsp:useBean>
		<jsp:useBean id="schedulingDAO" class="br.petshop.dao.SchedulingDAO"></jsp:useBean>
	
	    <div class="sidebar">
	        <div class="sidebar-header">
	            <h1>🐕 Cão Q-Late</h1>
	            <p>Sistema de Gerenciamento</p>
	        </div>
	
	        <div class="user-info">
	            <div class="user-avatar">👤</div>
	            <div class="user-details">
	                <h3>${sessionScope.name}</h3>
	                <p>Administrador</p>
	            </div>
	        </div>
	
	        <ul>
	            <li><a href="index.jsp" class="active">📊 <span>Dashboard</span></a></li>
	            <li><a href="client_home.jsp">👥 <span>Clientes</span></a></li>
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
	            <h2>Dashboard</h2>
	            <div class="date-time" id="dateTime"></div>
	        </div>
	
	        <div class="stats-grid">
	            <div class="stat-card">
	                <div class="stat-info">
	                    <h3>Agendamentos Hoje</h3>
	                    <c:set var="todayList" value="${schedulingDAO.schedulings_today()}" />    
	                    <div class="number">${todayList.size()}</div>
	                </div>
	                <div class="stat-icon">📅</div>
	            </div>
	
	            <div class="stat-card">
	                <div class="stat-info">
	                    <h3>Clientes Ativos</h3>
	                	<c:set var="clientList" value="${clientDAO.clients_list()}" />    
	                    <div class="number">${clientList.size()}</div>	                    
	                </div>
	                <div class="stat-icon">👥</div>
	            </div>
	
	            <div class="stat-card">
	                <div class="stat-info">
	                    <h3>Cães Cadastrados</h3>
	                    <c:set var="dogList" value="${dogDAO.dogs_list()}" />    
	                    <div class="number">${dogList.size()}</div>
	                </div>
	                <div class="stat-icon">🐶</div>
	            </div>
	
	            <div class="stat-card">
	                <div class="stat-info">
	                    <h3>Serviços Prestados</h3>
	                    <c:set var="finishedList" value="${schedulingDAO.finished_list()}" />    
	                    <div class="number">${finishedList.size()}</div>
	                </div>
	                <div class="stat-icon">✂️</div>
	            </div>
	        </div>
	
	        <div class="content-grid">
	            <div class="card">
				    <div class="card-header">
				        <h3>📅 Agendamentos de Hoje</h3>
				        <a href="scheduling_home.jsp">Ver todos →</a>
				    </div>
				
				    <c:choose>
				        <c:when test="${not empty todayList}">
				            <div class="appointment-list">
				                <c:forEach var="sched" items="${todayList}">
				                    <div class="appointment-item" style="display: flex; justify-content: space-between; align-items: center; padding: 12px; border-bottom: 1px solid #eee;">
				                        <div class="appointment-info">
				                            <strong style="display: block; color: #264653;">🐶 ${sched.dog.name}</strong>
				                            <span style="font-size: 0.85em; color: #666;">
				                                <c:forEach var="service" items="${sched.servicesList}" varStatus="status">
				                                	${service.name}${not status.last ? ', ' : ''}
				                                </c:forEach>
				                            </span>
				                        </div>
				                        <span class="status-badge" style="background: #e7f3f2; color: #2a9d8f; padding: 4px 8px; border-radius: 4px; font-size: 0.8em; font-weight: 600;">
				                            ${sched.status}
				                        </span>
				                    </div>
				                </c:forEach>
				            </div>
				        </c:when>
				        <c:otherwise>
				            <div style="text-align: center; padding: 40px 20px; color: #999;">
				                <div style="font-size: 3em; margin-bottom: 15px;">📅</div>
				                <p>Nenhum agendamento para hoje</p>
				                <a href="scheduling_home.jsp" style="color: #2A9D8F; text-decoration: none; font-weight: 500; margin-top: 10px; display: inline-block;">Criar novo agendamento</a>
				            </div>
				        </c:otherwise>
				    </c:choose>
				</div>
	
	            <div>
	                <div class="card" style="margin-bottom: 25px;">
	                    <div class="card-header">
	                        <h3>⚡ Ações Rápidas</h3>
	                    </div>
	
	                    <div class="quick-actions">
	                        <a href="scheduling_home.jsp" class="quick-action-btn">
	                            <div class="icon">➕</div>
	                            <div class="text">Novo Agendamento</div>
	                        </a>
	                        <a href="client_home.jsp" class="quick-action-btn" style="background: linear-gradient(135deg, #E9C46A, #d4a849);">
	                            <div class="icon">👤</div>
	                            <div class="text">Novo Cliente</div>
	                        </a>
	                        <a href="dog_home.jsp" class="quick-action-btn" style="background: linear-gradient(135deg, #264653, #1a3540);">
	                            <div class="icon">🐕</div>
	                            <div class="text">Novo Cão</div>
	                        </a>
	                        <a href="service_provision_home.jsp" class="quick-action-btn" style="background: linear-gradient(135deg, #f4a261, #e76f51);">
	                            <div class="icon">✅</div>
	                            <div class="text">Prestar Serviço</div>
	                        </a>
	                    </div>
	                </div>
	
	                <div class="card">
	                    <div class="card-header">
	                        <h3>🔔 Atividades Recentes</h3>
	                    </div>
	
	                    <div style="text-align: center; padding: 40px 20px; color: #999;">
	                        <div style="font-size: 3em; margin-bottom: 15px;">🔔</div>
	                        <p>Nenhuma atividade recente</p>
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
		<script type="module" src="./static/js/dashboard.js"></script>
	</body>
</html>