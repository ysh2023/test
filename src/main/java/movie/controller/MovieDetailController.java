package movie.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import movie.model.MovieBean;
import movie.model.MovieDao;

@Controller
public class MovieDetailController {
	private final String command = "/detail.mv";
	private final String getPage = "MovieDetailForm";
	
	@Autowired
	MovieDao mdao;
	
	@RequestMapping(value=command)
	public ModelAndView doAction(@RequestParam("num") String num,
			@RequestParam("pageNumber") String pageNumber
			) {
		ModelAndView mav = new ModelAndView();
		
		MovieBean movie = mdao.getByNum(num);
		
		mav.addObject("movie", movie);
		mav.addObject("pageNumber",pageNumber);
		mav.setViewName(getPage);
		return mav;
	}
}
