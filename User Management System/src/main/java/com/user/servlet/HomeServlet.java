package com.user.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.user.model.User;

public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private List<User> userList = null;
	Connection con = null;
	PreparedStatement ps = null;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		userList = new ArrayList<>();
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String country = request.getParameter("country");

		try {
			System.out.println("Connecting...........");
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost/mydatabase", "root", "root");
			ps = con.prepareStatement("insert into user (uname,email,country) values(?,?,?)");
			ps.setString(1, name);
			ps.setString(2, email);
			ps.setString(3, country);
			
			ps.execute();
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}

		User newUser = new User(userList.size() + 1, name, email, country);
		userList.add(newUser);
		request.setAttribute("userList", userList);
		request.getRequestDispatcher("index.jsp").forward(request, response);
		System.out.println(userList.size());
		System.out.println(newUser);
	}

}
