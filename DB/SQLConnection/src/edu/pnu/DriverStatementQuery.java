package edu.pnu;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class DriverStatementQuery {

	
	public static void main(String[] args) throws SQLException, ClassNotFoundException {
		String driver = "com.mysql.cj.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/world";
		String username = "scott";
		String password = "tiger";
		
		Class.forName(driver);
		System.out.println("로딩 성공");
	
		Connection con = DriverManager.getConnection(url, username, password);
		System.out.println("연결 성공");
		
		Statement st = con.createStatement();
			
		try(Scanner sc = new Scanner(System.in)){
			while(true) {
				System.out.println("=".repeat(80));
				System.out.println(">>Select[0:Exit]");
				System.out.println("1. 수도 이름과 함께 국가 이름을 검색합니다. (WHERE C.CAPITAL = CI.ID)");
				System.out.println("2. 세계에서 인구가 가장 많은 상위 5개 도시의 이름과 인구를 검색합니다. 결과를 인구별로 내림차순으로 정렬합니다. (ORDER BY POPULATION DESC)");
				System.out.println("3. 미국(United States)에 있는 모든 도시의 이름을 검색합니다.");
				System.out.println("4. 중국(China)에서 사용되는 모든 언어의 이름을 검색합니다.");
				System.out.println("5. 인구가 100만 명 이상인 유럽 국가의 이름을 검색합니다.");
				System.out.println("6. 1900년 이후 독립한 국가의 이름을 검색합니다.");
				System.out.println("7. 영어가 공용어가 아니고 국민총생산(GNP)이 1,000보다 큰 국가의 이름을 검색합니다.");
				int sel = sc.nextInt();
				System.out.println("=".repeat(80));
				if(sel == 0) break;
				switch(sel) {
				case 1: query1(st); break;
				case 2: query2(st); break;
				case 3: query3(st); break;
				case 4: query4(st); break;
				case 5: query5(st); break;
				case 6: query6(st); break;
				case 7: query7(st); break;
				default:		  break;
				}
			}
			st.close();
			con.close();
			System.out.println("Done~~~");
		}
		catch(Exception e) {
			System.out.println();
		}
	
	}
	
	private static void printResultSet(ResultSet rs) throws SQLException {
		ResultSetMetaData meta = rs.getMetaData();
		int count = meta.getColumnCount();
		while(rs.next()) {
			for(int i = 1; i <= count; i++) {
				System.out.print(rs.getString(i) + ((i == count) ? "" : ","));
			}
			System.out.println();
		}
		rs.close();
	}

	private static void query1(Statement st) throws SQLException {
		String sql = "SELECT t.name Capital, c.name Nation "
					+ "FROM country c, city t "
					+ "WHERE c.Capital = t.ID";
		printResultSet(st.executeQuery(sql));
	}
	
	private static void query2(Statement st) throws SQLException {
		printResultSet(st.executeQuery("SELECT Name, Population FROM city ORDER BY Population DESC LIMIT 5"));
	}
	
	private static void query3(Statement st) throws SQLException {
		printResultSet(st.executeQuery("SELECT c.Name, ct.Name FROM country c, city ct WHERE c.Name = 'United States' AND c.Code = ct.CountryCode"));
	}
	private static void query4(Statement st) throws SQLException {
		printResultSet(st.executeQuery("SELECT c.Code, c.Name, cl.Language FROM country c, countrylanguage cl WHERE c.Name = 'China' AND c.Code = cl.CountryCode"));
	}
	private static void query5(Statement st) throws SQLException {
		printResultSet(st.executeQuery("SELECT Code, Name FROM country WHERE Continent = 'Europe' AND Population >= 1000000"));
	}
	private static void query6(Statement st) throws SQLException {
		printResultSet(st.executeQuery("SELECT Code, Name, IndepYear FROM country WHERE IndepYear > 1900"));
	}
	private static void query7(Statement st) throws SQLException {
		printResultSet(st.executeQuery("SELECT c.Name, cl.Language, cl.IsOfficial FROM CountryLanguage cl, country c WHERE cl.Language = 'English' AND cl.IsOfficial = 'F' AND cl.CountryCode = c.Code AND c.GNP > 1000"));
	}

}