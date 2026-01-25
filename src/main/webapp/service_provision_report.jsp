<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="authentication.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="pt-BR">
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	    <title>Cão Q-Late - Relatório de Prestações</title>
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
	            <h2>📊 Relatório de Serviços Prestados</h2>
	            <a href="service_provision_home.jsp" class="back-btn">← Voltar</a>
	        </div>
	
	        <c:if test="${not empty error}">
	            <div class="alert error">❌ ${error}</div>
	        </c:if>
	
	        <div class="filter-section">
	            <h3>🔍 Selecione o Período</h3>
	            <form action="controller" method="post" class="filter-form" id="reportForm">
	                <input type="hidden" name="handler" value="ShowProvision">
	                
	                <div class="form-group">
	                    <label for="start_date">Data Inicial</label>
	                    <input type="date" id="start_date" name="start_date" 
	                           value="${start_date}" class="date-input" required>
	                </div>
	                
	                <div class="form-group">
	                    <label for="end_date">Data Final</label>
	                    <input type="date" id="end_date" name="end_date" 
	                           value="${end_date}" class="date-input" required>
	                </div>
	                
	                <button type="submit" class="filter-btn">🔍 Gerar Relatório</button>
	            </form>
	        </div>
	
	        <c:if test="${not empty provisions}">
	            <div class="period-info">
	                <p>📅 Período: ${start_date} até ${end_date}</p>
	            </div>
	
	            <div class="summary-cards">
	                <div class="summary-card">
	                    <h4>Total de Prestações</h4>
	                    <div class="summary-value">${provisions.size()}</div>
	                </div>
	
	                <div class="summary-card">
	                    <h4>Faturamento Total</h4>
	                    <div class="summary-value">
	                        R$ <fmt:formatNumber value="${total_revenue}" pattern="#,##0.00"/>
	                    </div>
	                </div>
	
	                <div class="summary-card">
	                    <h4>Ticket Médio</h4>
	                    <div class="summary-value">
	                        R$ <fmt:formatNumber value="${total_revenue / provisions.size()}" pattern="#,##0.00"/>
	                    </div>
	                </div>
	            </div>
	
	            <div class="table-container" style="margin-top: 30px;">
	                <div class="table-header">
	                    <h3>Prestações no Período</h3>
	                </div>
	
	                <table>
	                    <thead>
	                        <tr>
	                            <th>ID</th>
	                            <th>Data</th>
	                            <th>Cão</th>
	                            <th>Serviços</th>
	                            <th>Desconto</th>
	                            <th>Valor</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <c:forEach var="provision" items="${provisions}">
	                            <tr>
	                                <td><strong>#${provision.id}</strong></td>
	                                <td>
	                                    <fmt:formatDate value="${provision.date}" pattern="dd/MM/yyyy"/>
	                                </td>
	                                <td>${provision.dog.name}</td>
	                                <td style="font-size: 0.9em;">
	                                    <c:forEach var="service" items="${provision.servicesList}" varStatus="status">
	                                        ${service.name}<c:if test="${!status.last}">, </c:if>
	                                    </c:forEach>
	                                </td>
	                                <td>
	                                    <c:if test="${provision.discount}">
	                                        <span class="discount-badge">✓ 10% OFF</span>
	                                    </c:if>
	                                </td>
	                                <td class="price-value">
	                                    R$ <fmt:formatNumber value="${provision.amountCharged}" pattern="#,##0.00"/>
	                                </td>
	                            </tr>
	                        </c:forEach>
	                        
	                        <tr class="total-row">
	                            <td colspan="5" style="text-align: right; padding-right: 30px;">
	                                💰 TOTAL FATURADO:
	                            </td>
	                            <td>
	                                R$ <fmt:formatNumber value="${total_revenue}" pattern="#,##0.00"/>
	                            </td>
	                        </tr>
	                    </tbody>
	                </table>
	            </div>
	        </c:if>
	
	        <c:if test="${empty provisions && not empty start_date}">
	            <div class="table-container">
	                <div class="empty-state">
	                    <div class="empty-state-icon">📊</div>
	                    <h3>Nenhuma prestação encontrada</h3>
	                    <p>Não há prestações de serviço no período selecionado</p>
	                </div>
	            </div>
	        </c:if>
	    </div>
	
		<script type="module" src="./static/js/service_provision_report.js"></script>
	</body>
</html>