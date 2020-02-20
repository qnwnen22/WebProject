package config;
// DB연결 설정 파일
import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DB {
	public static Connection getConn() {
//		context.xml에 설정된 dbcp에서 커넥션을 가져옴
		DataSource ds=null;
		Connection conn=null;
		try {
			Context ctx = new InitialContext();

//			context.xml의 Resource태그 검색
			ds=(DataSource)ctx.lookup("java:comp/env/oraDB");
			
			conn=ds.getConnection(); //커넥션 할당받음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;//커넥션 리턴
	}//end getConn()
	
	public static Connection getConn2() {
//		context.xml에 설정된 dbcp에서 커넥션을 가져옴
		DataSource ds=null;
		Connection conn=null;
		try {
			Context ctx = new InitialContext();

//			context.xml의 Resource태그 검색
			ds=(DataSource)ctx.lookup("java:comp/env/oraDB2");
			
			conn=ds.getConnection(); //커넥션 할당받음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;//커넥션 리턴
	}//end getConn2()
}//end DB
