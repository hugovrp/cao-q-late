package br.petshop.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import br.petshop.database.ConnectionFactory;
import br.petshop.model.Dog;
import br.petshop.model.Scheduling;
import br.petshop.model.Service;

/**
 * Classe de acesso a dados (DAO) para a entidade Scheduling.
 * Responsável por todas as operações de banco de dados relacionadas aos agendamentos de serviços do petshop.
 * 
 * Esta classe gerencia o registro de agendamentos, cancelamentos, verificações de disponibilidade e 
 * listagens de agendamentos futuros.
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class SchedulingDAO {
	private Connection connection;
	
	/**
	 * Construtor padrão que inicializa a conexão com o banco de dados.
	 * Obtém uma conexão através da ConnectionFactory.
	 */
	public SchedulingDAO() {
		this.connection = ConnectionFactory.getConnection();
	}
	
	/**
	 * Registra um novo agendamento no banco de dados.
	 * 
	 * Insere o agendamento principal e associa todos os serviços incluídos através da tabela de relacionamento 
	 * scheduling_service. O ID gerado é automaticamente atribuído ao objeto Scheduling.
	 * 
	 * @param scheduling objeto Scheduling contendo cliente, cão, data, status e lista de serviços
	 * @return boolean true se o registro foi bem-sucedido, false caso contrário
	 */
	public boolean register_scheduling(Scheduling scheduling) {
	    String cmd_sql = "insert into scheduling (status, client, dog, date) values (?,?,?,?)";
	    
	    try(PreparedStatement statement = connection.prepareStatement(cmd_sql, Statement.RETURN_GENERATED_KEYS)) {
	        statement.setString(1, scheduling.getStatus());
	        statement.setInt(2, scheduling.getClient().getId());
	        statement.setInt(3, scheduling.getDog().getId());
	        statement.setDate(4, new Date(scheduling.getDate().getTime()));
	        
	        int rows = statement.executeUpdate();

	        if(rows > 0) {
	            // Obtém o ID gerado antes de inserir os serviços
	            try(ResultSet result = statement.getGeneratedKeys()) {
	                if(result.next()) {
	                    int scheduling_id = result.getInt(1);
	                    scheduling.setId(scheduling_id);
	                } else {
	                    return false;
	                }
	            }

	            // Insere os serviços associados com o ID correto
	            if(scheduling.getServicesList() != null && !scheduling.getServicesList().isEmpty()) {
	                String cmd_association = "insert into scheduling_service (scheduling_id, service_id) values (?,?)";
	                
	                try(PreparedStatement statement_association = connection.prepareStatement(cmd_association)) {
	                    for(Service service : scheduling.getServicesList()) {
	                        statement_association.setInt(1, scheduling.getId());
	                        statement_association.setInt(2, service.getId());
	                        statement_association.addBatch();
	                    }
	                    statement_association.executeBatch();
	                }
	            }
	            return true;
	        }
	    } catch(SQLException e) {
	        e.printStackTrace();
	    }

	    return false;
	}
	
	/**
	 * Verifica se um cão pertence a um cliente específico.
	 * 
	 * Validação importante antes de criar agendamentos, garantindo que apenas o proprietário pode agendar 
	 * serviços para seu cão.
	 * 
	 * @param dog_id int identificador do cão
	 * @param client_id int identificador do cliente
	 * @return boolean true se o cão pertence ao cliente, false caso contrário
	 */
	public boolean dog_belongs_client(int dog_id, int client_id) {
	    String sql = "select count(*) from dog where id = ? and owner_id = ?";
	    try(PreparedStatement stmt = connection.prepareStatement(sql)) {
	        stmt.setInt(1, dog_id);
	        stmt.setInt(2, client_id);
	        ResultSet rs = stmt.executeQuery();
	        if(rs.next()) {
	            return rs.getInt(1) > 0;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}

	/**
	 * Verifica se uma data está disponível para novos agendamentos.
	 * 
	 * Valida se já existe algum agendamento na data especificada, evitando conflitos de horários.
	 * 
	 * @param dog_id int identificador do cão 
	 * @param date Date data a ser verificada
	 * @return boolean true se a data está livre, false se já existe agendamento
	 */
	public boolean is_date_available(int dog_id, Date date) {
		String sql = "select count(*) from scheduling where date=? and dog=?";
	    try(PreparedStatement stmt = connection.prepareStatement(sql)) {
	        stmt.setDate(1, date);
	        stmt.setInt(2, dog_id);
	        ResultSet rs = stmt.executeQuery();
	        if(rs.next()) {
	            return rs.getInt(1) == 0; // true se não há nenhum agendamento nesta data
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return false;
	}
	
	/**
	 * Cancela um agendamento existente.
	 * 
	 * Altera o status do agendamento para "Cancelado" sem remover o registro do banco de dados, mantendo o histórico.
	 * 
	 * @param scheduling_id int identificador do agendamento a ser cancelado
	 * @return boolean true se o cancelamento foi bem-sucedido, false caso contrário
	 */
	public boolean cancel_scheduling(int scheduling_id) {
		String cmd_sql = "update scheduling set status = 'Cancelado' where id=?";
		
		try(PreparedStatement statement = connection.prepareStatement(cmd_sql)) {
			statement.setInt(1, scheduling_id);
			int rows = statement.executeUpdate();
			return rows > 0;
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	/**
	 * Lista todos os serviços associados a um agendamento específico.
	 * 
	 * @param scheduling_id int identificador do agendamento
	 * @return List<Service> lista de serviços do agendamento, lista vazia se nenhum encontrado
	 */
	public List<Service> list_by_scheduling(int scheduling_id) {
	    List<Service> services = new ArrayList<>();

	    String cmd_sql = "select s.id, s.name, s.price from service s " + 
					     "inner join scheduling_service ss on s.id = ss.service_id " +
					     "where ss.scheduling_id = ?";

	    try(PreparedStatement statement = connection.prepareStatement(cmd_sql)) {
	    	statement.setInt(1, scheduling_id);

	        try(ResultSet result = statement.executeQuery()) {
	            while(result.next()) {
	                Service service = new Service();
	                service.setId(result.getInt("id"));
	                service.setName(result.getString("name"));
	                service.setPrice(result.getFloat("price"));
	                services.add(service);
	            }
	        }

	    } catch(SQLException e) {
	        e.printStackTrace();
	    }

	    return services;
	}
	
	/**
	 * Lista todos os agendamentos futuros a partir de uma data inicial.
	 * 
	 * Retorna apenas agendamentos com status "Agendado", ordenados por data crescente. 
	 * Agrupa os serviços de cada agendamento.
	 * 
	 * @param start_date Date data inicial para busca (inclusive)
	 * @return List<Scheduling> lista de agendamentos futuros com seus serviços, lista vazia se nenhum encontrado
	 */
	public List<Scheduling> scheduling_list(Date start_date) {
		List<Scheduling> schedulings = new ArrayList<Scheduling>();
		String cmd_sql = "select sc.id as scheduling_id, sc.date, sc.status, " +
			    		 "d.name as dog_name, s.id as service_id, s.name as service_name, s.price " +
			    		 "from scheduling sc " +
			    		 "join dog d on d.id = sc.dog " +
			    		 "join scheduling_service ss on ss.scheduling_id = sc.id " +
			    		 "join service s on s.id = ss.service_id " +
			    		 "where sc.date >= ? and sc.status = 'Agendado' " +
			    		 "order by sc.date asc";
		
		try(PreparedStatement statement = connection.prepareStatement(cmd_sql)) {
			statement.setDate(1, start_date);
			ResultSet result = statement.executeQuery();
			
			int last_id = -1;
			Scheduling current = null;
			
			while(result.next()) {
				int sched_id = result.getInt("scheduling_id");
				
				// Novo agendamento
				if(sched_id != last_id) {
					current = new Scheduling();
					current.setId(sched_id);
					current.setDate(result.getDate("date"));
					current.setStatus(result.getString("status"));
					
					Dog dog = new Dog();
					dog.setName(result.getString("dog_name"));
					current.setDog(dog);
					
					current.setServicesList(new ArrayList<Service>());
					schedulings.add(current);
					
					last_id = sched_id;
				}
				
				// Adiciona serviço ao agendamento atual
				Service service = new Service();
	            service.setId(result.getInt("service_id"));
	            service.setName(result.getString("service_name"));
	            service.setPrice(result.getFloat("price"));

	            current.getServicesList().add(service);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		return schedulings;
	}
	
	/**
	 * Lista todos os agendamentos para hoje cadastrados no sistema.
	 * 
	 * @return List<Scheduling> lista contendo todos os agendamentos para hoje cadastrados, lista vazia se nenhum encontrado
	 */
	public List<Scheduling> schedulings_today() {
	    List<Scheduling> today = new ArrayList<Scheduling>();
	    // SQL melhorado para trazer o nome do cão
	    String cmd_sql = "select sc.*, d.name as dog_name from scheduling sc " +
	                     "join dog d on d.id = sc.dog " +
	                     "where sc.date = CURRENT_DATE and sc.status = 'Agendado'";
	    
	    try(PreparedStatement statement = connection.prepareStatement(cmd_sql)) {
	        ResultSet result = statement.executeQuery();
	        while(result.next()) {
	            Scheduling scheduling = new Scheduling();
	            scheduling.setId(result.getInt("id"));
	            scheduling.setStatus(result.getString("status"));
	            
	            Dog dog = new Dog();
	            dog.setName(result.getString("dog_name"));
	            scheduling.setDog(dog);
	            
	            // Busca os serviços deste agendamento específico
	            scheduling.setServicesList(this.list_by_scheduling(scheduling.getId())); 
	            
	            today.add(scheduling);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return today;
	}
	
	/**
	 * Lista todos os agendamentos finalizados no sistema.
	 * 
	 * @return List<Scheduling> lista contendo todos os agendamentos finalizados, lista vazia se nenhum encontrado
	 */
	public List<Scheduling> finished_list() {
		List<Scheduling> finished = new ArrayList<Scheduling>();
		String cmd_sql = "select * from scheduling where status = 'Finalizado'";
		
		try(PreparedStatement statement = connection.prepareStatement(cmd_sql)) {
			ResultSet result = statement.executeQuery();
			while(result.next()) {
				Scheduling scheduling = new Scheduling();
				scheduling.setId(result.getInt("id"));
				
				finished.add(scheduling);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return finished;
	}
}