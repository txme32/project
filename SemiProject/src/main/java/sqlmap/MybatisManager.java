package sqlmap;

import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MybatisManager {
	//Mybatis의 sqlSession객체 생성
	private static SqlSessionFactory instance;
	
	private MybatisManager() {
		
	}
	
	public static SqlSessionFactory getInstance() {
		Reader reader = null;
		try {
			//getResourceAsReader는 Java Resource의 src의 xml을 읽어들이는 메소드
			reader = Resources.getResourceAsReader("sqlmap/sqlMapConfig.xml");
			instance = new SqlSessionFactoryBuilder().build(reader);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(reader != null) reader.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		
		return instance;
	}
}
