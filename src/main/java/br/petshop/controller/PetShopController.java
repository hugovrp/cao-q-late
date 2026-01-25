package br.petshop.controller;

import java.io.IOException;

import br.petshop.controller.handler.Handler;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Controlador principal da aplicação PetShop.
 * 
 * Esta classe atua como Front Controller, recebendo todas as requisições através da URL "/controller" 
 * e direcionando para os handlers específicos baseado no parâmetro "handler" da requisição.
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
@SuppressWarnings("serial")
@WebServlet("/controller")
public class PetShopController extends HttpServlet {
	
	/**
	 * Processa todas as requisições HTTP (GET, POST, etc.) enviadas ao servlet.
	 * 
	 * Funcionamento:
	 * 1. Recebe o nome da classe handler através do parâmetro "handler"
	 * 2. Usa reflexão para instanciar dinamicamente a classe correspondente
	 * 3. Executa o método service() do handler
	 * 4. Encaminha a requisição para a página JSP retornada pelo handler
	 * 
	 * @param request Objeto contendo os dados da requisição HTTP
	 * @param response Objeto para enviar a resposta HTTP
	 * @throws ServletException Se houver erro no processamento do servlet
	 * @throws IOException Se houver erro de entrada/saída
	 */
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		// Monta o nome completo da classe handler baseado no parâmetro recebido
		String handler_class = "br.petshop.controller.handler.actions." + request.getParameter("handler");
		Class<?> action_class;
		
		// Página padrão caso ocorra algum erro
		String url = "index.jsp";
		
		try {
			// Carrega a classe handler usando reflexão
			action_class = Class.forName(handler_class);
			
			// Instancia a classe handler 
			@SuppressWarnings("deprecation")
			Handler handler = (Handler) action_class.newInstance();
			
			// Executa a lógica de negócio e obtém a URL da página de destino
			url = handler.service(request, response);
			
		} catch (ClassNotFoundException | IllegalAccessException | InstantiationException e) {
			url = "404.jsp";
		}
		
		// Encaminha a requisição para a página JSP apropriada
		request.getRequestDispatcher(url).forward(request, response);
	}
}