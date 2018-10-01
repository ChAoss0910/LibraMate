package libramate;

import java.util.ArrayList;
import java.io.*;
public class Data implements Serializable{
	private ArrayList<User> users;
	public Data(ArrayList<User> users) {
		this.users = users;
	}
	public ArrayList<User> getUsers(){
		return this.users;
	}
}
