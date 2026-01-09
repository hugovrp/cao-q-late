package br.petshop.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Classe responsável por gerenciar a conexão com o banco de dados PostgreSQL.
 * Implementa o padrão Factory para centralizar a criação de conexões.
 * 
 * Esta classe utiliza o driver JDBC do PostgreSQL para estabelecer conexões com o 
 * banco de dados do sistema petshop.
 * 
 * @author Hugo Vinícius Rodrigues Pereira
 * @version 1.0
 */
public class ConnectionFactory {
	
	/** URL de conexão com o banco de dados PostgreSQL */
	private static final String URL = System.getenv("DB_URL") != null 
			? System.getenv("DB_URL") : "jdbc:postgresql://localhost:5432/petshop-caoqlate";
	
	/** Nome de usuário para autenticação no banco de dados */
	private static final String USER = System.getenv("DB_USER") != null 
			? System.getenv("DB_USER") : "postgres";
	
	/** Senha para autenticação no banco de dados */
	private static final String PASSWORD = System.getenv("DB_PASS") != null
			? System.getenv("DB_PASS") : "postgre";
	
	/**
	 * Obtém uma nova conexão com o banco de dados PostgreSQL.
	 * 
	 * Este método carrega o driver JDBC do PostgreSQL e estabelece uma conexão com o banco de dados 
	 * usando as credenciais configuradas.
	 * 
	 * @return Connection objeto de conexão ativa com o banco de dados
	 * @throws RuntimeException se houver erro ao carregar o driver ou conectar ao banco
	 */
	public static Connection getConnection() {
		try {
			Class.forName("org.postgresql.Driver");
			
			return DriverManager.getConnection(URL, USER, PASSWORD);
		} catch (SQLException | ClassNotFoundException e) {
			throw new RuntimeException("Erro ao obter conexão com o BD", e);
		}
	}
}