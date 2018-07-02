package com.project.controller;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class MainController {
	

	@GetMapping("/")
	public String home(HttpServletRequest request){
		request.setAttribute("mode", "MODE_HOME");
		return "index";
		/*System.out.println("rr");
		request.setAttribute("mode", "Home_Page");
		return "mainPage";*/
	}
	
	@GetMapping("/mainPage")
	public String homePage(HttpServletRequest request){
		System.out.println("rr");
		request.setAttribute("mode", "Home_Page");
		return "mainPage";
	}
	
}
