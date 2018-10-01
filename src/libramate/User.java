package libramate;

import java.util.ArrayList;
import java.io.*;
public class User implements Serializable{
	private String username;
	private String password;
	private String imageURL;
	private ArrayList<String> followers = new ArrayList<String>();
	private ArrayList<String> following = new ArrayList<String>();
	public Library library = new Library();
	public class Library implements Serializable{
		public ArrayList<String> read;
		public ArrayList<String> favorite;
		
		public Library() {
			this.read = new ArrayList<String>();
			this.favorite = new ArrayList<String>();
		}
		
		public ArrayList<String> getRead(){
			return this.read;
		}
		public ArrayList<String> getFavorite(){
			return this.favorite;
		}
	}
	public User(String name, String pw, String url) {
		this.username = name;
		this.password = pw;
		this.imageURL = url;
	}
	public String getName() {
		return this.username;
	}
	public String getPassword() {
		return this.password;
	}
	public String getImageURL() {
		return this.imageURL;
	}
	public ArrayList<String> getFollowers(){
		return this.followers;
	}
	public ArrayList<String> getFollowing(){
		return this.following;
	}
	public Library getlibrary() {
		return this.library;
	}
}
