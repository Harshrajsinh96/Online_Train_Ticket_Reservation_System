package com.project.dao;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.transaction.annotation.Transactional;

import com.project.model.User;


public interface UserRepository extends CrudRepository<User, Integer>{
	@Modifying
	@Transactional
	@Query(value="select * from 275project.userdetails where email=? and password=?",nativeQuery=true)
	public User findUser(String user_email,String password);
	
}
