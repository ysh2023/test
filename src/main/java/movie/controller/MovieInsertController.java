package movie.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import movie.model.MovieBean;
import movie.model.MovieDao;

@Controller
public class MovieInsertController {
	private final String command = "/insert.mv";
	private final String getPage = "MovieInsertForm";
	private final String goPage = "redirect:/list.mv";
	
	@Autowired
	MovieDao mdao;
	
	@RequestMapping(value=command,method = RequestMethod.GET)
	public String doAction() {
		return getPage;
	}
	
	@RequestMapping(value=command,method = RequestMethod.POST)
	public ModelAndView doAction(@ModelAttribute("movie") @Valid MovieBean movie,BindingResult result) {
		System.out.println("MovieInsert:"+movie.getTitle());
		
		ModelAndView mav = new ModelAndView();
		int cnt = -1;
		if(result.hasErrors()) {
			mav.setViewName(getPage);
		}else {
			cnt = mdao.insertMovie(movie);
			if(cnt != -1) {//insert 성공
				mav.setViewName(goPage);
			}else {//insert 실패
				mav.setViewName(getPage);
			}
		}
		return mav;
	}
	
}
