package br.petshop.controller.handler.actions;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import br.petshop.controller.handler.Handler;
import br.petshop.dao.SchedulingDAO;
import br.petshop.model.Client;
import br.petshop.model.Dog;
import br.petshop.model.Scheduling;
import br.petshop.model.Service;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Handler responsável pelo cadastro de agendamentos de serviços.
 * 
 * Realiza validações importantes:
 * - Verifica se a data não está no passado
 * - Valida se o cão pertence ao cliente informado
 * - Verifica disponibilidade da data para o cão específico
 * 
 * Parâmetros esperados na requisição:
 * - client_id: ID do cliente
 * - dog_id: ID do cão
 * - date: Data do agendamento (formato: yyyy-MM-dd)
 * - services_id: Array com IDs dos serviços a serem realizados
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class RegisterScheduling implements Handler {

	/**
	 * Processa o cadastro de um novo agendamento.
	 * 
	 * Executa múltiplas validações de negócio antes de persistir:
	 * 1. Data não pode estar no passado
	 * 2. Cão deve pertencer ao cliente
	 * 3. Data deve estar disponível para o cão
	 * 
	 * @param request Requisição contendo os dados do agendamento
	 * @param response Objeto de resposta HTTP
	 * @return Caminho da página inicial de agendamentos (scheduling_home.jsp)
	 * @throws ServletException Se houver erro no processamento
	 * @throws IOException Se houver erro de entrada/saída
	 */
    @Override
    public String service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// Extrai os parâmetros do formulário
        int client_id = Integer.parseInt(request.getParameter("client_id"));
        int dog_id = Integer.parseInt(request.getParameter("dog_id"));
        Date date = Date.valueOf(request.getParameter("date"));
        String[] services_id = request.getParameterValues("services_id");

        // Validação: não permite agendamento em datas passadas
        if(date.toLocalDate().isBefore(LocalDate.now())) {
        	request.setAttribute("errorMessage", "Não é possível agendar uma data no passado.");
            return "scheduling_home.jsp";
        }
        
        SchedulingDAO dao = new SchedulingDAO();

        // Validação: verifica se o cão pertence ao cliente
        if(!dao.dog_belongs_client(dog_id, client_id)) {
            request.setAttribute("errorMessage", "O cão informado não pertence a este cliente.");
            return "scheduling_home.jsp";
        }

        // Validação: verifica disponibilidade da data para o cão
        if(!dao.is_date_available(dog_id, date)) {
            request.setAttribute("errorMessage", "Data indisponível para este cão. Escolha outra data.");
            return "scheduling_home.jsp";
        }

        Scheduling scheduling = new Scheduling();
        scheduling.setStatus("Agendado");

        // Associa o cliente ao agendamento
        Client client = new Client();
        client.setId(client_id);
        scheduling.setClient(client);

        // Associa o cão ao agendamento
        Dog dog = new Dog();
        dog.setId(dog_id);
        scheduling.setDog(dog);

        scheduling.setDate(date);

        // Adiciona os serviços selecionados ao agendamento
        List<Service> services = new ArrayList<>();
        if(services_id != null) {
            for(String s_id : services_id) {
                Service s = new Service();
                s.setId(Integer.parseInt(s_id));
                services.add(s);
            }
        }
        scheduling.setServicesList(services);
        boolean success = dao.register_scheduling(scheduling);
        
        // Define mensagem de sucesso ou erro
        if(success) {
            request.setAttribute("successMessage", "Agendamento realizado com sucesso!");
        } else {
            request.setAttribute("errorMessage", "Erro ao registrar o agendamento.");
        }

        return "scheduling_home.jsp";
    }
}