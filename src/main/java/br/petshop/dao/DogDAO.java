package br.petshop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import br.petshop.database.ConnectionFactory;
import br.petshop.model.Client;
import br.petshop.model.Dog;
import br.petshop.model.Dog.DogSize;
import br.petshop.model.Service;
import br.petshop.model.ServiceProvision;

/**
 * Classe de acesso a dados (DAO) para a entidade Dog.
 * Responsável por todas as operações de banco de dados relacionadas aos cães cadastrados no petshop.
 * 
 * Esta classe gerencia o cadastro de cães, listagem por proprietário, busca individual e consulta ao 
 * histórico de serviços prestados.
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class DogDAO {
	private Connection connection;
	
	/**
	 * Construtor padrão que inicializa a conexão com o banco de dados.
	 * Obtém uma conexão através da ConnectionFactory.
	 */
	public DogDAO() {
		this.connection = ConnectionFactory.getConnection();
	}
	
	/**
	 * Registra um novo cão no banco de dados.
	 * 
	 * O cão deve ter um proprietário (owner) válido já cadastrado.
	 * O ID gerado para o cão é automaticamente atribuído ao objeto.
	 * 
	 * @param dog objeto Dog contendo todos os dados do cão, incluindo seu proprietário
	 * @return boolean true se o registro foi bem-sucedido, false caso contrário
	 */
	public boolean register_dog(Dog dog) {
		String cmd_sql = "insert into dog (name, breed, size, owner_id) values (?,?,?,?)";
		
		try(PreparedStatement statement = connection.prepareStatement(cmd_sql)) {
			statement.setString(1, dog.getName());
			statement.setString(2, dog.getBreed());
			statement.setString(3, dog.getSize().name());
			statement.setInt(4, dog.getOwner().getId());
			
			int rows = statement.executeUpdate();
			
			if(rows > 0) {
				try(ResultSet result = statement.getGeneratedKeys()) {
					if(result.next()) {
						int generated_id = result.getInt(1);
						dog.setId(generated_id);
					}
				}
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	/**
	 * Lista todos os cães pertencentes a um cliente específico.
	 * 
	 * Realiza um JOIN entre as tabelas dog e client para obter informações completas dos cães e seus proprietários.
	 * 
	 * @param client objeto Client contendo o ID do proprietário
	 * @return List<Dog> lista de cães do cliente, lista vazia se nenhum encontrado
	 */
	public List<Dog> dog_list(Client client) {
		List<Dog> dogs = new ArrayList<Dog>();
		String cmd_sql = "select d.id, d.name, d.breed, d.size, " +
				         "c.id as owner_id, c.name as owner_name " +
				         "from dog d join client c on d.owner_id = c.id " +
				         "where c.id = ?";
		
		try(PreparedStatement statement = connection.prepareStatement(cmd_sql)) {
			statement.setInt(1, client.getId());
			
			ResultSet result = statement.executeQuery();
			while(result.next()) {
				Dog dog = new Dog();
				
				dog.setId(result.getInt("id"));
				dog.setName(result.getString("name"));
				dog.setBreed(result.getString("breed"));
				
				String str_size = result.getString("size");
				if(str_size != null) {
					dog.setSize(DogSize.valueOf(str_size));
				}
				
				Client owner = new Client();
				owner.setId(result.getInt("owner_id"));
				owner.setName(result.getString("owner_name"));
				dog.setOwner(owner);
				
				dogs.add(dog);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return dogs;
	}
	
	/**
	 * Busca o histórico completo de serviços prestados para um cão específico.
	 * 
	 * Retorna todas as prestações de serviço (ServiceProvision) realizadas no cão, incluindo os serviços, 
	 * valores e descontos aplicados. Os resultados são ordenados por data decrescente (mais recentes primeiro).
	 * 
	 * @param dog_id int identificador único do cão
	 * @return List<ServiceProvision> lista de prestações de serviço, lista vazia se nenhuma encontrada
	 */
	public List<ServiceProvision> dog_service_history(int dog_id) {
		List<ServiceProvision> provisions = new ArrayList<>();
		
		String cmd_sql = "SELECT sp.id as provision_id, sp.date, sp.discount, sp.amount_charged, " +
				         "sp.scheduling_id, d.id as dog_id, d.name as dog_name, " +
				         "s.id as service_id, s.name as service_name, s.price " +
				         "FROM service_provision sp " +
				         "JOIN dog d ON d.id = sp.dog_id " +
				         "JOIN service_provision_service sps ON sps.service_provision_id = sp.id " +
				         "JOIN service s ON s.id = sps.service_id " +
				         "WHERE d.id = ? " +
				         "ORDER BY sp.date DESC, sp.id";
		
		try (PreparedStatement statement = connection.prepareStatement(cmd_sql)) {
			statement.setInt(1, dog_id);
			ResultSet result = statement.executeQuery();
			
			int last_provision_id = -1;
			ServiceProvision current = null;
			
			while (result.next()) {
				int provision_id = result.getInt("provision_id");
				
				// Nova prestação de serviço
				if (provision_id != last_provision_id) {
					current = new ServiceProvision();
					current.setId(provision_id);
					current.setDate(result.getDate("date"));
					current.setDiscount(result.getBoolean("discount"));
					current.setAmountCharged(result.getFloat("amount_charged"));
					
					Dog dog = new Dog();
					dog.setId(result.getInt("dog_id"));
					dog.setName(result.getString("dog_name"));
					current.setDog(dog);
					
					current.setServicesList(new ArrayList<>());
					provisions.add(current);
					
					last_provision_id = provision_id;
				}
				
				// Adiciona serviço à prestação atual
				Service service = new Service();
				service.setId(result.getInt("service_id"));
				service.setName(result.getString("service_name"));
				service.setPrice(result.getFloat("price"));
				
				current.getServicesList().add(service);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return provisions;
	}
	
	/**
	 * Busca um cão específico pelo seu ID.
	 * 
	 * Retorna informações completas do cão incluindo dados básicos do proprietário (nome, CPF e telefone).
	 * 
	 * @param dog_id int identificador único do cão
	 * @return Dog objeto contendo os dados do cão e proprietário, null se não encontrado
	 */
	public Dog find_dog(int dog_id) {
		String cmd_sql = "SELECT d.id, d.name, d.breed, d.size, " +
				         "c.id as owner_id, c.name as owner_name, c.cpf, c.telephone " +
				         "FROM dog d " +
				         "JOIN client c ON d.owner_id = c.id " +
				         "WHERE d.id = ?";
		
		try (PreparedStatement statement = connection.prepareStatement(cmd_sql)) {
			statement.setInt(1, dog_id);
			ResultSet result = statement.executeQuery();
			
			if (result.next()) {
				Dog dog = new Dog();
				dog.setId(result.getInt("id"));
				dog.setName(result.getString("name"));
				dog.setBreed(result.getString("breed"));
				
				String str_size = result.getString("size");
				if (str_size != null) {
					dog.setSize(DogSize.valueOf(str_size));
				}
				
				Client owner = new Client();
				owner.setId(result.getInt("owner_id"));
				owner.setName(result.getString("owner_name"));
				owner.setCpf(result.getString("cpf"));
				owner.setTelephone(result.getString("telephone"));
				dog.setOwner(owner);
				
				return dog;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	/**
	 * Lista todos os cães cadastrados no sistema.
	 * 
	 * @return List<Dog> lista contendo todos os cães cadastrados, lista vazia se nenhum encontrado
	 */
	public List<Dog> dogs_list() {
		List<Dog> dogs = new ArrayList<Dog>();
		String cmd_sql = "select * from dog";
		
		try(PreparedStatement statement = connection.prepareStatement(cmd_sql)) {
			ResultSet result = statement.executeQuery();
			while(result.next()) {
				Dog dog = new Dog();
				dog.setId(result.getInt("id"));
				dog.setName(result.getString("name"));
				dog.setBreed(result.getString("breed"));
				
				String str_size = result.getString("size");
				if (str_size != null) {
					dog.setSize(DogSize.valueOf(str_size));
				}
				
				Client owner = new Client();
				owner.setId(result.getInt("owner_id"));
				dog.setOwner(owner);
				
				dogs.add(dog);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return dogs;
	}
}