package edu.pnu;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

public class QueryByPreparedStatement {

	public static void main(String[] args) {
		
		Connection con = null;
		try {
			String driver = "com.mysql.cj.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/world";
			String username = "scott";
			String password = "tiger";
			
			Class.forName(driver);
			con = DriverManager.getConnection(url, username, password);
			
			String sql = "SELECT Id, Name, CountryCode, District, Population "
					   + "FROM city "
					   + "WHERE Name LIKE ? AND Population >= ? LIMIT ?";
			
			PreparedStatement pt = con.prepareStatement(sql);
			pt.setString(1, "S%");
			pt.setInt(2, 1000000);
			pt.setInt(3, 5);
			ResultSet rs = pt.executeQuery();
			
			while(rs.next()) {
				System.out.print(rs.getInt("Id") + ",");
				System.out.print(rs.getString("Name") + ",");
				System.out.print(rs.getString("CountryCode") + ",");
				System.out.print(rs.getString("District") + ",");
				System.out.print(rs.getInt("Population") + "\n");
			}
			
//			ResultSetMetaData meta = rs.getMetaData();
//			int count = meta.getColumnCount();
//			while(rs.next()) {
//				for(int i = 1; i <= count; i++) {
//					System.out.print(rs.getString(i) + ((i == count) ? "" : ","));
//				}
//				System.out.println();
//			}
			
			rs.close();
			pt.close();
			con.close();
		}catch (Exception e) {
			System.out.println("연결 실패 : " + e.getMessage());
		}

	}

}
