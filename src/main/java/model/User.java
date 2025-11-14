package model;

public class User {
	private int id;
    private String username;
    private String password;
    private String fullname;
    private String phonenumber;
    private String emailaddress;
    private String address;

    // Constructors
    public User() {super();}

    public User(int id, String username, String password, 
                   String fullname, String phonenumber, String emailaddress, String address) {
    	this.id = id;
        this.username = username;
        this.password = password;
        this.fullname = fullname;
        this.phonenumber = phonenumber;
        this.emailaddress = emailaddress;
        this.address = address;
    }

    // Getters and Setters
    public String getUsername() {
        return username;
    }

    public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getPhonenumber() {
        return phonenumber;
    }

    public void setPhonenumber(String phonenumber) {
        this.phonenumber = phonenumber;
    }

    public String getEmailaddress() {
        return emailaddress;
    }

    public void setEmailaddress(String emailaddress) {
        this.emailaddress = emailaddress;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
