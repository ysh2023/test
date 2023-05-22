package movie.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Component;

import utility.Paging;

@Component("myMovieDao")
public class MovieDao {
	private String namespace = "movie.MovieBean";
	
	@Autowired //root-context.xml에서 만든 SqlSessionTemplate 객체생성
	SqlSessionTemplate sqlSessionTemplate;
	
	public MovieDao() {
		System.out.println("MovieDao()");
	}

	public List<MovieBean> getAllMovie(Paging pageInfo, Map<String, String> map) {
		List<MovieBean> lists = new ArrayList<MovieBean>();
		RowBounds rowBounds = new RowBounds(pageInfo.getOffset(), pageInfo.getLimit());
		lists = sqlSessionTemplate.selectList(namespace+".GetMovieList",map,rowBounds);
		return lists;
	}

	public int getTotalCount(Map<String, String> map) {
		int cnt = 0;
		cnt = sqlSessionTemplate.selectOne(namespace+".GetTotalCount",map);

		return cnt;
	}

	public int insertMovie(MovieBean movie) {
		int cnt = -1;
		try {
			cnt = sqlSessionTemplate.insert(namespace+".InsertMovie",movie);
		}catch(DataAccessException e) {
			
		}
		System.out.println("insertCnt:"+cnt);
		return cnt;
	}

	public boolean searchId(String moviechk) {
		boolean flag = false;
		MovieBean result = sqlSessionTemplate.selectOne(namespace+".GetTitleCheck",moviechk);
		if(result != null) {
			flag = true;
		}
		return flag;
	}

	public MovieBean getByNum(String num) {
		MovieBean movie = sqlSessionTemplate.selectOne(namespace+".GetOneMovie",num);
		return movie;
	}

	public int deleteMovie(String num) {
		int cnt = -1;
		cnt = sqlSessionTemplate.delete(namespace+".DeleteMovie",num); //num을 넘긴다.
		System.out.println("cnt:"+cnt);
		return cnt;
	}
	
	public int updateMovie(MovieBean movie) {
		int cnt = -1;
		try {
			cnt = sqlSessionTemplate.update(namespace+".UpdateMovie", movie);
			System.out.println("update cnt: "+ cnt);
			
		}catch(DataAccessException e) {
			
		}
		return cnt;
	}


	
}
