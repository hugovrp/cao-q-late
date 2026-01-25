<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-BR">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Cão Q-Late - Lançar Prestação</title>
	    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
	    <link rel="stylesheet" href="./static/css/global.css">
	    <link rel="stylesheet" href="./static/css/service_provision.css">
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
	            <li><a href="scheduling_home.jsp">📅 <span>Agendamentos</span></a></li>
	            <li><a href="service_provision_home.jsp" class="active">🎯 <span>Prestar Serviços</span></a></li>
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
	            <h2>✅ Lançar Prestação de Serviço</h2>
	            <a href="service_provision_home.jsp" class="back-btn">← Voltar</a>
	        </div>
	
	        <c:if test="${not empty error}">
	            <div class="alert error">❌ ${error}</div>
	        </c:if>
	
	        <c:if test="${not empty success}">
	            <div class="alert success">✅ ${success}</div>
	        </c:if>
	
	        <div class="info-box">
	            <h3>💡 Informações Importantes</h3>
	            <ul>
	                <li>Selecione um agendamento com status "Agendado" para lançar a prestação</li>
	                <li>O sistema calculará automaticamente o valor com base nos serviços</li>
	                <li><strong>Desconto de 10%:</strong> Aplicado automaticamente quando 3 ou mais serviços forem prestados</li>
	                <li>O status do agendamento será alterado para "Finalizado" após o lançamento</li>
	            </ul>
	        </div>
	
	        <div class="form-container">
	            <c:choose>
	                <c:when test="${empty schedulings}">
	                    <div class="empty-state">
	                        <div class="empty-state-icon">📅</div>
	                        <h3>Nenhum agendamento disponível</h3>
	                        <p>Não há agendamentos com status "Agendado" para lançar prestação.</p>
	                        <a href="scheduling_home.jsp">📅 Ir para Agendamentos</a>
	                    </div>
	                </c:when>
	                <c:otherwise>
	                    <form id="provisionForm" action="controller" method="post">
	                        <input type="hidden" name="handler" value="RegisterProvision">
	                        <input type="hidden" name="action" value="register">
	
	                        <h3 style="font-family: 'Poppins', sans-serif; color: #264653; margin-bottom: 20px;">
	                            Selecione o Agendamento
	                        </h3>
	
	                        <div class="table-container">
	                            <table>
	                                <thead>
	                                    <tr>
	                                        <th style="width: 60px;">Selecionar</th>
	                                        <th>ID</th>
	                                        <th>Data</th>
	                                        <th>Cão</th>
	                                        <th>Serviços</th>
	                                        <th>Status</th>
	                                    </tr>
	                                </thead>
	                                <tbody>
	                                    <c:forEach var="scheduling" items="${schedulings}">
	                                        <c:if test="${scheduling.status == 'Agendado'}">
	                                            <tr onclick="selectRow(this, ${scheduling.id})">
	                                                <td>
	                                                    <input type="radio" name="scheduling_id" 
	                                                           value="${scheduling.id}" 
	                                                           id="scheduling_${scheduling.id}" required>
	                                                </td>
	                                                <td><strong>#${scheduling.id}</strong></td>
	                                                <td>
	                                                    <fmt:formatDate value="${scheduling.date}" pattern="dd/MM/yyyy"/>
	                                                </td>
	                                                <td>${scheduling.dog.name}</td>
	                                                <td class="services-list">
	                                                    <c:forEach var="service" items="${scheduling.servicesList}" varStatus="status">
	                                                        ${service.name}<c:if test="${!status.last}">, </c:if>
	                                                    </c:forEach>
	                                                </td>
	                                                <td><span class="status-badge">${scheduling.status}</span></td>
	                                            </tr>
	                                        </c:if>
	                                    </c:forEach>
	                                </tbody>
	                            </table>
	                        </div>
	
	                        <button type="submit" class="submit-btn">✅ Confirmar Prestação</button>
	                    </form>
	                </c:otherwise>
	            </c:choose>
	        </div>
	    </div>
	
		<script type="module" src="./static/js/service_provision_register.js"></script>
	</body>
</html>