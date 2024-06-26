package edu.pnu;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DriverStatement {
	
	public static void main(String[] args) {
		
		Connection con = null;		
		try {
			String driver = "com.mysql.cj.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/world";
			String username = "scott";
			String password = "tiger";
			
			Class.forName(driver);
			System.out.println("로딩 성공");
			
			con = DriverManager.getConnection(url, username, password);
			System.out.println("연결 성공");
			
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT Id, Name, CountryCode, District, Population FROM city LIMIT 10");
			
			while(rs.next()) {
				System.out.print(rs.getString("Id") + ",");
				System.out.print(rs.getString("Name") + ",");
				System.out.print(rs.getString("CountryCode") + ",");
				System.out.print(rs.getString("District") + ",");
				System.out.print(rs.getString("Population") + "\n");
			}
			rs.close();
			st.close();
			con.close();
		} catch (Exception e) {
			System.out.println("연결 실패 : " + e.getMessage());
		}			
	}

}
