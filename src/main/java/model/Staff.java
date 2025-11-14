package model;

public class Staff extends User {
    private String role;

    // Constructors
    public Staff() {
        super();
    }

    public Staff(String role, int id, String username, String password,
                 String fullname, String phonenumber, String emailaddress, String address) {
        super(id, username, password, fullname, phonenumber, emailaddress, address);
        this.role = role;
    }

    // Getters and Setters
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
