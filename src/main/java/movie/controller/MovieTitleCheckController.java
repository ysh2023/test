package movie.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import movie.model.MovieDao;

@Controller
public class MovieTitleCheckController {
	private final String command = "/titlecheck.mv";
	private final String getPage = "MovieInsertForm";

	@Autowired 
	MovieDao mdao;

	@RequestMapping(command)
	@ResponseBody
	public String doAction(@RequestParam("moviechk") String moviechk, 
			HttpServletResponse response) {

		System.out.println("title_check_proc.mv");
		boolean result = mdao.searchId(moviechk);  

		if(result)  // 참 : 제목이미있음, 사용못함
			//response.getWriter().append("N");
			return "NO"; // web-inf\movie\NO.jsp X
		else
			//response.getWriter().append("Y");
			return "YES"; // web-inf\movie\YES.jsp X

	}
}
