package com.user.crud;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.user.model.User;

public class CrudUser {
	private static List<User> uList = null;

	public static List<User> selectAllUser() {
		String name, email, country;
		int id;

		try(Connection conn = JdbcUtil.createDbConn(); 
				PreparedStatement ps = conn.prepareStatement("select * from user;");
				ResultSet rs = ps.executeQuery()) {

			uList = new ArrayList<>();
			while (rs.next()) {
				id = rs.getInt(1);
				name = rs.getString(2);
				email = rs.getString(3);
				country = rs.getString(4);

				User user = new User(id, name, email, country);
				uList.add(user);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return uList; 

	}

	public static void updateUserDb(User user) {
		try(Connection conn = JdbcUtil.createDbConn(); 
				PreparedStatement ps = conn.prepareStatement("UPDATE user SET uname=?, email=?, country=? where id = ? ");) {
			int id = user.getId();
			String name = user.getName();
			String email = user.getEmail();
			String country = user.getCountry();
			
			ps.setString(1, name);
			ps.setString(2, email);
			ps.setString(3, country);
			ps.setInt(4, id);
			int rowsUpdated = ps.executeUpdate();
			System.out.println(rowsUpdated+" row updated with: "+user);
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}

	public static void deleteUserDb(int id) {
		try(Connection conn = JdbcUtil.createDbConn(); 
				PreparedStatement ps = conn.prepareStatement("DELETE FROM user where id = ? ");) {
			ps.setInt(1, id);
			int rowsUpdated = ps.executeUpdate();
			System.out.println("Number of rows affected: "+rowsUpdated);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public static void insertUserDb(User user) {
		try(Connection conn = JdbcUtil.createDbConn(); 
				PreparedStatement ps = conn.prepareStatement("INSERT INTO user(uname, email, country) VALUES(?,?,?);")) {
			String name = user.getName();
			String email = user.getEmail();
			String country = user.getCountry();
			
			ps.setString(1, name);
			ps.setString(2, email);
			ps.setString(3, country);
			int rowsUpdated = ps.executeUpdate();
			System.out.println("Number of rows affected: "+rowsUpdated);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
