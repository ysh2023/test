package movie.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import movie.model.MovieDao;

@Controller
public class MovieDeleteController {
	private final String command = "/delete.mv";
	private final String getPage = "redirect:/list.mv";

	@Autowired 
	MovieDao mdao;

	@RequestMapping(command)
	public ModelAndView doAction(@RequestParam("num") String num,
			@RequestParam("pageNumber") String pageNumber) {
		ModelAndView mav = new ModelAndView();
		int cnt = -1;
		cnt = mdao.deleteMovie(num);
		if(cnt!=-1) {
			System.out.println("delete 성공");
		}else {
			System.out.println("delete 실패");
		}
		mav.addObject("pageNumber", pageNumber);
		mav.setViewName(getPage);
		return mav;
	}
}
