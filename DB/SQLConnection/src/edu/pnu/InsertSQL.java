package edu.pnu;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

class User {
	private int id;
	private String pass;
	private String name;
	
	public User(int id, String pass, String name) {
		this.id = id;
		this.pass = pass;
		this.name = name;
	}
	
	public int getId() {
		return this.id;
	}
	
	public String getPass() {
		return this.pass;
	}

	public String getName() {
		return this.name;
	}
	
}

public class InsertSQL {
	private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
	private static final String URL = "jdbc:mysql://localhost:3306/musthave";
	private static final String USER = "scott";
	private static final String PASSWORD = "tiger";
	
	// SELECT 쿼리를 수행하여 결과를 반환하는 메서드
	private static ResultSet selectMember(Connection con) throws SQLException {
		String selectSql = "SELECT * FROM member";
		try(PreparedStatement selPs = con.prepareStatement(selectSql)) {
			return selPs.executeQuery();			
		}
	}
	
<<<<<<< HEAD
=======
	// 다음 ID 값을 반환하는 메서드
>>>>>>> 0ece37139aeba08882f2416a116482663b141aef
	private static int getNextId(Connection con) throws SQLException {
		String sql = "SELECT MAX(id) FROM member";
		try(PreparedStatement selMaxIdPs = con.prepareStatement(sql);
			ResultSet rs = selMaxIdPs.executeQuery()) {
			if(rs.next() ) {
				return rs.getInt(1) + 1;		// 최대 ID값에 1을 더한 값을 반환
			} else {
				return 1;		// 만약 테이블에 회원이 없는 경우, ID는 1부터 시작한다고 가정
			}
		}
	}
	
	// 회원 정보를 삽입하는 메서드
	private static int insertMember(Connection con, Scanner sc) throws SQLException {
		System.out.println("Insert Data");
		int id = getNextId(con);
		System.out.print("pass:");		String pass = sc.next();
		System.out.print("name:");		String name = sc.next();
		String sql = "INSERT INTO member(id, pass, name) VALUES(?, ?, ?)";
		try(PreparedStatement psmt = con.prepareStatement(sql)) {
			psmt.setInt(1, id);
			psmt.setString(2, pass);
			psmt.setString(3, name);
			return psmt.executeUpdate();
		}
	}	

	// 회원 정보를 업데이트하는 메서드
	private static int updateMember(Connection con, Scanner sc) throws SQLException {
		System.out.println("Update Data");
		System.out.print("id:");		int id = sc.nextInt();
		System.out.print("pass:");		String pass = sc.next();
		System.out.print("name:");		String name = sc.next();
		String sql = "UPDATE member SET pass=?, name=? WHERE id=?";
		try(PreparedStatement psmt = con.prepareStatement(sql)) {
			psmt.setString(1, pass);
			psmt.setString(2, name);
			psmt.setInt(3, id);
			return psmt.executeUpdate();
		}
	}
	
	// 회원 정보를 삭제하는 메서드
    private static int deleteMember(Connection con, Scanner sc) throws SQLException {
    	System.out.println("Delete Data");
    	System.out.print("id:");		int id = sc.nextInt();
    	String sql = "DELETE FROM member WHERE id=?";
    	try(PreparedStatement psmt = con.prepareStatement(sql)) {
    		psmt.setInt(1, id);
    		return psmt.executeUpdate();
    	}
    }
    

	public static void main(String[] args) {
		try(Scanner sc = new Scanner(System.in)){
			Class.forName(DRIVER);		// JDBC 드라이버를 로드하고 데이터베이스에 연결
			
			try(Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {
				boolean flag = true;
				while(flag) {
					System.out.println("[I]nsert/[U]pdate/[D]elete/[E]xit");		// 사용자에게 [I]nsert, [U]pdate, [D]elete, [E]xit 옵션을 제공
					String choice = sc.next().toLowerCase();
					switch(choice) {		// 각 옵션에 따라 insertMember, updateMember, deleteMember 메서드를 호출
					case "i": insertMember(con, sc); break;
					case "u": updateMember(con, sc); break;
					case "d": deleteMember(con, sc); break;
					case "e": flag = false; break;
					default: System.out.println("Invalid choice. Please choose again."); break;
					}
				}	
			
				// 회원 정보를 조회 출력
				try (ResultSet rs = selectMember(con)) {
					while (rs.next()) {
						System.out.print(rs.getInt("id") + ", ");
						System.out.print(rs.getString("pass") + ", ");
						System.out.print(rs.getString("name") + "\n");
					}		
				}
			} catch (SQLException e) {
				System.out.println("연결 실패 : " + e.getMessage());				
			}
<<<<<<< HEAD
			
		}catch (Exception e) {		// 예외 처리
			System.out.println("로딩 실패 : " + e.getMessage());
=======
		} catch (ClassNotFoundException e) {		// 예외 처리
			System.out.println("JDBC 드라이버를 찾을 수 없습니다: " + e.getMessage());
>>>>>>> 0ece37139aeba08882f2416a116482663b141aef
		}
	}	
}
