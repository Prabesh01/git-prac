package database;
import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConnection {
    private final static String databaseName = "pin";
    private final static String username = "root";
    private final static String password = "";
    private final static String jdbcUrl = "jdbc:mysql://localhost:3306/" + databaseName;



    public static Connection getConnection() throws ClassNotFoundException, java.sql.SQLException{
        Connection connection = null;
        Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL JDBC Driver
        connection = DriverManager.getConnection(jdbcUrl, username, password);

        if(connection != null){
            System.out.println("Connected to the database"); 
        }else{
            System.out.println("Failed to connect to the database");
        }
        return connection;
    }

    public static void main(String[] args) {
        try {
            getConnection(); 
        }catch(Exception e){
            System.out.println(e);
        }
    }
}
