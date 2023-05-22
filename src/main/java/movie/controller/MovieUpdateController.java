package movie.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import movie.model.MovieBean;
import movie.model.MovieDao;

@Controller
public class MovieUpdateController {
	
	private final String command = "update.mv";
	private String getPage = "movieUpdateForm";
	private String gotoPage = "redirect:/list.mv";
	
	@Autowired
	MovieDao movieDao;
	
	@RequestMapping(value = command, method = RequestMethod.GET)
	public String doAction(
			@RequestParam("num") String num, 
			@RequestParam("pageNumber") int pageNumber, 
			Model model) {
		
		MovieBean movie = movieDao.getByNum(num); 
		model.addAttribute("movieBean", movie);
		model.addAttribute("pageNumber", pageNumber);
		return getPage;
	}
	
	@RequestMapping(value = command, method = RequestMethod.POST)
	public ModelAndView doAction(
			@RequestParam("pageNumber") int pageNumber,
			@ModelAttribute("movieBean") @Valid MovieBean movie, 
			BindingResult result) {
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("pageNumber", pageNumber);
		
		if(result.hasErrors()) {
			mav.setViewName(getPage);
		}else {
			int cnt = movieDao.updateMovie(movie);
			
			if(cnt != -1) { // 성공
				mav.setViewName(gotoPage);
			}else { //실패
				mav.setViewName(getPage);
			}
		}
		
		return mav;
	}
}
