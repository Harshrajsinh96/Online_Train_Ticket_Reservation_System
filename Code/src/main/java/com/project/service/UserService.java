package com.project.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.stereotype.Service;

import com.project.dao.UserRepository;
import com.project.model.User;



@Service
@Transactional
public class UserService {
	
	private final UserRepository userRepo;
	
	
	public UserService(UserRepository userRepo){
		this.userRepo = userRepo;
	}

	public User register(String email, String password, String firstName, String lastName) {
		
		for(User p:userRepo.findAll()){
			if(p.getEmail().equals(email)){
				return null;
			}
		}
		
		User user = new User(email,password,firstName,lastName);
		userRepo.save(user);
		return user;
	}

	public User login(String email, String password) {
		
		for(User p:userRepo.findAll()){
			if(p.getEmail().equals(email) && p.getPassword().equals(password)){
				return p;
			}
		}
		return null;
	}


}
